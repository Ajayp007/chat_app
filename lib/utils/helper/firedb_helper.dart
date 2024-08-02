import 'package:chat_app/screen/profile/model/profile_model.dart';
import 'package:chat_app/utils/helper/fireauth_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../screen/chat/model/chat_model.dart';

class FireDbHelper {
  static FireDbHelper helper = FireDbHelper._();

  FireDbHelper._();

  FirebaseFirestore fireStore = FirebaseFirestore.instance;
  String? uId;
  String? id;

  String getUserID() {
    return uId = FireAuthHelper.helper.user!.uid;
  }

  Future<void> getUser(ProfileModel m1) async {
    getUserID();
    await fireStore.collection('user').doc(uId).set(m1.modelToMap());
  }

  Future<ProfileModel> currentUser() async {
    getUserID();
    DocumentSnapshot snapshot =
        await fireStore.collection('user').doc(uId).get();
    Map? m1 = snapshot.data() as Map?;
    ProfileModel model =
        ProfileModel.mapToModel(m1 ?? {'name': '', 'email': '', 'mobile': ''});
    return model;
  }

  Future<List<ProfileModel>> getAllUser(ProfileModel m1) async {
    List<ProfileModel> list = [];

    QuerySnapshot querySnapshot = await fireStore
        .collection('user')
        .where("mobile", isNotEqualTo: m1.mobile)
        .get();
    List<QueryDocumentSnapshot> l1 = querySnapshot.docs;
    for (var x in l1) {
      var a = x.id;
      Map m1 = x.data() as Map;
      ProfileModel model = ProfileModel.mapToModel(m1);
      model.uId = a;
      list.add(model);
    }
    return list;
  }

  Future<void> checkChatId(
      String myId, String user2id, DateTime date, String message) async {
    if (id == null) {
      DocumentReference dr = await fireStore
          .collection('chat')
          .add({'Userid1': myId, 'Userid2': user2id});
      id = dr.id;
      sendMessage(id: id!, message: message, date: date);
    } else {
      sendMessage(id: id!, message: message, date: date);
    }
  }

  Future<String?> getChatDocId(String myId, String user2id) async {
    QuerySnapshot qs = await fireStore
        .collection('chat')
        .where('Userid1', isEqualTo: myId)
        .where('Userid2', isEqualTo: user2id)
        .get();
    List<QueryDocumentSnapshot> l1 = qs.docs;
    if (l1.isNotEmpty) {
      id = l1[0].id;
      return id;
    } else {
      QuerySnapshot qs = await fireStore
          .collection('chat')
          .where('Userid2', isEqualTo: myId)
          .where('Userid1', isEqualTo: user2id)
          .get();
      List<QueryDocumentSnapshot> l2 = qs.docs;
      if (l2.isNotEmpty) {
        id = l2[0].id;
        return id;
      } else {
        id = null;
        return id;
      }
    }
  }

  void sendMessage(
      {required String id, required String message, required DateTime date}) {
    fireStore.collection('chat').doc(id).collection('msg').add(
      {
        "message": message,
        'uid': FireAuthHelper.helper.user!.uid,
        "datetime": date
      },
    );
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> chatMessages() {
    return fireStore
        .collection('chat')
        .doc(id)
        .collection('msg')
        .orderBy('datetime')
        .snapshots();
  }

  void deleteMyChat(String uid) {
    fireStore.collection('chat').doc(id).collection('msg').doc(uid).delete();
  }

  Future<void> chatWithUser() async {
    List<ChatModel> userChat = [];
    QuerySnapshot qs = await fireStore
        .collection('chat')
        .where("Userid1", isEqualTo: FireAuthHelper.helper.user!.uid)
        .get();
    QuerySnapshot qs2 = await fireStore
        .collection('chat')
        .where("Userid2", isEqualTo: FireAuthHelper.helper.user!.uid)
        .get();

    List<Map> m1 = qs.docs as List<Map>;
    List<Map> m2 = qs2.docs as List<Map>;

  }

}
