import 'package:chat_app/utils/helper/fireauth_helper.dart';
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
      appBar: AppBar(),
      drawer: Drawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            InkWell(
              onTap: () {
                FireAuthHelper.helper.signOutAuth();
                Get.toNamed('signIn');
              },
              child: const ListTile(
                title: Text("Sign Out"),
                trailing: Icon(Icons.logout_outlined),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
