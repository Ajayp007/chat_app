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

                SizedBox(
                  width: MediaQuery.sizeOf(context).width,
                  child: MaterialButton(
                    textColor: Colors.white,
                    height: 40,
                    color: const Color(0xff084759),
                    onPressed: () async {
                      await FireAuthHelper.helper
                          .signUpAuth(txtEmail.text, txtPassword.text);
                      Get.offAllNamed('signIn');
                    },
                    child: const Text("Sign Up"),
                  ),
                ),
                const SizedBox(height: 30),
                InkWell(
                  onTap: () {
                    FireAuthHelper.helper.signUpAuth(txtEmail.text, txtPassword.text);
                    Get.offAllNamed('signIn');
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
