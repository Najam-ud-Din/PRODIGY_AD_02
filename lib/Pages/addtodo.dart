import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/Pages/Homepage.dart';
import 'package:to_do_app/commons/applayout.dart';
import 'package:to_do_app/commons/color.dart';

class AddTodoPage extends StatefulWidget {
  const AddTodoPage({super.key});

  @override
  State<AddTodoPage> createState() => AddTodoPageState();
}

class AddTodoPageState extends State<AddTodoPage> {
  TextEditingController _taskcontroller = TextEditingController();
  TextEditingController _Descriptioncontroller = TextEditingController();
  String type = "";
  String categorytype = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: Applayout.getheightSize(context),
          width: Applayout.getwidthSize(context),
          decoration: BoxDecoration(
              gradient: RadialGradient(radius: 1.1, colors: [
            Color.fromARGB(255, 171, 169, 180),
            style.maincolor,
          ])),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 30,
                ),
                IconButton(
                    onPressed: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => HomePage()));
                    },
                    icon: Icon(
                      CupertinoIcons.arrow_left,
                      color: Colors.white,
                      size: 28,
                    )),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Create",
                        style: TextStyle(
                          fontSize: 33,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 4,
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        "New Todo",
                        style: TextStyle(
                          fontSize: 33,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      label("Task Title"),
                      SizedBox(
                        height: 20,
                      ),
                      title(),
                      SizedBox(
                        height: 10,
                      ),
                      label("Task Type:  (choose one's)"),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          taskchipdata(
                              "Important", Color.fromARGB(255, 131, 141, 164)),
                          SizedBox(
                            width: 20,
                          ),
                          taskchipdata(
                              "Planned", Color.fromARGB(255, 131, 141, 164)),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      label("Description"),
                      SizedBox(
                        height: 25,
                      ),
                      Description(),
                      SizedBox(
                        height: 25,
                      ),
                      label("Category:  (choose one's)"),
                      SizedBox(
                        height: 15,
                      ),
                      Wrap(
                        direction: Axis.horizontal,
                        spacing: CircularProgressIndicator.strokeAlignOutside,
                        runSpacing: 14,
                        children: [
                          descriptionchipdata(
                              "Food", Color.fromARGB(255, 131, 141, 164)),
                          SizedBox(
                            width: 15,
                          ),
                          descriptionchipdata(
                              "Run", Color.fromARGB(255, 131, 141, 164)),
                          SizedBox(
                            width: 15,
                          ),
                          descriptionchipdata(
                              "Work", Color.fromARGB(255, 131, 141, 164)),
                          SizedBox(
                            width: 15,
                          ),
                          descriptionchipdata(
                              "Workout", Color.fromARGB(255, 131, 141, 164)),
                          SizedBox(
                            width: 15,
                          ),
                          descriptionchipdata(
                              "Design", Color.fromARGB(255, 131, 141, 164)),
                          SizedBox(
                            height: 90,
                          ),
                          elevatedcontainer(context),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget elevatedcontainer(BuildContext context) {
    return Container(
      height: 55,
      width: Applayout.getwidthSize(context),
      child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(
                Color.fromARGB(255, 11, 255, 36),
              ),
              elevation: MaterialStatePropertyAll(3.0),
              foregroundColor: MaterialStatePropertyAll(Colors.lightGreen)),
          onPressed: () {
            FirebaseFirestore.instance.collection("1").add({
              "title": _taskcontroller.text,
              "Category": categorytype,
              "Description": _Descriptioncontroller.text,
              "tasktype": type,
            });
            Navigator.pop(context);
          },
          child: Text(
            "Add Todo",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
          )),
    );
  }

  Widget Description() {
    return Container(
      height: 150,
      width: Applayout.getwidthSize(context),
      decoration: BoxDecoration(
        color: Color(0xff2a2e3d),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        style: TextStyle(color: Colors.white, fontSize: 20),
        maxLines: null,
        controller: _Descriptioncontroller,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: "Description",
            hintStyle: TextStyle(
              color: Colors.grey,
              fontSize: 17,
            ),
            contentPadding: EdgeInsets.only(
              left: 20,
              right: 20,
            )),
      ),
    );
  }

  Widget taskchipdata(String txt, Color color) {
    return InkWell(
      onTap: () {
        setState(() {
          type = txt;
        });
      },
      child: Chip(
        elevation: 5.0,
        shadowColor: Colors.green,
        backgroundColor: type == txt ? Color.fromARGB(255, 10, 176, 27) : color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            30,
          ),
        ),
        label: Text(
          txt,
          style: TextStyle(
            color: Colors.white,
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
        labelPadding: EdgeInsets.symmetric(horizontal: 17, vertical: 3.8),
      ),
    );
  }

  Widget descriptionchipdata(String txt, Color color) {
    return InkWell(
      onTap: () {
        setState(() {
          categorytype = txt;
        });
      },
      child: Chip(
        backgroundColor:
            categorytype == txt ? Color.fromARGB(255, 10, 176, 27) : color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            30,
          ),
        ),
        label: Text(
          txt,
          style: TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
        labelPadding: EdgeInsets.symmetric(horizontal: 17, vertical: 3.8),
      ),
    );
  }

  Widget title() {
    return Container(
      height: 55,
      width: Applayout.getwidthSize(context),
      decoration: BoxDecoration(
        color: Color(0xff2a2e3d),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        style: TextStyle(color: Colors.white, fontSize: 20),
        controller: _taskcontroller,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: "Task Title",
            hintStyle: TextStyle(
              color: Colors.grey,
              fontSize: 17,
            ),
            contentPadding: EdgeInsets.only(
              left: 20,
              right: 20,
            )),
      ),
    );
  }

  Widget label(String name) {
    return Text(
      name,
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.2,
      ),
    );
  }
}
