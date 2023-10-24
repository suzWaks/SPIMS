import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
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
                  'Images/settings.jpg',
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // Header Text
            Positioned(
              top: 50,
              child: Text(
                'Settings',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),

            // Column of Buttons
            Positioned(
              top: 200,
              child: Column(
                children: <Widget>[
                  // Button 1
                  buildSettingsButton(
                    icon: Icons.image,
                    text: 'Change Profile Picture',
                  ),
                  const SizedBox(height: 30),

                  // Button 2
                  buildSettingsButton(
                    icon: Icons.lock,
                    text: 'Change Password',
                  ),
                  const SizedBox(height: 30),

                  // Button 3
                  buildSettingsButton(
                    icon: Icons.visibility_off,
                    text: 'Manage Visibility',
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

  Widget buildSettingsButton({required IconData icon, required String text}) {
    return Container(
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
      child: Row(
        children: <Widget>[
          const SizedBox(width: 50),
          Icon(
            icon,
            color: Color.fromRGBO(255, 102, 0, 1.0),
            size: 30,
          ),
          const SizedBox(width: 20),
          Text(
            text,
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
    );
  }
}
