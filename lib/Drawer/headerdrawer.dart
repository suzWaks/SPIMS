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
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromRGBO(0, 40, 168, 1),
            Color.fromARGB(255, 0, 53, 229),
            Color.fromARGB(255, 0, 43, 183),
          ],
        ),
      ),
      width: double.infinity,
      height: 200,
      padding: const EdgeInsets.only(top: 20, left: 0),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(
          margin: const EdgeInsets.only(bottom: 10),
          height: 90,
          width: 90,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('Images/cstlogo.png'),
              fit: BoxFit.fill,
            ),
          ),
        ),
        const Text(
          "CST",
          style: TextStyle(
              fontSize: 20, color: Color.fromARGB(255, 255, 255, 255)),
        ),
        const Text(
          "spims",
          style: TextStyle(
              fontSize: 20, color: Color.fromARGB(255, 209, 209, 209)),
        ),
      ]),
    );
  }
}
