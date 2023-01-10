import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GoogleAuth {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  //SIGN IN GOOGLE
  Future<User?> signInWithGoogle() async {
    try {
      //SIGNING IN WITH GOOGLE
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;

      //CREATING CREDENTIAL FOR FIREBASE
      final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);

      //SIGNING IN WITH CREDENTIAL & MAKING A USER IN FIREBASE  AND GETTING USER CLASS
      final userCredential = await _auth.signInWithCredential(credential);
      final User? user = userCredential.user;

      //CHECKING IS ON
      assert(!user!.isAnonymous);
      assert(await user!.getIdToken() != null);

      final User? currentUser = _auth.currentUser;
      assert(currentUser!.uid == user!.uid);
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.setString('UID', currentUser!.uid);
      sharedPreferences.setString('email', currentUser.email.toString());
      if (kDebugMode) {
        print(user);
      }

      return user;
    } catch (e) {
      print(e);
    }
  }
}
