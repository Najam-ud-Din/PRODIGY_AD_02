import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/Pages/Homepage.dart';
import 'package:to_do_app/commons/applayout.dart';
import 'package:to_do_app/commons/color.dart';

class Viewdata extends StatefulWidget {
  final Map<String, dynamic> document;
  final String id;
  const Viewdata({super.key, required this.document, required this.id});

  @override
  State<Viewdata> createState() => ViewdataPageState();
}

class ViewdataPageState extends State<Viewdata> {
  TextEditingController _taskcontroller = TextEditingController();
  TextEditingController _Descriptioncontroller = TextEditingController();
  String type = "";
  String categorytype = "";

  bool edit = false;
  bool edit2 = false;

  @override
  void initState() {
    super.initState();
    String title = widget.document["title"] == null
        ? "hey there"
        : widget.document["title"];
    _taskcontroller = TextEditingController(text: title);
    _Descriptioncontroller =
        TextEditingController(text: widget.document["Description"]);
  }

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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePage()));
                        },
                        icon: Icon(
                          CupertinoIcons.arrow_left,
                          color: Colors.white,
                          size: 28,
                        )),
                    Row(
                      children: [
                        Tooltip(
                          message: "Delete your task",
                          child: IconButton(
                              onPressed: () {
                                setState(() {
                                  edit2 = !edit2;
                                  FirebaseFirestore.instance
                                      .collection("1")
                                      .doc(widget.id)
                                      .delete()
                                      .then((value) => Navigator.pop(context));
                                });
                              },
                              icon: Icon(
                                Icons.delete,
                                color: edit2 ? Colors.red : Colors.white,
                                size: 28,
                              )),
                        ),
                        Tooltip(
                          message: "Edit your task",
                          child: IconButton(
                              onPressed: () {
                                setState(() {
                                  edit = !edit;
                                });
                              },
                              icon: Icon(
                                Icons.edit,
                                color: edit ? Colors.red : Colors.white,
                                size: 28,
                              )),
                        ),
                      ],
                    )
                  ],
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        edit ? "Editing" : "View",
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
                        "Your Todo",
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
                      label("Task Type"),
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
                      label("Category"),
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
                          edit ? elevatedcontainer(context) : Container(),
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
            FirebaseFirestore.instance.collection("1").doc(widget.id).update({
              "title": _taskcontroller.text,
              "Category": categorytype,
              "Description": _Descriptioncontroller.text,
              "tasktype": type,
            });
            Navigator.pop(context);
          },
          child: Text(
            "Update Todo",
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
        enabled: edit,
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
      onTap: edit
          ? () {
              setState(() {
                type = txt;
              });
            }
          : null,
      child: Chip(
        elevation: 5.0,
        shadowColor: Colors.green,
        backgroundColor: type == txt ? Colors.green : color,
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
      onTap: edit
          ? () {
              setState(() {
                categorytype = txt;
              });
            }
          : null,
      child: Chip(
        backgroundColor: categorytype == txt ? Colors.green : color,
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
        enabled: edit,
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
