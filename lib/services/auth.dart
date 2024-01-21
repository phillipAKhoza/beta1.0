import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_sign_in/google_sign_in.dart';

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
class CurrentUser{

  static SharedPreferences? prefsS;
  static  Future init() async {
    prefsS = await SharedPreferences.getInstance();
  }
  static Future setAdminStatus(bool status) async {
    return await prefsS?.setBool('isAdmin', status);
  }
  static bool? getAdminStatus() {
    return prefsS?.getBool('isAdmin');
  }
  static Future setUserEmail(String? emailValue) async {
    return await prefsS?.setString('email', emailValue!);
  }
  static String? getUserEmail() {
    return  prefsS?.getString('email');
  }
  static Future setUserUid(String? emailValue) async {
    return await prefsS?.setString('uid', emailValue!);
  }
  static String? getUserUid() {
    return  prefsS?.getString('uid');
  }
}
class Authentication {

  Future<FormatResult> signInWithGoogle() async {
    bool isValid = false;
    String message = 'Success';
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    // return
    try {
      CurrentUser.init();
      await FirebaseAuth.instance.signInWithCredential(credential).then((
          value) =>
      {
        if(value.user != null){

          isValid = true,
          FirebaseFirestore.instance.collection('admin_db').doc(
              value.user!.uid).get().then((DocumentSnapshot documentSnapshot) {
            if (documentSnapshot.exists) {
              CurrentUser.setAdminStatus(true);
              CurrentUser.setUserUid(value.user!.uid);
            } else {
              CurrentUser.setAdminStatus(false);
            }
          }),
        }
      });
    }on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        message = 'No user found for that email.';
        isValid = false;
      } else if (e.code == 'wrong-password') {
        message = 'Wrong password provided for that user.';
        isValid = false;
      } else {
        message = e.toString();
      }
    }

    return FormatResult(isValid, message);
  }

  Future<UserResult> userAuth() async {
    bool isLoggedIn = false;
    List<String?> userDetails = [];
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        isLoggedIn = false;
      } else {
            isLoggedIn = true;
             userDetails = [
             user.email,
             user.uid,
             ];
            CurrentUser.setUserEmail(user.email);
            CurrentUser.setUserUid(user.uid);
      }
    });
    return UserResult(isLoggedIn, userDetails);
  }

  Future<FormatResult> userRegistration(String email, String password) async {
    bool isValid = false;
    String message = 'Success';
    try {
       await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: email,
            password: password,
          )
          .then((value) => isValid = true);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        message = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        message = 'The account already exists for that email.';
      }
    } catch (e) {
      message = e.toString();
    }
    return FormatResult(isValid, message);
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut().then((value) {
       CurrentUser.prefsS?.clear();
    });
  }

  Future<FormatResult> signInWithEmailAndPassword(
      String email, String password) async {
    bool isValid = false;
    String message = 'Success';
    try {
       CurrentUser.init();
       await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) => {
            isValid = true,
         if(value.user !=null){
           FirebaseFirestore.instance.collection('admin_db').doc(
               value.user!.uid).get().then((DocumentSnapshot documentSnapshot) {
              if(documentSnapshot.exists){
                CurrentUser.setAdminStatus(true);
                CurrentUser.setUserUid(value.user!.uid);
              }else{
                CurrentUser.setAdminStatus(false);
              }

           }),
         }
          });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        message = 'No user found for that email.';
        isValid = false;
      } else if (e.code == 'wrong-password') {
        message = 'Wrong password provided for that user.';
        isValid = false;
      } else {
        message = e.toString();
      }
    }
    return FormatResult(isValid, message);
  }
}
