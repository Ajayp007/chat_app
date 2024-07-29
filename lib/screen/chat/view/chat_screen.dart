import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff084759),
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Name",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 20,
              itemBuilder: (context, index) {
                return Container(
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  alignment: index % 2 == 0
                      ? Alignment.centerLeft
                      : Alignment.centerRight,
                  width: MediaQuery.sizeOf(context).width,
                  child: Container(
                    height: 80,
                    alignment: Alignment.centerLeft,
                    width: MediaQuery.sizeOf(context).width * 0.8,
                    padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: const Color(0xff084759),
                    ),
                    child: const Text(
                      "Hello",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            height: 80,
            margin: const EdgeInsets.all(12),
            padding: const EdgeInsets.all(12),
            width: MediaQuery.sizeOf(context).width,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),color: const Color(0xff084759),),
            child: const TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black)
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
