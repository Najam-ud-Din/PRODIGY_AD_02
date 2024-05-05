import 'package:flutter/material.dart';
import 'package:get/get.dart';

class button1 extends StatelessWidget {
  final Widget? transition;
  final String txt;
  button1({
    super.key,
    required this.txt,
    this.transition,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
          overlayColor: MaterialStatePropertyAll(Colors.transparent)),
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: ((context) => transition!)));
      },
      child: Text(
        txt,
        style: TextStyle(
            color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold),
      ),
    );
  }
}
