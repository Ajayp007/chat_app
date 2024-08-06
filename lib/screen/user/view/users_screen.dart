import 'package:chat_app/screen/user/controller/user_controller.dart';
import 'package:chat_app/utils/helper/fireauth_helper.dart';
import 'package:chat_app/utils/helper/firedb_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
          itemCount: controller.userModelList.length,
          itemBuilder: (context, index) {
            return ListTile(
              onTap: () async {
                await FireDbHelper.helper.getChatDocId(
                    FireAuthHelper.helper.user!.uid, controller.userModelList[index].id!);

                Get.toNamed('chat', arguments: controller.userModelList[index]);
              },
              leading: CircleAvatar(
                radius: 40,
                backgroundColor: const Color(0xff084759),
                child: Text(
                  controller.userModelList[index].name![0],
                  style: const TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
              title: Text("${controller.userModelList[index].name}"),
              subtitle: Text("+91 ${controller.userModelList[index].phone}"),
            );
          },
        ),
      ),
    );
  }
}
