import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:bcrypt/bcrypt.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
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
                  // buildSettingsButton(
                  //   icon: Icons.image,
                  //   text: 'Change Profile Picture',
                  // ),
                  // const SizedBox(height: 30),

                  // Button 2
                  buildSettingsButton(
                    icon: Icons.lock,
                    text: 'Change Password',
                    onTap: () {
                      // Navigate to the ChangePasswordScreen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChangePasswordScreen(),
                        ),
                      );
                    },
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

//   Widget buildSettingsButton(
//       {required IconData icon, required String text, VoidCallback? onTap}) {
//     return Container(
//       width: 310,
//       height: 68,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(20.0),
//         color: const Color(0xFFF1F8F8),
//         boxShadow: const [
//           BoxShadow(
//             color: Color.fromRGBO(0, 0, 0, 0.25),
//             offset: Offset(0, 4),
//             blurRadius: 4,
//           ),
//         ],
//       ),
//       child: Row(
//         children: <Widget>[
//           const SizedBox(width: 50),
//           Icon(
//             icon,
//             color: Color.fromRGBO(255, 102, 0, 1.0),
//             size: 30,
//           ),
//           const SizedBox(width: 20),
//           Text(
//             text,
//             style: TextStyle(
//               color: Colors.black,
//               fontFamily: 'Roboto',
//               fontSize: 19,
//               fontWeight: FontWeight.w400,
//               fontStyle: FontStyle.normal,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

  Widget buildSettingsButton({
    required IconData icon,
    required String text,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: SettingsPage(),
  ));
}

// Cahnging password
class ChangePasswordScreen extends StatefulWidget {
  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final storage = FlutterSecureStorage();

  final TextEditingController currentPasswordController =
      TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController retypePasswordController =
      TextEditingController();

  Future<void> changePassword() async {
    // Retrieve student ID and old password from Flutter Secure Storage
    String? storedStudentId = await storage.read(key: 'std_id');
    String? storedHashedPasswordWithSalt = await storage.read(key: 'password');

    print('Password: $storedHashedPasswordWithSalt');

    // Check if the storedHashedPasswordWithSalt is not null
    if (storedHashedPasswordWithSalt == null) {
      // Handle the case where the password with salt is not available
      print("Null password");
      return;
    }

    // Extract salt and hashed password from the stored value
    List<String> parts = storedHashedPasswordWithSalt.split(r'$');

    // Ensure that the parts list has at least 3 elements
    if (parts.length < 3) {
      // Handle the case where the stored value is in an unexpected format
      print('Sed');
      return;
    }

    // Extract salt and hashed password from the stored value

    String salt = parts[2];
    String hashedPasswordWithSalt = parts[3];

    // Validate stored hashed password
    if (!BCrypt.checkpw(
        currentPasswordController.text, storedHashedPasswordWithSalt!)) {
      // Old password does not match
      return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Current password is incorrect.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          );
        },
        // ... (same error dialog code as before)
      );
    }

    // Validate new password and retype password
    if (newPasswordController.text != retypePasswordController.text) {
      // New password and retype password do not match
      // Show an error message or pop-up
      return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('New password and retype password do not match.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }

    // Call the API to update the password
    try {
      final response = await http.patch(
        Uri.parse('http://172.20.10.2:8888/updatePassword'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'newPassword': newPasswordController.text,
          'student_id': '0$storedStudentId',
        }),
      );

      if (response.statusCode == 200) {
        // Password updated successfully
        // Show a success message or pop-up
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Success'),
              content: Text('Password updated successfully.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    // Navigate back to the login screen
                    Navigator.pushReplacementNamed(context, '/');
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      } else {
        // API request failed
        // Show an error message or pop-up
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('Failed to update password. Please try again.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      // Handle network errors or other exceptions
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('An error occurred. Please try again.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Change Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: currentPasswordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Current Password'),
            ),
            TextField(
              controller: newPasswordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'New Password'),
            ),
            TextField(
              controller: retypePasswordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Retype New Password'),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: changePassword,
                  child: Text('Confirm'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  onPressed: () {
                    Navigator.pop(
                        context); // Cancel and go back to the previous screen
                  },
                  child: Text('Cancel'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
