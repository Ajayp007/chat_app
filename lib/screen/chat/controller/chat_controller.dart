
import 'package:chat_app/utils/helper/fireauth_helper.dart';
import 'package:chat_app/utils/helper/firedb_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  Future<void> sendMassage(
      String user2id, DateTime date, String message) async {
    await FireDbHelper.helper.checkChatId(
        FireAuthHelper.helper.user!.uid, user2id, date, message);
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> chatMessages() {
    return FireDbHelper.helper.chatMessages();
  }
}

