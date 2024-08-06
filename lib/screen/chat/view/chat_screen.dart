import 'dart:async';

import 'package:chat_app/screen/chat/controller/chat_controller.dart';
import 'package:chat_app/screen/chat/model/chat_model.dart';
import 'package:chat_app/screen/user/model/user_model.dart';
import 'package:chat_app/utils/helper/fireauth_helper.dart';
import 'package:chat_app/utils/helper/firedb_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:get/get.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  UserModel model = Get.arguments;
  ChatController controller = Get.put(ChatController());
  TextEditingController txtMsg = TextEditingController();
  FocusNode node = FocusNode();
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    controller.chatMessages();
    node.addListener(
      () {
        if (node.hasFocus) {
          Future.delayed(
              const Duration(milliseconds: 300),
              scrollController.animateTo(
                  scrollController.position.maxScrollExtent,
                  duration: const Duration(seconds: 1),
                  curve: Curves.fastOutSlowIn) as FutureOr Function()?);
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
        backgroundColor: const Color(0xff084759),
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          "${model.name}",
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: Stack(
        children: [
          Image.network(
            "https://i.pinimg.com/736x/8c/98/99/8c98994518b575bfd8c949e91d20548b.jpg",
            height: MediaQuery.sizeOf(context).height,
            width: MediaQuery.sizeOf(context).width,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                StreamBuilder(
                  stream: FireDbHelper.helper.chatMessages(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    } else if (snapshot.hasData) {
                      List<ChatModel> chatModelList = [];
                      QuerySnapshot? query = snapshot.data;
                      List<QueryDocumentSnapshot> l1 = query!.docs;
                      for (var x in l1) {
                        var id = x.id;
                        Map m1 = x.data() as Map;

                        ChatModel model = ChatModel.mapToModel(m1);
                        model.docId = id;
                        chatModelList.add(model);
                      }
                      if (chatModelList.isEmpty) {
                        return const Center(
                          child: Text("Let's Start"),
                        );
                      } else {
                        return Expanded(
                          child: ListView.builder(
                            controller: scrollController,
                            itemCount: chatModelList.length,
                            itemBuilder: (context, index) {
                              return chatModelList[index].uid ==
                                      FireAuthHelper.helper.user!.uid
                                  ? ChatBubble(
                                      clipper: ChatBubbleClipper3(
                                          type: BubbleType.sendBubble),
                                      alignment: Alignment.topRight,
                                      margin: const EdgeInsets.only(top: 20),
                                      backGroundColor: const Color(0xff1a6b89),
                                      child: InkWell(
                                        onLongPress: () {
                                          Get.defaultDialog(
                                            title: "Delete Chat ?",
                                            middleText: "Yes Or No",
                                            onConfirm: () {
                                              FireDbHelper.helper.deleteMyChat(
                                                  chatModelList[index].docId!);
                                              Get.back();
                                            },
                                            onCancel: () {},
                                          );
                                        },
                                        child: Container(
                                          constraints: BoxConstraints(
                                            maxWidth: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.7,
                                          ),
                                          child: Text(
                                            "${chatModelList[index].message}",
                                            style: const TextStyle(
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    )
                                  : ChatBubble(
                                      clipper: ChatBubbleClipper3(
                                          type: BubbleType.receiverBubble),
                                      backGroundColor:
                                          Colors.white.withOpacity(0.9),
                                      margin: const EdgeInsets.only(top: 20),
                                      child: Container(
                                        constraints: BoxConstraints(
                                          maxWidth: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.7,
                                        ),
                                        child: Text(
                                          "${chatModelList[index].message}",
                                          style: const TextStyle(
                                              color: Colors.black),
                                        ),
                                      ),
                                    );
                            },
                          ),
                        );
                      }
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: MediaQuery.sizeOf(context).width * 0.80,
                        child: ColoredBox(
                          color: Colors.white,
                          child: TextField(
                            controller: txtMsg,
                            focusNode: node,
                            decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(
                                    color: Color(0xff084759),
                                  ),
                                ),
                                border: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Color(0xff084759),
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                hintText: "Send A Message...!"),
                          ),
                        ),
                      ),
                      IconButton.filled(
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all(
                            const Color(0xff084759),
                          ),
                        ),
                        color: Colors.white,
                        onPressed: () {
                          if (txtMsg.text.isEmpty) {
                            Get.snackbar("Enter", " Message",
                                backgroundColor: const Color(0xff084759),
                                colorText: Colors.white);
                          } else {
                            controller.sendMassage(
                                model.id!, DateTime.now(), txtMsg.text);
                            FireDbHelper.helper.chatMessages();
                            txtMsg.clear();
                          }
                        },
                        icon: const Icon(Icons.send_outlined),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
