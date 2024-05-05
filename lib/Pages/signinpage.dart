import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:get/get_utils/src/platform/platform.dart';
import 'package:to_do_app/Pages/signuppage.dart';
import 'package:to_do_app/commons/Button.dart';
import 'package:to_do_app/commons/applayout.dart';
import 'package:to_do_app/commons/color.dart';
import 'package:to_do_app/commons/textfieldwidget.dart';
import 'package:to_do_app/commons/button1.dart';

class Signin extends StatefulWidget {
  const Signin({super.key});

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();

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
                "Sign In",
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
              ),
              SizedBox(
                height: 5,
              ),
              buttoncontainer(
                  imagepath: 'images/phone.png', txt: "Continue with Phone"),
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
                controller: emailcontroller,
                inputtype: TextInputType.emailAddress,
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
                txt: 'Sign in',
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
                    "If you don't already have an account?",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.normal),
                  ),
                  SizedBox(
                    width: 1,
                  ),
                  button1(
                    txt: 'Signup',
                    transition: SignUp(),
                  ),
                ],
              ),
              SizedBox(
                height: 8,
              ),
              button1(txt: 'Forget Password'),
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
  const buttoncontainer({
    super.key,
    required this.imagepath,
    required this.txt,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
