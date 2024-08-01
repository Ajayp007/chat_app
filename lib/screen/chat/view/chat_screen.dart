import 'package:chat_app/screen/chat/controller/chat_controller.dart';
import 'package:chat_app/screen/chat/model/chat_model.dart';
import 'package:chat_app/screen/profile/model/profile_model.dart';
import 'package:chat_app/utils/helper/fireauth_helper.dart';
import 'package:chat_app/utils/helper/firedb_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  ProfileModel model = Get.arguments;
  ChatController controller = Get.put(ChatController());
  TextEditingController txtMsg = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller.chatMessages();
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
      body: Column(
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
                      itemCount: chatModelList.length,
                      itemBuilder: (context, index) {
                        return Align(
                          alignment: chatModelList[index].uid ==
                                  FireAuthHelper.helper.user!.uid
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: InkWell(
                            onLongPress: () {
                              Get.defaultDialog(
                                title: "delete chat",
                                actions: [
                                  IconButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    icon: const Icon(Icons.cancel),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      FireDbHelper.helper.deleteMyChat(
                                          chatModelList[index].docId!);
                                      Get.back();
                                    },
                                    icon: const Icon(Icons.delete),
                                  ),
                                ],
                              );
                            },
                            child: Text("${chatModelList[index].message}"),
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
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SearchBar(
              backgroundColor: WidgetStateProperty.all(
                const Color(0xff084759),
              ),
              hintStyle: WidgetStateProperty.all(
                const TextStyle(color: Colors.white),
              ),
              hintText: "Send a Message",
              trailing: [
                IconButton(
                  onPressed: () {
                    if (txtMsg.text.isEmpty) {
                      const Text("Send A Message");
                    } else {
                      controller.sendMassage(
                          model.uId!, DateTime.now(), txtMsg.text);
                      FireDbHelper.helper.chatMessages();
                    }
                  },
                  icon: const Icon(
                    Icons.send_outlined,
                    color: Colors.white,
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
