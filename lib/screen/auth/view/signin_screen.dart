import 'package:chat_app/screen/profile/controller/profile_controller.dart';
import 'package:chat_app/utils/helper/fireauth_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  ProfileController controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Image.asset(
                    "assets/logo/Login-pana (1).png",
                    height: 300,
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
                    controller: txtPassword,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)),
                        fillColor: Colors.grey,
                        labelText: "Password"),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Password is required";
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
                      onPressed: () async {
                        FireAuthHelper.helper
                            .signInAuth(txtEmail.text, txtPassword.text);

                        bool response = FireAuthHelper.helper.checkUser();
                        if (response) {
                          Get.offAllNamed('user');
                          await controller.getUserData();
                        }
                      },
                      child: const Text("Sign in"),
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Divider(
                    color: Colors.black,
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () async {
                          await FireAuthHelper.helper.signInWithGoogle();
                          FireAuthHelper.helper.checkUser();
                          Get.offAllNamed('user');
                        },
                        child: Image.asset(
                          "assets/logo/google.png",
                          fit: BoxFit.cover,
                          height: 50,
                        ),
                      ),
                      Image.asset(
                        "assets/logo/facebook.png",
                        fit: BoxFit.cover,
                        height: 50,
                      ),
                      Image.asset(
                        "assets/logo/a.png",
                        fit: BoxFit.cover,
                        height: 50,
                      )
                    ],
                  ),
                  const SizedBox(height: 50),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, 'signUp');
                    },
                    child: RichText(
                      text: const TextSpan(
                        children: [
                          TextSpan(
                            text: "Don't have an account?",
                            style: TextStyle(color: Colors.black, fontSize: 18),
                          ),
                          TextSpan(
                            text: " Create now",
                            style: TextStyle(
                                color: Color(0xff084759),
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
