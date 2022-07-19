import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:spotify_clone/models.dart/user.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:http/http.dart' as http;
import 'package:spotify_clone/pages/authenticate/signup.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  UserDat? _userFromFirebaseUser(User? user) {
    return user != null ? UserDat(uid: user.uid) : null;
  }

  Stream<UserDat?> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  Future SignInWithGoogle() async {
    User? user;

    if (kIsWeb) {
      GoogleAuthProvider authProvider = GoogleAuthProvider();

      try {
        final UserCredential userCredential =
            await _auth.signInWithPopup(authProvider);

        user = userCredential.user;
      } on PlatformException catch (e) {
        print(e);
        SignInWithGoogle();
      }
    } else {
      GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleUser.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );
        try {
          UserCredential result = await _auth.signInWithCredential(credential);
          User? user = result.user;
          return _userFromFirebaseUser(user);
        } catch (e) {
          print("Error ${e.toString()}");
          SignInWithGoogle();
        }
      }
    }
  }

  Future CreateNewUser(String email, String password) async {
    try {
      UserCredential result =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = result.user;
      return _userFromFirebaseUser(user);
    } on FirebaseAuthException catch (e) {
      err = e.message.toString();
      return _userFromFirebaseUser(null);
    }
  }

  Future SignInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      print(result.user);
      return _userFromFirebaseUser(user);
    } on FirebaseAuthException catch (e) {
      err = e.message.toString();
      return _userFromFirebaseUser(null);
    }
  }

  Future signOut() async {
    try {
      googleSignIn.signOut();
      return await _auth.signOut();
    } on PlatformException catch (e) {
      print(e.toString());
      return null;
    }
  }
}
