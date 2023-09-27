import 'package:firebase_auth/firebase_auth.dart';

class FormatResult {
  bool isValid;
  String message;
  FormatResult(this.isValid, this.message);
}

class UserResult {
  bool isLoggedIn;
  List<String?> userDetails;
  UserResult(this.isLoggedIn, this.userDetails);
}

class Authentication {
  Future<UserResult> userAuth() async {
    bool isLoggedIn = false;
    List<String?> userDetails = [];
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        isLoggedIn = false;
      } else {
        isLoggedIn = true;
        userDetails = [
          user.displayName,
          user.email,
          user.phoneNumber,
          user.photoURL,
          user.uid
        ];
      }
    });
    return UserResult(isLoggedIn, userDetails);
  }

  Future<FormatResult> userRegistration(String email, String password) async {
    bool _isValid = false;
    String message = 'Success';
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: email,
            password: password,
          )
          .then((value) => _isValid = true);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        message = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        message = 'The account already exists for that email.';
      }
    } catch (e) {
      message = e.toString();
    }
    return FormatResult(_isValid, message);
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  Future<FormatResult> signInWithEmaiAndPassword(
      String email, String password) async {
    bool _isValid = false;
    String message = 'Success';
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) => {_isValid = true});
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        message = 'No user found for that email.';
        _isValid = false;
      } else if (e.code == 'wrong-password') {
        message = 'Wrong password provided for that user.';
        _isValid = false;
      } else {
        message = e.toString();
      }
    }
    return FormatResult(_isValid, message);
  }
}
