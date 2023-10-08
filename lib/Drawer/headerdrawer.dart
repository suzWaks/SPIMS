import 'package:flutter/material.dart';

class HeaderDrawer extends StatefulWidget {
  const HeaderDrawer({super.key});

  @override
  State<HeaderDrawer> createState() => _HeaderDrawerState();
}

class _HeaderDrawerState extends State<HeaderDrawer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 0, 41, 152),
      width: double.infinity,
      height: 200,
      padding: EdgeInsets.only(top: 20, left: 0),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(
          margin: EdgeInsets.only(bottom: 10),
          height: 70,
          // decoration: BoxDecoration(
          //   image: DecorationImage(
          //     image: AssetImage('lib/Drawer/cstlogo.png'),
          //     fit: BoxFit.fill,
          //   ),
          // ),
        ),
        Text(
          "CST",
          style: TextStyle(
              fontSize: 20, color: Color.fromARGB(255, 255, 255, 255)),
        ),
        Text(
          "spims",
          style: TextStyle(
              fontSize: 20, color: Color.fromARGB(255, 143, 143, 143)),
        ),
      ]),
    );
  }
}
