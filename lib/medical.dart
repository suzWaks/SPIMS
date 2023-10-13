import 'package:flutter/material.dart';

class MedicalPage extends StatefulWidget {
  const MedicalPage({super.key});

  @override
  _MedicalPageState createState() => _MedicalPageState();
}

class _MedicalPageState extends State<MedicalPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
    
      body: Center(
        child: Text('Welcome,Medical Page!'),
      ),
    );
  }
}
