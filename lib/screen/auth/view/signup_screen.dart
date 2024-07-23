import 'package:chat_app/utils/helper/fireauth_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();

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
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                Image.asset(
                  "assets/logo/Login-pana (1).png",
                  height: 300,
                ),
                const SizedBox(height: 30),
                TextFormField(
                  controller: txtEmail,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      fillColor: Colors.grey,
                      labelText: "Email"),
                ),
                const SizedBox(height: 30),
                TextFormField(
                  controller: txtPassword,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      fillColor: Colors.grey,
                      labelText: "Password"),
                ),
                const SizedBox(height: 30),
                InkWell(
                  onTap: () async {
                    String done = await FireAuthHelper.helper
                        .signUpAuth(txtEmail.text, txtPassword.text);
                    if (done == "Success") {
                      Get.offAllNamed('signIn');
                    } else {
                      Get.snackbar("Chat ", done);
                    }
                  },
                  child: Container(
                    height: 50,
                    width: MediaQuery.sizeOf(context).width,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: const Color(0xff084759),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(),
                    ),
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 19,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, 'signIn');
                  },
                  child: RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: "Already have an account?",
                          style: TextStyle(color: Colors.black, fontSize: 18),
                        ),
                        TextSpan(
                          text: " Sign In",
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
    );
  }
}
