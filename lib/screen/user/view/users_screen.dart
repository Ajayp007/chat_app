import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff084759),
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "All Users",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: ListView.builder(
        itemCount: 20,
        itemBuilder: (context, index) {
          return  ListTile(
            onTap: () {
              Get.toNamed('chat');
            },
            leading: CircleAvatar(
              radius: 40,
            ),
            title: Text("Name"),
            subtitle: Text("+91 8140986630"),
          );
        },
      ),
    );
  }
}
