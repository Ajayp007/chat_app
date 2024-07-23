import 'package:chat_app/utils/helper/fireauth_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../screen/personal/model/personal_model.dart';

class FireDbHelper {
  static FireDbHelper helper = FireDbHelper._();

  FireDbHelper._();

  FirebaseFirestore fireStore = FirebaseFirestore.instance;
  String? uId;

  String getUserID() {
    return uId = FireAuthHelper.helper.user!.uid;
  }

  Future<void> getUser(PersonalModel m1) async {
    await fireStore.collection('user').doc(uId).set(m1.modelToMap());
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getUserData() {
    return fireStore.collection('user').doc(uId).get();
  }

  Future<void> currentUser() async {
    DocumentSnapshot snapshot =
        await fireStore.collection('user').doc(uId).get();
    Map m1 = snapshot.data() as Map;
    PersonalModel.mapToModel(m1);
  }
}
