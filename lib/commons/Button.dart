import 'package:flutter/material.dart';

import 'package:to_do_app/Pages/Homepage.dart';
import 'package:to_do_app/Pages/signinpage.dart';
import 'package:to_do_app/commons/applayout.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

class ButtonWidget extends StatefulWidget {
  final String txt;
  final TextEditingController? email, password;
  const ButtonWidget({super.key, this.email, this.password, required this.txt});

  @override
  State<ButtonWidget> createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
  firebase_auth.FirebaseAuth auth = firebase_auth.FirebaseAuth.instance;

  bool circular = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Applayout.getwidthSize(context) - 60,
      height: 55,
      child: ElevatedButton(
          style: ButtonStyle(
            alignment: Alignment.center,
            shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20))),
            backgroundColor:
                MaterialStatePropertyAll(Color.fromARGB(255, 30, 222, 33)),
            foregroundColor:
                MaterialStatePropertyAll(const Color.fromARGB(31, 147, 62, 62)),
            elevation: MaterialStatePropertyAll(4.0),
          ),
          onPressed: () async {
            setState(() {
              circular = true;
            });
            if (widget.txt == 'Signup' ||
                widget.txt == 'SIGNUP' ||
                widget.txt == 'Sign Up') {
              try {
                await auth
                    .createUserWithEmailAndPassword(
                        email: widget.email!.text,
                        password: widget.password!.text)
                    .then((value) {
                  final snackbar = SnackBar(
                      backgroundColor: Colors.transparent,
                      duration: Duration(seconds: 2),
                      content: Container(
                        padding: EdgeInsets.all(7.0),
                        height: Applayout.getheight(80),
                        width: Applayout.getwidthSize(context) - 50,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Center(
                          child: Text(
                            "SignUp Successfully",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ));

                  ScaffoldMessenger.of(context).showSnackBar(snackbar);
                });

                setState(() {
                  circular = false;
                });
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => HomePage()));
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
                setState(() {
                  circular = false;
                });
              }
            } else if (widget.txt == 'Signin' ||
                widget.txt == 'SIGNIN' ||
                widget.txt == 'Sign in') {
              try {
                await auth
                    .signInWithEmailAndPassword(
                        email: widget.email!.text,
                        password: widget.password!.text)
                    .then((value) => Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => HomePage())));
                setState(() {
                  circular = false;
                });

                final snackbar = SnackBar(
                    backgroundColor: Colors.transparent,
                    duration: Duration(seconds: 3),
                    content: Container(
                      padding: EdgeInsets.all(7.0),
                      height: Applayout.getheight(80),
                      width: Applayout.getwidthSize(context) - 50,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(
                        child: Text(
                          "Signin Successfully",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ));
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
                setState(() {
                  circular = false;
                });
              }
            } else {
              try {
                await auth.signOut();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: ((context) => Signin())));
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
                setState(() {
                  circular = false;
                });
              }
            }
          },
          child: (circular == true)
              ? CircularProgressIndicator()
              : Text(
                  widget.txt,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                )),
    );
  }
}
