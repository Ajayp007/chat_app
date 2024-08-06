import 'package:chat_app/screen/home/controller/home_controller.dart';
import 'package:chat_app/screen/profile/controller/profile_controller.dart';
import 'package:chat_app/utils/helper/fireauth_helper.dart';
import 'package:chat_app/utils/helper/firedb_helper.dart';
import 'package:chat_app/utils/services/notification_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeController controller = Get.put(HomeController());
  ProfileController profileController = Get.put(ProfileController());

  @override
  void initState() {
    super.initState();
    profileController.getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff084759),
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Chat App",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () {
              //NotificationServices.notify.simpleNotification();
              NotificationServices.notify.scheduleNotification();
            },
            icon: const Icon(Icons.notification_add_outlined),
          ),
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 50, left: 12),
              alignment: Alignment.topLeft,
              height: MediaQuery.sizeOf(context).height * 0.16,
              width: MediaQuery.sizeOf(context).width,
              color: const Color(0xff084759),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 35,
                    backgroundColor: Colors.white,
                    child: Text(
                      profileController.model.value.name![0],
                      style: const TextStyle(fontSize: 35,color:  Color(0xff084759)),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        profileController.model.value.name!,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      Text(
                        "+91 ${profileController.model.value.mobile}",
                        style:
                            const TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            ListTile(
              onTap: () {
                Get.back();
              },
              leading: const Icon(
                Icons.home_outlined,
                size: 30,
              ),
              title: const Text(
                "Home",
                style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),
              ),
            ),
            const Divider(),
            ListTile(
              onTap: () {
                Get.toNamed('all');
              },
              leading: const Icon(
                Icons.chat_bubble_outline,
                size: 28,
              ),
              title: const Text(
                "My Chats",
                style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),
              ),
            ),
            const Divider(),
            ListTile(
              onTap: () {
                Get.toNamed('user');
              },
              leading: const Icon(
                Icons.person_2_outlined,
                size: 30,
              ),
              title: const Text(
                "My Profile",
                style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),
              ),
            ),
            const Divider(),
            const Spacer(),
            ListTile(
              onTap: () {
                FireAuthHelper.helper.signOutAuth();
                Get.toNamed('signIn');
              },
              iconColor: Colors.black,
              textColor: Colors.black,
              title: const Text("Sign Out",style: TextStyle(fontWeight: FontWeight.w500),),
              trailing: const Icon(Icons.logout_outlined),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed('all');
        },
        backgroundColor: const Color(0xff084759),
        child: const Icon(
          Icons.chat,
          color: Colors.white,
        ),
      ),
      body:  StreamBuilder(
        stream: FireDbHelper.helper.chatWithUser(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("${snapshot.error}");
          } else if (snapshot.hasData) {
            controller.userList.clear();

            QuerySnapshot? qs = snapshot.data;
            List<QueryDocumentSnapshot> qds = qs!.docs;
            for (var x in qds) {
              Map m1 = x.data() as Map;

              if (m1['Userid1'] == FireAuthHelper.helper.user!.uid) {
                FireDbHelper.helper
                    .getAllChat(m1['Userid2'])
                    .then(
                      (value) {
                    controller.userList.add(value);
                  },
                );
              } else if (m1['Userid2'] ==
                  FireAuthHelper.helper.user!.uid) {
                FireDbHelper.helper
                    .getAllChat(m1['Userid1'])
                    .then(
                      (value) {
                    controller.userList.add(value);
                  },
                );
              }
            }

            return Obx(
                  () => ListView.builder(
                itemCount: controller.userList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () async {
                      await FireDbHelper.helper.getChatDocId(
                          FireAuthHelper.helper.user!.uid,
                          controller.userList[index].id!);
                      Get.toNamed('chat',
                          arguments: controller.userList[index]);
                    },
                    leading: CircleAvatar(
                      backgroundColor: Colors.blue.shade100,
                      child: Text(controller.userList[index].name![0]),
                    ),
                    title: Text("${controller.userList[index].name}"),
                    subtitle: Text("${controller.userList[index].phone}"),
                  );
                },
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
