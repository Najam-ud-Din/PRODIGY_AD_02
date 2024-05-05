import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app/commons/applayout.dart';

class ToDoCard extends StatelessWidget {
  ToDoCard(
      {super.key,
      required this.title,
      required this.icon,
      required this.iconcolor,
      required this.Iconbgcolor,
      required this.check,
      required this.onchange,
      required this.index});

  //we need to assign all values dynamically
  final String title;
  final IconData icon;
  final Color iconcolor, Iconbgcolor;
  final Function onchange;
  final bool check;
  final int index;

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    DateFormat timeFormat = DateFormat('h:mm a');
    String formattedTime = timeFormat.format(now);
    return Container(
      width: Applayout.getwidthSize(context),
      child: Row(
        children: [
          Theme(
            child: Transform.scale(
              scale: 1.5,
              child: Checkbox(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                activeColor: Color(0xff6cf8a9),
                checkColor: Color.fromARGB(255, 19, 99, 59),
                value: check,
                onChanged: (value) {
                  onchange(index);
                },
              ),
            ),
            data: ThemeData(
                primarySwatch: Colors.blue,
                unselectedWidgetColor: Color(0xff5e616a)),
          ),
          Expanded(
              child: Container(
            height: 75,
            child: Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Card(
                color: Color(0xff2a2e3d),
                child: ListTile(
                  leading: Container(
                    height: 30,
                    width: 32,
                    decoration: BoxDecoration(
                      color: Iconbgcolor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(icon),
                  ),
                  title: Text(
                    title,
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: Colors.white),
                  ),
                  trailing: Text(
                    "$formattedTime",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.white),
                  ),
                ),
              ),
            ),
          ))
        ],
      ),
    );
  }
}
