import 'dart:convert';
import 'package:bottom_nav/AdminPanel/adminHome.dart';
import 'package:bottom_nav/Fetchmodules/api_service.dart';
import 'package:bottom_nav/Lecturer/lecturer.dart';
import 'package:bottom_nav/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // final ApiService apiService = ApiService();

  late Color mycolor;
  late Size mediaSize;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isPasswordVisible = false;

// Login
  final storage = FlutterSecureStorage(); //Initialize the secure storage
  //Passing the sorage to the Api service with the (std_id and token) in storage
  late final ApiService apistorage;

  @override
  void initState() {
    super.initState();
    apistorage = ApiService(storage);
  }

  Future<Map<String, dynamic>> loginUser(String email, String password) async {
    final response = await http.post(
      Uri.parse('http://172.20.10.2:8888/api/users/loginRole'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = json.decode(response.body);

      return responseData;
      // return json.decode(response.body);
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Invalid Email or Password'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
      throw Exception('Invalid Email or Password');
    }
  }

  void _handleLogin(BuildContext context) async {
    try {
      var response =
          await loginUser(emailController.text, passwordController.text);

      if (response['message'] == 'Login successful') {
        await storage.write(key: 'token', value: response['token']);
        Provider.of<AuthProvider>(context, listen: false).login();

        if (response['role'] == 'student') {
          // Split the email address to get the username

          String getemail = emailController.text;
          List<String> num = getemail.split('.');
          int std_id = int.parse(num[0]);

          // Storing the student id in the storage as a key value pair
          await storage.write(key: 'std_id', value: std_id.toString());
          Navigator.pushReplacementNamed(
            context,
            '/home',
          );
        } else if (response['role'] == 'staff') {
          _navigateToStaff(context);
        } else if (response['role'] == 'admin') {
          _navigateToAdmin(context);
        }
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    mycolor = Theme.of(context).primaryColor;

    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Containers for Images
            Container(
              constraints:
                  BoxConstraints(maxHeight: 200, maxWidth: double.infinity),
              decoration: BoxDecoration(
                color: mycolor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.zero,
                  topRight: Radius.zero,
                  bottomLeft: Radius.elliptical(700, 590),
                  bottomRight: Radius.elliptical(700, 590),
                ),
                image: DecorationImage(
                  image: AssetImage('Images/basketball_Login.jpeg'),
                  fit: BoxFit.fitWidth,
                  colorFilter: ColorFilter.mode(
                      mycolor.withOpacity(0.4), BlendMode.dstATop),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                children: [
                  // Setting The Text
                  Text(
                    'Login',
                    style: TextStyle(
                      color: Color(0xFF0028A8),
                      fontSize: 40,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 20),

                  // Email Address
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: 'Email Address',
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(10),
                        child: SvgPicture.asset('Images/email.svg'),
                      ),
                    ),
                  ),

                  SizedBox(height: 10),
                  // Password
                  TextField(
                    controller: passwordController,
                    obscureText: !isPasswordVisible,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(10),
                        child: SvgPicture.asset('Images/password.svg'),
                      ),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            isPasswordVisible = !isPasswordVisible;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: SvgPicture.asset(isPasswordVisible
                              ? 'Images/ee.svg'
                              : 'Images/password_hide.svg'),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 50),

                  //Login Button
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 70),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            Color(0xff0028a8),
                            Color(0xff2a54d5),
                            Color(0xff0028a8),
                          ],
                        ),
                      ),
                      child: ElevatedButton(
                        onPressed: () => _handleLogin(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors
                              .transparent, //Make the button background transparent
                          shadowColor: Colors.transparent, //Remove the shadow
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Login',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 19,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),

                  // // Add space between buttons and "Or"
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     Expanded(
                  //       child: Padding(
                  //         padding: const EdgeInsets.symmetric(horizontal: 30),
                  //         child: Divider(
                  //           color: Colors.black,
                  //         ),
                  //       ),
                  //     ),
                  //     Padding(
                  //       padding: const EdgeInsets.symmetric(horizontal: 20),
                  //       child: Text(
                  //         'Or',
                  //         style: TextStyle(
                  //           fontSize: 16,
                  //           fontWeight: FontWeight.bold,
                  //         ),
                  //       ),
                  //     ),
                  //     Expanded(
                  //       child: Padding(
                  //         padding: const EdgeInsets.symmetric(horizontal: 30),
                  //         child: Divider(
                  //           color: Colors.black,
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),

                  SizedBox(height: 30),
                  // Sign up using google button
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 40),
                  //   child: ElevatedButton(
                  //     onPressed: () {
                  //       // Add your sign up with Google action here
                  //     },
                  //     style: ElevatedButton.styleFrom(
                  //       backgroundColor:
                  //           const Color.fromARGB(188, 255, 255, 255),
                  //       foregroundColor: Colors.black,
                  //       shape: RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.circular(20),
                  //       ),
                  //     ),
                  //     child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.center,
                  //       children: [
                  //         Image.asset(
                  //           'Images/google_logo.png',
                  //           height: 35, // Adjust the height as needed
                  //           width: 35, // Adjust the width as needed
                  //         ),
                  //         SizedBox(width: 10),
                  //         Text(
                  //           'Log in with Google',
                  //           style: TextStyle(
                  //             fontSize: 19,
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Navigating to Staff
void _navigateToStaff(BuildContext context) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context) => lecturer(), // Replace with your staff screen
    ),
  );
}

// Navigating to Admin
void _navigateToAdmin(BuildContext context) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context) => AdminHomePage(), // Replace with your staff screen
    ),
  );
}
