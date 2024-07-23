import 'package:flutter/material.dart';

class UserdetailScreen extends StatefulWidget {
  const UserdetailScreen({super.key});

  @override
  State<UserdetailScreen> createState() => _UserdetailScreenState();
}

class _UserdetailScreenState extends State<UserdetailScreen> {
  TextEditingController txtName = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtMobile = TextEditingController();

  @override
  void initState() {
    super.initState();
  }
  void userData()
  {

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About"),
        centerTitle: true,
      ),
      body:  Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 70,
              child: Icon(Icons.person,size: 80,color: Color(0xff084759),),
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
            ), TextFormField(
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
            InkWell(
              onTap: () {

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
                  "Submit",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 19,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
