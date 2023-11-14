import 'dart:convert';

import 'package:bottom_nav/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;

class ExampleItem {
  final String title;

  ExampleItem({
    required this.title,
  });
}

class ExampleItemPager {
  int pageIndex = 0;
  final int pageSize;

  ExampleItemPager({
    this.pageSize = 20,
  });

  List<ExampleItem> nextBatch() {
    List<ExampleItem> batch = [];

    for (int i = 0; i < pageSize; i++) {
      batch.add(ExampleItem(title: 'Item ${pageIndex * pageSize + i}'));
    }

    pageIndex += 1;

    return batch;
  }
}

class Home extends StatefulWidget {
  const Home({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<Home> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController _studentNumberController =
        TextEditingController();
    late Color mycolor = Theme.of(context).primaryColor;
    // ignore: unused_local_variable
    ExampleItemPager pager = ExampleItemPager();

    Future<void> _searchStudent(String studentNumber) async {
      // Perform the actual API request here
      try {
        final fetchresponse = await http.get(
          Uri.parse(
              'http://10.2.23.165:8888/api/users/student/0$studentNumber'),
        );
        print(studentNumber);

        if (fetchresponse.statusCode == 200) {
          var studentInfo = jsonDecode(fetchresponse.body);

          // Navigate to the mainscreen
          Navigator.push(
            context,
            MaterialPageRoute(
              // builder: (context) => HomePage(userData: studentInfo),
              builder: (context) => HomePage(),
            ),
          );
        } else {
          // Handle error
        }
      } catch (error) {
        // Handle network errors or exceptions
      }
      ;

      // For now, let's print the student number
      print('Searching for student with number: $studentNumber');
    }

    return Scaffold(
      body: ListView(children: [
        Center(
          child: Padding(
            // Setting Padding for the images
            padding: const EdgeInsets.only(
                top: 0.0), // Adjust the top padding as needed
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      constraints: BoxConstraints(
                          maxHeight: 200, maxWidth: double.infinity),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            Color(0xff022AAB),
                            Color(0xff2452E1),
                          ],
                        ),

                        // ignore: prefer_const_constructors
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.zero,
                          topRight: Radius.zero,
                          bottomLeft: Radius.elliptical(700, 590),
                          bottomRight: Radius.elliptical(700, 590),
                        ),

                        image: DecorationImage(
                          image: AssetImage('Images/settings.jpg'),
                          fit: BoxFit.fitWidth,
                          colorFilter: ColorFilter.mode(
                              mycolor.withOpacity(0.5), BlendMode.dstATop),
                        ),
                      ),
                    ),
                    const Column(
                      children: [
                        Text(
                          'Student Personal',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 33,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          'Management',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 33,
                              fontWeight: FontWeight.w400),
                        ),
                        Text(
                          'System',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 33,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 50),
                const Column(
                  children: [
                    Text(
                      'Search Student',
                      style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w400,
                          color: Color(
                            0xFF0028A8,
                          )),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: TextField(
                        controller: _studentNumberController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(
                              width: 0.8,
                              color: Colors.red, // Default border color
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(
                              width: 2,
                              color: Color.fromARGB(
                                  255, 46, 201, 38), // Focused border color
                            ),
                          ),
                          hintText: 'Search Student Number',
                          prefixIcon: Padding(
                            padding: EdgeInsets.all(10),
                            child: SvgPicture.asset('Images/search.svg'),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(Icons.close_sharp),
                            onPressed: () {
                              String studentNumber =
                                  _studentNumberController.text;
                              _searchStudent(studentNumber);
                            },
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
