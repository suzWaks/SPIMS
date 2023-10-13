import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            // Background Image with Border Radius
            Positioned(
              top: -80,
              left: 0,
              right: 0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50.0),
                child: Image.asset(
                  'Images/settings.jpg', // Replace with your image path
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // Header Text
            const Positioned(
              top: 50, // Adjust the top position as needed
              child: Text(
                'Settings',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // Set the text color as needed
                ),
              ),
            ),

            // Column of Buttons
            Positioned(
              top: 200, // Adjust the top position as needed
              child: Column(
                children: <Widget>[
                  // Button 1
                  Container(
                    width: 310,
                    height: 68,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: const Color(0xFFF1F8F8),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.25),
                          offset: Offset(0, 4),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    child: const Row(
                      children: <Widget>[
                        SizedBox(width: 50), // Adjust spacing as needed
                        Icon(
                          Icons.image,
                          color: Color.fromRGBO(255, 102, 0, 1.0),
                          size: 30,
                        ),
                        SizedBox(width: 20),
                        Text(
                          'Change Profilejvw Picture',
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Roboto',
                            fontSize: 19,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Button 2
                  Container(
                    width: 310,
                    height: 68,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: const Color(0xFFF1F8F8),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.25),
                          offset: Offset(0, 4),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    child: const Row(
                      children: <Widget>[
                        SizedBox(width: 50), // Adjust spacing as needed
                        Icon(
                          Icons.lock,
                          color: Color.fromRGBO(255, 102, 0, 1.0),
                          size: 30,
                        ),
                        SizedBox(width: 20),
                        Text(
                          'Change Password',
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Roboto',
                            fontSize: 19,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Button 3
                  Container(
                    width: 310,
                    height: 68,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: const Color(0xFFF1F8F8),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.25),
                          offset: Offset(0, 4),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    child: const Row(
                      children: <Widget>[
                        SizedBox(width: 50), // Adjust spacing as needed
                        Icon(
                          Icons.visibility_off,
                          color: Color.fromRGBO(255, 102, 0, 1.0),
                          size: 30,
                        ),
                        SizedBox(width: 20),
                        Text(
                          'Manage Visibility',
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Roboto',
                            fontSize: 19,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: SettingsPage(),
  ));
}
