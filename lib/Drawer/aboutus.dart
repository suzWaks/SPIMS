import 'package:flutter/material.dart';

class AboutUsPage extends StatefulWidget {
  @override
  _AboutUsPageState createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
Widget body() {
  return Container(
      child: Column(
    children: [
      Container(
        height: 170,
        child: const Align(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'About Us',
                style: TextStyle(
                  color: Color(0xFF0028A8),
                  fontSize: 33,
                  fontWeight: FontWeight.w700,
                  height: 1.0,
                ),
              ),
              Image(
                image: AssetImage('images/aboutLogo.jpeg'),
                width: 184,
                height: 176,
              )
            ],
          ),
        ),
    );
  }
}
