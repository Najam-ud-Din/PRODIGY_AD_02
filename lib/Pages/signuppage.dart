import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:to_do_app/Pages/phoneauthpage.dart';
import 'package:to_do_app/Pages/signinpage.dart';
import 'package:to_do_app/commons/Button.dart';
import 'package:to_do_app/commons/applayout.dart';
import 'package:to_do_app/commons/color.dart';
import 'package:to_do_app/commons/button1.dart';
import 'package:to_do_app/commons/textfieldwidget.dart';
import 'package:to_do_app/services/Authservice.dart';

class SignUp extends StatefulWidget {
  SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  Auth authobj = Auth();
  bool obscuredtext = true;
  dynamic isclick() {
    obscuredtext = !obscuredtext;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: style.mainbackground,
          height: Applayout.getheightSize(context),
          width: Applayout.getwidthSize(context),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Sign UP",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 35,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              buttoncontainer(
                imagepath: 'images/google.png',
                txt: "Continue with google",
                isgoogle: true,
                ontapgoogle: () async {
                  await authobj.googlesignin(context);
                },
              ),
              SizedBox(
                height: 5,
              ),
              buttoncontainer(
                imagepath: 'images/phone.png',
                txt: "Continue with Phone",
                transition: PhoneAuthPage(),
                isgoogle: false,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'or',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              TextfieldWidget(
                Obscure: false,
                txt: " Email",
                hinttxt: "najamuddin34@gmail.com",
                inputtype: TextInputType.emailAddress,
                controller: emailcontroller,
                preicon: Icon(Icons.email_rounded),
              ),
              SizedBox(
                height: 15,
              ),
              TextfieldWidget(
                preicon: Icon(Icons.lock),
                posticon: GestureDetector(
                  onTap: () {
                    isclick();
                    setState(() {});
                  },
                  child: Icon(
                    obscuredtext ? Icons.visibility_off : Icons.visibility,
                    color: Colors.white,
                  ),
                ),
                inputtype: TextInputType.number,
                Obscure: obscuredtext,
                txt: " Password",
                hinttxt: 'bismillah23',
                controller: passwordcontroller,
              ),
              SizedBox(
                height: 20,
              ),
              ButtonWidget(
                txt: 'Sign Up',
                email: emailcontroller,
                password: passwordcontroller,
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "If you already have an account?",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.normal),
                  ),
                  SizedBox(
                    width: 3,
                  ),
                  button1(
                    txt: 'Login',
                    transition: const Signin(),
                  ),
                ],
              ),
              SizedBox(
                height: 8,
              ),
              button1(txt: "Forget Password"),
            ],
          ),
        ),
      ),
    );
  }
}

class buttoncontainer extends StatelessWidget {
  final String imagepath;
  final String txt;
  final Widget? transition;
  final Function? ontapgoogle;
  final Function? ontapphone;
  final bool? isgoogle;

  const buttoncontainer({
    super.key,
    required this.imagepath,
    required this.txt,
    this.transition,
    this.ontapgoogle,
    this.ontapphone,
    this.isgoogle,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      focusColor: Colors.transparent,
      onTap: () {
        isgoogle == true
            ? ontapgoogle?.call()
            : Navigator.push(context,
                MaterialPageRoute(builder: (context) => PhoneAuthPage()));
      },
      child: Container(
        height: Applayout.getWidth(60),
        width: Applayout.getwidthSize(context) - 60,
        child: Card(
          elevation: 10,
          color: Colors.black,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
              side: BorderSide(
                width: 1,
                color: Colors.grey,
              )),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                imagepath,
                height: 25,
                width: 25,
              ),
              SizedBox(
                width: 15,
              ),
              Text(
                txt,
                style: TextStyle(color: Colors.white, fontSize: 17),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
