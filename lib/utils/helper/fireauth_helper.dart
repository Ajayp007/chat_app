import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/route_manager.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FireAuthHelper {
  static FireAuthHelper helper = FireAuthHelper._();

  FireAuthHelper._();

  User? user;

  Future<void> signInAuth(emailAddress, password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAddress, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Get.snackbar(e.code, "");
      } else if (e.code == 'wrong-password') {
        Get.snackbar(e.code, "");
      }
      Get.snackbar(e.code, "");
    }
  }

  Future<String> signUpAuth(emailAddress, password) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailAddress, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Get.snackbar(e.code, "");
      } else if (e.code == 'email-already-in-use') {
        Get.snackbar(e.code, "");
      }
      Get.snackbar(e.code, "");
    }
    return "Error";
  }

  bool checkUser() {
    user = FirebaseAuth.instance.currentUser;
    return user != null;
  }

  Future<void> signOutAuth() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
  }

  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
