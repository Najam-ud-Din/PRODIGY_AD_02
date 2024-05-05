import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:to_do_app/commons/applayout.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:to_do_app/services/Authservice.dart';

class PhoneAuthPage extends StatefulWidget {
  const PhoneAuthPage({super.key});

  @override
  State<PhoneAuthPage> createState() => PhoneAuthPageState();
}

class PhoneAuthPageState extends State<PhoneAuthPage> {
  int start = 30;
  bool wait = false;
  String buttonname = 'send';
  TextEditingController phonecontroller = TextEditingController();
  Auth Authclassobj = Auth();
  String verificationIdFinal = "", smscode = " ";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.black87,
        centerTitle: true,
        title: Text(
          "Sign UP",
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
      ),
      body: Container(
        height: Applayout.getheightSize(context),
        width: Applayout.getwidthSize(context),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 150,
              ),
              textfield(),
              SizedBox(
                height: 10,
              ),
              Container(
                width: Applayout.getwidthSize(context) - 40,
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 1,
                        color: Colors.grey,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Enter 6 digit OTP",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 1,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Otptextfield(),
              SizedBox(
                height: 30,
              ),
              RichText(
                  text: TextSpan(children: [
                TextSpan(
                    text: "Send OTP again in ",
                    style: TextStyle(fontSize: 16, color: Colors.yellowAccent)),
                TextSpan(
                    text: "00:$start",
                    style: TextStyle(fontSize: 16, color: Colors.pinkAccent)),
                TextSpan(
                    text: " Sec ",
                    style: TextStyle(fontSize: 16, color: Colors.yellowAccent)),
              ])),
              SizedBox(
                height: 120,
              ),
              InkWell(
                focusColor: Colors.transparent,
                onTap: () {
                  Authclassobj.signinwithphoneno(
                      verificationIdFinal, smscode, context);
                },
                child: Container(
                  height: 50,
                  width: Applayout.getwidthSize(context) - 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Color.fromARGB(255, 30, 222, 33),
                  ),
                  child: Center(
                    child: Text(
                      "Let's Go",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void starttimer() {
    const onsec = Duration(seconds: 1);
    Timer timer = Timer.periodic(onsec, (timer) {
      if (start == 0) {
        setState(() {
          timer.cancel();
          wait = false;
        });
      } else {
        setState(() {
          start--;
        });
      }
    });
  }

  Widget Otptextfield() {
    return OTPTextField(
      length: 6,
      width: MediaQuery.of(context).size.width - 40,
      fieldWidth: 43,
      otpFieldStyle: OtpFieldStyle(
          borderColor: Colors.white,
          backgroundColor: Color(0xff1d1d1d),
          enabledBorderColor: Colors.white,
          focusBorderColor: Colors.blue),
      style: TextStyle(fontSize: 17, color: Colors.white),
      textFieldAlignment: MainAxisAlignment.spaceAround,
      fieldStyle: FieldStyle.underline,
      onCompleted: (pin) {
        print("Completed: " + pin);
        setState(() {
          smscode = pin;
        });
      },
    );
  }

  Widget textfield() {
    return Container(
      width: Applayout.getwidthSize(context) - 40,
      height: 60,
      decoration: BoxDecoration(
        color: Color(0xff1d1d1d),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        style: TextStyle(
            color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold),
        controller: phonecontroller,
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Enter your Phone Number',
            contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 19),
            prefixIcon: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 14),
              child: Text(
                " (+92) ",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.bold),
              ),
            ),
            suffixIcon: InkWell(
              onTap: wait
                  ? null
                  : () async {
                      starttimer();
                      setState(() {
                        start = 30;
                        wait = true;
                        buttonname = 'Resend';
                      });

                      String phoneNumber = "+92 ${phonecontroller.text}";
                      if (RegExp(r'^\+\d{1,3}\s\d{9}$').hasMatch(phoneNumber)) {
                        // Phone number is in the correct format
                        await Authclassobj.verifythroughphone(
                            phoneNumber, context, setdata);
                      } else {
                        // Phone number format is invalid
                        print("Invalid phone number format");
                      }
                    },
              focusColor: Colors.transparent,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 14),
                child: Text(
                  buttonname,
                  style: TextStyle(
                      color: wait ? Colors.grey : Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            hintStyle: TextStyle(color: Colors.white54, fontSize: 16)),
      ),
    );
  }

  void setdata(verificationid) {
    setState(() {
      verificationIdFinal = verificationid;
    });

    starttimer();
  }
}
