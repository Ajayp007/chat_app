import 'package:chat_app/screen/user/controller/user_controller.dart';
import 'package:chat_app/utils/helper/fireauth_helper.dart';
import 'package:chat_app/utils/helper/firedb_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  UserController controller = Get.put(UserController());

  @override
  void initState() {
    super.initState();
    controller.getAllUser();
  }

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
      body: Obx(
        () => ListView.builder(
          itemCount: controller.l1.length,
          itemBuilder: (context, index) {
            return ListTile(
              onTap: () async {
                await FireDbHelper.helper.getChatDocId(
                    FireAuthHelper.helper.user!.uid, controller.l1[index].uId!);

                Get.toNamed('chat', arguments: controller.l1[index]);
              },
              leading: const CircleAvatar(
                radius: 40,
              ),
              title: Text("${controller.l1[index].name}"),
              subtitle: Text("+91 ${controller.l1[index].mobile}"),
            );
          },
        ),
      ),
    );
  }
}
