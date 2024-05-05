import 'package:flutter/material.dart';
import 'package:to_do_app/commons/applayout.dart';

class TextfieldWidget extends StatelessWidget {
  final String txt, hinttxt;
  final TextEditingController controller;
  final TextInputType inputtype;
  final bool Obscure;
  final Widget? preicon, posticon;

  const TextfieldWidget(
      {super.key,
      required this.txt,
      required this.hinttxt,
      required this.controller,
      required this.Obscure,
      required this.inputtype,
      required this.preicon,
      this.posticon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Applayout.getwidthSize(context) - 60,
      height: 55,
      child: TextFormField(
        style: TextStyle(
          color: Colors.white,
        ),
        keyboardType: inputtype,
        controller: controller,
        obscureText: Obscure,
        decoration: InputDecoration(
            prefixIcon: preicon,
            suffixIcon: posticon,
            hintText: hinttxt,
            hintStyle: TextStyle(
              fontSize: 17,
              color: Colors.grey.withOpacity(0.6),
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(
                  width: 1.5,
                  color: Colors.amber,
                )),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(
                  width: 1,
                  color: Colors.grey,
                )),
            labelText: txt,
            labelStyle: TextStyle(
              fontSize: 17,
              color: Colors.white,
            )),
      ),
    );
  }
}
