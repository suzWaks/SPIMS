import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class editBasicPage extends StatefulWidget {
  final Map<String, dynamic>?
      userData; // Add a property to receive the user data
  final FlutterSecureStorage storage;

  // const editBasicPage({Key? key, this.userData}) : super(key: key);
  editBasicPage({required this.userData, required this.storage});

  @override
  State<editBasicPage> createState() => _editBasicPageState();
}

class _editBasicPageState extends State<editBasicPage> {
  // Create a Map to store the updated data
  Map<String, dynamic> updatedData = {};

  String? updatedName;
  // String? updatedDob;
  String? updatedSex;
  String? updatedCid;
  String? updatedContactNum;
  String? updatedScholarship;
  String? updatedYear;
  String? updatedSem;

// Define default values
  late String defaultName;
  late String defaultSex;
  late String defaultCid;
  late int defaultContactNum;
  late String defaultScholarship;
  late String defaultYear;
  late String defaultSem;

  @override
  void initState() {
    super.initState();
    // Set the initial value
    updatedName = widget.userData?['name'];
    // updatedDob = widget.userData?['dob'];
    updatedSex = widget.userData?['sex'];
    updatedCid = widget.userData?['cid'];
    updatedContactNum = widget.userData?['contact_num']?.toString();
    updatedScholarship = widget.userData?['scholarship_type'];
    updatedYear = widget.userData?['year'];
    updatedSem = widget.userData?['sem'];

    // Initialize the updatedData with the initial userData
    updatedData = Map.from(widget.userData ?? {});

    // Initialize the default values
    defaultName = widget.userData?['name'] ?? '';
    defaultSex = widget.userData?['sex'] ?? '';
    defaultCid = widget.userData?['cid'] ?? '';
    defaultContactNum =
        int.parse(widget.userData!['contact_num'].toString()) ?? 0;
    defaultScholarship = widget.userData?['scholarship_type'] ?? '';
    defaultYear = widget.userData?['year'] ?? '';
    defaultSem = widget.userData?['sem'] ?? '';
  }

