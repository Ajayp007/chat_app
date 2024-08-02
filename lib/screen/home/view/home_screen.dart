import 'package:chat_app/utils/helper/fireauth_helper.dart';
import 'package:chat_app/utils/services/notification_services.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
              NotificationServices.notify.simpleNotification();
              //NotificationServices.notify.scheduleNotification();
            },
            icon: const Icon(Icons.notification_add_outlined),
          ),
          IconButton(
            onPressed: () {
              Get.toNamed('user');
            },
            icon: const Icon(Icons.person_2_outlined),
          ),
        ],
      ),
      drawer: Drawer(
        backgroundColor: const Color(0xff084759),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ListTile(
              onTap: () {
                FireAuthHelper.helper.signOutAuth();
                Get.toNamed('signIn');
              },
              iconColor: Colors.white,
              textColor: Colors.white,
              title: const Text("Sign Out"),
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
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return  ListTile(
            onTap: () {
              Get.toNamed('chat');
            },
            leading: CircleAvatar(),
            title: Text("Name"),
            subtitle: Text("+91 8140986630"),
          );
        },
      ),
    );
  }
}
