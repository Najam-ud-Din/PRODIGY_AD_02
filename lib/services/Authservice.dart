import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:to_do_app/Pages/Homepage.dart';

import 'package:to_do_app/commons/applayout.dart';

class Auth {
  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  FirebaseAuth auth = FirebaseAuth.instance;
  Future<void> googlesignin(BuildContext context) async {
    try {
      GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();

      if (googleSignInAccount != null) {
        GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken,
        );

        try {
          UserCredential userCredential =
              await auth.signInWithCredential(credential);
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
              (route) => false);
        } catch (e) {
          final snackbar = SnackBar(
              backgroundColor: Colors.transparent,
              duration: Duration(seconds: 3),
              content: Container(
                padding: EdgeInsets.all(7.0),
                height: Applayout.getheight(80),
                width: Applayout.getwidthSize(context) - 50,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Center(
                  child: Text(
                    e.toString(),
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ));

          ScaffoldMessenger.of(context).showSnackBar(snackbar);
        }
      } else {
        final snackbar = SnackBar(
            backgroundColor: Colors.transparent,
            duration: Duration(seconds: 3),
            content: Container(
              padding: EdgeInsets.all(7.0),
              height: Applayout.getheight(80),
              width: Applayout.getwidthSize(context) - 50,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(
                child: Text(
                  "Not able to signin",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ));

        ScaffoldMessenger.of(context).showSnackBar(snackbar);
      }
    } catch (e) {
      final snackbar = SnackBar(
          backgroundColor: Colors.transparent,
          duration: Duration(seconds: 3),
          content: Container(
            padding: EdgeInsets.all(7.0),
            height: Applayout.getheight(80),
            width: Applayout.getwidthSize(context) - 50,
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Center(
              child: Text(
                e.toString(),
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ));

      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }
  }

  Future<void> verifythroughphone(
      String phoneno, BuildContext context, Function setdata) async {
    PhoneVerificationCompleted verificationCompleted =
        (PhoneAuthCredential phoneAuthCredential) async {
      showsnackbar(context, "Verification complete");
    };
    PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException exception) {
      showsnackbar(context, exception.toString());
    };
    PhoneCodeSent codeSent = (verificationId, forceResendingToken) => {
          showsnackbar(context, "Verification sent on the phone no"),
          setdata(verificationId),
        };
    PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      showsnackbar(context, "Time out");
    };
    try {
      await auth.verifyPhoneNumber(
          phoneNumber: phoneno,
          verificationCompleted: verificationCompleted,
          verificationFailed: verificationFailed,
          codeSent: codeSent,
          codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
    } catch (e) {
      showsnackbar(context, e.toString());
    }
  }

  Future<void> signinwithphoneno(
      String verificationId, String smscode, BuildContext context) async {
    try {
      AuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: smscode);

      UserCredential userCredential =
          await auth.signInWithCredential(credential);

      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (builder) => HomePage()),
          (route) => false);
      showsnackbar(context, "Logged in");
    } catch (e) {
      showsnackbar(context, e.toString());
    }
  }

  void showsnackbar(BuildContext context, String txt) {
    final snackbar = SnackBar(
        backgroundColor: Colors.transparent,
        duration: Duration(seconds: 3),
        content: Container(
          padding: EdgeInsets.all(7.0),
          height: Applayout.getheight(80),
          width: Applayout.getwidthSize(context) - 50,
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Center(
            child: Text(
              txt,
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ));

    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }
}