  void resetValues() {
    setState(() {
      updatedName = defaultName;
      updatedSex = defaultSex;
      updatedCid = defaultCid;
      updatedContactNum = defaultContactNum.toString();
      updatedScholarship = defaultScholarship;
      updatedYear = defaultYear;
      updatedSem = defaultSem;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Basic Details'),
        backgroundColor: Theme.of(context)
            .primaryColor, // Use the provided color for the app bar
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // name
              Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    Text(
                      'Name: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Enter your name',
                        ),
                        controller: TextEditingController(
                          text: widget.userData?['name'],
                        ),
                        onChanged: (value) {
                          setState(() {
                            updatedName = value;
                            widget.userData?['name'] = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),

              // // Sex
              Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    Text(
                      'Sex: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 10),
                    Row(
                      children: <Widget>[
                        Radio<String>(
                          value: 'Male',
                          groupValue: updatedSex,
                          onChanged: (String? value) {
                            setState(() {
                              updatedSex = value;
                              widget.userData?['sex'] = value;
                            });
                            // Do something with the selected value
                          },
                        ),
                        Text('Male'),
                        Radio<String>(
                          value: 'Female',
                          groupValue: updatedSex,
                          onChanged: (String? value) {
                            setState(() {
                              updatedSex = value;
                              widget.userData?['sex'] = value;
                            });
                          },
                        ),
                        Text('Female'),
                      ],
                    ),
                  ],
                ),
              ),

              // //CID
              Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    Text(
                      'CID No: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Enter your CID number',
                        ),
                        controller: TextEditingController(
                          text: widget.userData?['cid'],
                        ),
                        onChanged: (value) {
                          setState(() {
                            updatedCid = value;
                            widget.userData?['cid'] = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),

              // // Contact Number
              Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    Text(
                      'Contact No: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: TextFormField(
                        keyboardType: TextInputType
                            .number, // Set the input type to number
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ], // Allow only digits
                        decoration: InputDecoration(
                          hintText: 'Enter Your Contact Number',
                        ),
                        controller: TextEditingController(
                          text: widget.userData?['contact_num'].toString(),
                        ),
                        onChanged: (value) {
                          setState(() {
                            updatedContactNum = value;
                            widget.userData?['contact_num'] = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),

              // // Scholarship Type
              Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    Text(
                      'Scholarship Type: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: widget.userData?['scholarship_type'] ?? '',
                        items: ['Government', 'Self']
                            .map((type) => DropdownMenuItem<String>(
                                  value: type,
                                  child: Text(type),
                                ))
                            .toList(),
                        onChanged: (value) {
                          updatedScholarship = value;
                          widget.userData?['scholarship_type'] = value;
                        },
                      ),
                    ),
                  ],
                ),
              ),

              // // Year
              Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    Text(
                      'Year: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: widget.userData?['year'] ?? '',
                        items: ['1st Year', '2nd Year', '3rd Year', '4th Year']
                            .map((year) => DropdownMenuItem<String>(
                                  value: year,
                                  child: Text(year),
                                ))
                            .toList(),
                        onChanged: (value) {
                          updatedYear = value;
                          widget.userData?['year'] = value;
                        },
                      ),
                    ),
                  ],
                ),
              ),

              // Semester
              Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    Text(
                      'Semester: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: widget.userData?['sem'] ?? '',
                        items: [
                          '1st Semester',
                          '2nd Semester',
                          '3rd Semester',
                          '4th Semester',
                          '5th Semester',
                          '6th Semester',
                          '7th Semester',
                          '8th Semester',
                          '9th Semester',
                          '10th Semester',
                        ]
                            .map((semester) => DropdownMenuItem<String>(
                                  value: semester,
                                  child: Text(semester),
                                ))
                            .toList(),
                        onChanged: (value) {
                          updatedSem = value;
                          widget.userData?['sem'] = value;
                        },
                      ),
                    ),
                  ],
                ),
              ),

              // Button to save and
              Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment
                      .spaceEvenly, // Adjust alignment as needed
                  children: [
                    //Save Button
                    ElevatedButton.icon(
                      onPressed: () async {
                        final storage = FlutterSecureStorage();
                        String? studentId = await storage.read(key: 'std_id');

                        // Make the post request
                        if (studentId != null) {
                          // Convert studentId to string and pad with leading zeros if needed
                          String formattedStudentId = studentId.padLeft(8, '0');

                          // Prepare the data to be sent in the request
                          Map<String, dynamic> postData = {
                            'name': widget.userData?['name'] ?? '',
                            // 'dob': widget.userData?['dob'] ?? '',
                            'sex': widget.userData?['sex'] ?? '',
                            'cid': widget.userData?['cid'] ?? '',
                            'contact_num':
                                widget.userData?['contact_num'] ?? '',
                            'scholarship_type':
                                widget.userData?['scholarship_type'] ?? '',
                            'year': widget.userData?['year'] ?? '',
                            'sem': widget.userData?['sem'] ?? '',
                            'student_id': formattedStudentId,
                          };

                          try {
                            var response = await http.patch(
                              Uri.parse(
                                  'http://172.20.10.2:8888/api/users/student'),
                              headers: {
                                'Content-Type': 'application/json',
                              },
                              body: jsonEncode(postData),
                            );

                            if (response.statusCode == 200) {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Row(
                                      children: [
                                        Icon(
                                          Icons.check_circle,
                                          color: Colors.green,
                                        ),
                                        SizedBox(width: 8),
                                        Text('Success'),
                                      ],
                                    ),
                                    content: Text('Data Updated Successfully'),
                                    actions: <Widget>[
                                      TextButton(
                                        child: Text('OK'),
                                        onPressed: () {
                                          Navigator.of(context)
                                              .pop(); // Close the dialog
                                          Navigator.pop(context,
                                              postData); // Pass the updated data back
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            } else {
                              print(
                                  'Failed to update the data. Status code: ${response.statusCode}');
                            }
                          } catch (error) {
                            print('Error fetching user data: $error');
                            throw error;
                          }
                        } else {
                          print("Null StudentId");
                        }
                      },

                      icon: Icon(Icons.save, color: Colors.white), // Save icon
                      label:
                          Text('Save', style: TextStyle(color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Colors.green), // Set the button color to green
                    ),

                    // Cancel button
                    ElevatedButton.icon(
                      onPressed: () {
                        resetValues();
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Cancelled'),
                              content: Text('Changes have been cancelled.'),
                              actions: <Widget>[
                                TextButton(
                                  child: Text('OK'),
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pop(); // Close the dialog
                                    Navigator.pop(
                                        context); // Navigate back to the home page
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                      icon: Icon(Icons.cancel,
                          color: Colors.white), // Cancel icon
                      label:
                          Text('Cancel', style: TextStyle(color: Colors.white)),
                      style:
                          ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
