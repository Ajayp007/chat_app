import 'package:chat_app/screen/profile/model/profile_model.dart';
import 'package:chat_app/screen/user/model/user_model.dart';
import 'package:chat_app/utils/helper/fireauth_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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

  Future<List<UserModel>> getAllUser(ProfileModel p1) async {
    List<UserModel> listData = [];
    //
    QuerySnapshot qs = await fireStore
        .collection('user')
        .where("mobile", isNotEqualTo: p1.mobile)
        .get();
    List<QueryDocumentSnapshot> document = qs.docs;

    for (var x in document) {
      var ket = x.id;
      Map m1 = x.data() as Map;

      UserModel model = UserModel.mapToModel(m1);
      model.id = ket;
      listData.add(model);
    }
    return listData;
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

  Stream<QuerySnapshot<Map<String, dynamic>>> chatWithUser()  {
    return fireStore.collection('chat').snapshots();
  }

  Future<UserModel> getAllChat(userid) async {
    DocumentSnapshot ds = await fireStore.collection('user').doc(userid).get();

    Map m1 = ds.data() as Map;

    UserModel model = UserModel.mapToModel(m1);
    model.id = ds.id;

    return model;
  }

}
