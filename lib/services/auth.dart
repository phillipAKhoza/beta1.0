import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FormatResult {
  bool isValid;
  bool isAdmin;
  String message;
  FormatResult(this.isValid,this.isAdmin, this.message);
}

class UserResult {
  bool isLoggedIn;
  bool isAdmin;
  List<String?> userDetails;
  UserResult(this.isLoggedIn,this.isAdmin, this.userDetails);
}

class Authentication {
  Future<UserResult> userAuth() async {
    bool isLoggedIn = false;
    bool isAdmin = false;
    List<String?> userDetails = [];
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        isLoggedIn = false;
      } else {
         FirebaseFirestore.instance.collection('admin_db').doc(user.uid).get().then((DocumentSnapshot documentSnapshot) =>
         {
           if(documentSnapshot.exists){
             isAdmin = true
           },
            isLoggedIn = true,
             userDetails = [
             user.displayName,
             user.email,
             user.phoneNumber,
             user.photoURL,
             user.uid,
             ]
         });

      }
    });
    return UserResult(isLoggedIn,isAdmin, userDetails);
  }

  Future<FormatResult> userRegistration(String email, String password) async {
    bool isValid = false;
    bool isAdmin= false;
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
    return FormatResult(isValid,isAdmin, message);
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  Future<FormatResult> signInWithEmaiAndPassword(
      String email, String password) async {
    bool isValid = false;
    bool isAdmin = false;
    String message = 'Success';
    try {
       await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) => {
            isValid = true,
            if(value.user !=null){
             FirebaseFirestore.instance.collection('admin_db').doc(value.user!.uid).get().then((DocumentSnapshot documentSnapshot) =>
                {
                   if(documentSnapshot.exists){
                     isAdmin = true
                   }
                }
             )
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
    return FormatResult(isValid,isAdmin, message);
  }
}
