// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutUsPage extends StatefulWidget {
    final bool isDarkModeEnabled;
    const AboutUsPage({Key? key,required this.isDarkModeEnabled}) : super(key: key);

  @override
  State<AboutUsPage> createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  @override
  Widget build(BuildContext context) {
     final bool isDarkModeEnabled = widget.isDarkModeEnabled;
    return Scaffold(
        backgroundColor: isDarkModeEnabled
      ? const Color.fromARGB(255, 86, 83, 83)
      : const Color.fromARGB(255, 255, 255, 255),
      body: body(),
    );
  }
}

Widget body() {
  return Container(
      child: Column(
    children: [
      Container(
        constraints: BoxConstraints.tightForFinite(width: double.infinity),
        child: Align(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 30),
              const Text(
                'About Us',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  color: Color(0xFF0028A8),
                  fontSize: 33,
                  fontWeight: FontWeight.w700,
                  height: 1.0,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const Image(
                image: AssetImage('Images/aboutLogo.jpeg'),
                width: 184,
                height: 176,
              ),
              const SizedBox(height: 30),
              Container(
// padding: EdgeInsets.all(25),
                height: 190,
                width: 290,
                child: Text(
                  "Developed as a part of third year mini project. The main aim to reduce the burden on the admin officer and to improve the accessibility of information to everyone.",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.roboto(
                    color: Colors.black,
                    fontSize: 19,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              Container(
                height: 55,
                width: 220,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFFF6600),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(17),
                    ),
                  ),
                  onPressed: () {},
                  child: Text(
                    'Contact Us',
                    style: GoogleFonts.roboto(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      )
    ],
  ));
}
