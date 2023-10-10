import 'package:flutter/material.dart';

class CoCurricularPage extends StatelessWidget {
  const CoCurricularPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome to the Co-Curricular Page!',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
