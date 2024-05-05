import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/Pages/Todocard.dart';
import 'package:to_do_app/Pages/addtodo.dart';
import 'package:to_do_app/Pages/viewdata.dart';
import 'package:to_do_app/commons/applayout.dart';
import 'package:to_do_app/commons/color.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final Stream<QuerySnapshot> stream =
      FirebaseFirestore.instance.collection('1').snapshots();
  int index = 0;

  List<select> selected = [];

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String dayName = DateFormat.E('en_US').format(now);
    return Scaffold(
      backgroundColor: style.maincolor,
      appBar: AppBar(
        backgroundColor: style.maincolor,
        centerTitle: false,
        title: Text("Today's Schedule",
            style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
        actions: [
          CircleAvatar(
            backgroundImage: AssetImage('images/IMG_2115.jpg'),
          ),
          SizedBox(
            width: 25,
          )
        ],
        bottom: PreferredSize(
            preferredSize: Size.fromHeight(35),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 22),
                child: Text("${dayName}day",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
              ),
            )),
      ),
      bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Color.fromARGB(255, 11, 255, 36),
          unselectedItemColor: Colors.white,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          currentIndex: index,
          backgroundColor: style.maincolor,
          onTap: (value) {
            setState(() {
              index = value;
            });
          },
          items: [
            BottomNavigationBarItem(
              label: "Home",
              icon: Icon(
                Icons.home,
                semanticLabel: "Home",
                size: 32,
                color: index == 0
                    ? Color.fromARGB(255, 11, 255, 36)
                    : Colors.white,
              ),
            ),
            BottomNavigationBarItem(
              label: " ",
              icon: Tooltip(
                message: "Add task",
                child: InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (builder) => AddTodoPage()));
                  },
                  child: Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(colors: [
                          Color.fromARGB(255, 11, 255, 36),
                          Color.fromARGB(255, 5, 43, 42),
                        ])),
                    child: Icon(
                      Icons.add,
                      size: 32,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            BottomNavigationBarItem(
              label: "Settings",
              icon: Icon(
                Icons.settings,
                semanticLabel: "Setting",
                size: 32,
                color: index == 2
                    ? Color.fromARGB(255, 11, 255, 36)
                    : Colors.white,
              ),
            ),
          ]),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder(
          stream: stream,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.builder(
              itemCount: snapshot.data?.docs.length,
              itemBuilder: (context, index) {
                IconData icon = Icons.abc;
                Color iconcolor = Colors.transparent;
                Map<String, dynamic> document =
                    snapshot.data?.docs[index].data() as Map<String, dynamic>;
                switch (document["Category"]) {
                  case "Work":
                    icon = Icons.run_circle_outlined;
                    iconcolor = Colors.red;
                    break;

                  case "Workout":
                    icon = Icons.alarm;
                    iconcolor = Colors.teal;
                    break;

                  case "Food":
                    icon = Icons.local_grocery_store;
                    iconcolor = Colors.blue;
                    break;

                  case "Design":
                    icon = Icons.audiotrack;
                    iconcolor = Colors.green;
                    break;

                  case "Run":
                    icon = Icons.run_circle_sharp;
                    iconcolor = Colors.black;
                    break;
                  default:
                    icon = Icons.run_circle_outlined;
                    iconcolor = Colors.red;
                }
                selected.add(select(
                    id: snapshot.data!.docs[index].id, checkvalue: false));
                return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => Viewdata(
                                  document: document,
                                  id: snapshot.data!.docs[index].id,
                                ))));
                  },
                  child: ToDoCard(
                    title: document["title"] == null
                        ? "hey there"
                        : document["title"],
                    icon: icon,
                    iconcolor: iconcolor,
                    Iconbgcolor: Colors.white,
                    check: selected[index].checkvalue!,
                    index: index,
                    onchange: onchanged,
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  void onchanged(int index) {
    setState(() {
      selected[index].checkvalue = !selected[index].checkvalue!;
    });
  }
}

class select {
  String? id;
  bool? checkvalue = false;

  select({required this.id, required this.checkvalue});
}


// Container(
//           height: Applayout.getheightSize(context),
//           width: Applayout.getwidthSize(context),
//           child: Column(
//             children: [
//               ToDoCard(
//                 title: "Wake up Bro",
//                 icon: CupertinoIcons.alarm,
//                 iconcolor: CupertinoColors.black,
//                 Iconbgcolor: Colors.white,
//                 check: true,
//                 time: "4am",
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               ToDoCard(
//                   title: "Let's Go gym",
//                   icon: Icons.run_circle,
//                   iconcolor: Colors.black,
//                   Iconbgcolor: Colors.white,
//                   time: "5pm",
//                   check: true),
//               SizedBox(
//                 height: 10,
//               ),
//               ToDoCard(
//                   title: "Buy some food",
//                   icon: Icons.local_grocery_store,
//                   iconcolor: Colors.black,
//                   Iconbgcolor: Colors.white,
//                   time: "9am",
//                   check: true)
//             ],
//           ),
//         ),
