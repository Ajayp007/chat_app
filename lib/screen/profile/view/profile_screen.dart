import 'package:chat_app/screen/profile/controller/profile_controller.dart';
import 'package:chat_app/utils/helper/firedb_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/profile_model.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController txtName = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtMobile = TextEditingController();
  ProfileController controller = Get.put(ProfileController());
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    userData();
  }

  Future<void> userData()
  async {
    await controller.getUserData();
    txtName.text = controller.model.value.name!;
    txtEmail.text = controller.model.value.email!;
    txtMobile.text = controller.model.value.mobile!;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff084759),
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "My Profile",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              const CircleAvatar(
                radius: 70,
                child: Icon(
                  Icons.person,
                  size: 80,
                  color: Color(0xff084759),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              TextFormField(
                keyboardType: TextInputType.name,
                controller: txtName,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                    fillColor: Colors.grey,
                    labelText: "Name"),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Name is required";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 30,
              ),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: txtEmail,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                    fillColor: Colors.grey,
                    labelText: "Email"),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Email is required";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 30,
              ),
              TextFormField(
                keyboardType: TextInputType.phone,
                controller: txtMobile,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                    fillColor: Colors.grey,
                    labelText: "Mobile"),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Mobile Number is required";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                width: MediaQuery.sizeOf(context).width,
                child: MaterialButton(
                  textColor: Colors.white,
                  height: 40,
                  color: const Color(0xff084759),
                  onPressed: ()  {
                    if(formKey.currentState!.validate())
                    {
                      ProfileModel model = ProfileModel(
                        name: txtName.text,
                        mobile: txtMobile.text,
                        email: txtEmail.text,
                      );
                      FireDbHelper.helper.getUser(model);
                    }
                    Get.toNamed('home');
                  },
                  child: const Text("Submit"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
