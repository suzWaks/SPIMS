import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AddParticipationPage extends StatefulWidget {
  final FlutterSecureStorage storage;

  AddParticipationPage({required this.storage});

  @override
  State<AddParticipationPage> createState() => _AddParticipationPageState();
}

class _AddParticipationPageState extends State<AddParticipationPage> {
  TextEditingController participationNameController = TextEditingController();
  TextEditingController yearController = TextEditingController();
  String selectedRankPosition = 'Participation';
  String selectedGradeYear = '1st year';

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Participation Details'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Participation Name
              Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    Text(
                      'Participation Name: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Enter Participation Name',
                        ),
                        controller: participationNameController,
                      ),
                    ),
                  ],
                ),
              ),

              // Participation Year
              Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    Text(
                      'Year of Participation: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Enter the Year of participation',
                        ),
                        controller: yearController,
                      ),
                    ),
                  ],
                ),
              ),

              // Rank Position Dropdown
              Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    Text(
                      'Rank Position: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 10),
                    DropdownButton<String>(
                      value: selectedRankPosition,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedRankPosition = newValue!;
                        });
                      },
                      items: <String>['1st', '2nd', '3rd', 'Participation']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),

              // Grade Year Dropdown
              Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    Text(
                      'Grade Year: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 10),
                    DropdownButton<String>(
                      value: selectedGradeYear,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedGradeYear = newValue!;
                        });
                      },
                      items: <String>[
                        '1st year',
                        '2nd year',
                        '3rd year',
                        '4th year'
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),

              // Button to save and
              Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton.icon(
                      onPressed: isLoading
                          ? null
                          : () async {
                              setState(() {
                                isLoading = true;
                              });

                              String? studentId =
                                  await widget.storage.read(key: 'std_id');
                              print('StudentId: $studentId');

                              if (studentId != null) {
                                // Convert studentId to string and pad with leading zeros if needed
                                String formattedStudentId =
                                    studentId.padLeft(8, '0');

                                // Prepare the data to be sent in the request
                                Map<String, dynamic> postData = {
                                  'participation_name':
                                      participationNameController.text,
                                  'year': yearController.text,
                                  'rank_position': selectedRankPosition,
                                  'grade_year': selectedGradeYear,
                                  'participation_Std_id': formattedStudentId,
                                };

                                try {
                                  var response = await http.post(
                                    Uri.parse(
                                        'http://172.20.10.2:8888/api/users/student/participation'),
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
                                          content: Text(
                                              'Participation Details Added Successfully'),
                                          actions: <Widget>[
                                            TextButton(
                                              child: Text('OK'),
                                              onPressed: () {
                                                Navigator.of(context)
                                                    .pop(); // Close the dialog
                                                Navigator.pop(context,
                                                    postData); // Pass the added data back
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  } else {
                                    print(
                                        'Failed to add participation details. Status code: ${response.statusCode}');
                                  }
                                } catch (error) {
                                  print(
                                      'Error adding participation details: $error');
                                  throw error;
                                } finally {
                                  setState(() {
                                    isLoading = false;
                                  });
                                }
                              } else {
                                print("Null StudentId");
                              }
                            },
                      icon: Icon(Icons.save, color: Colors.white),
                      label:
                          Text('Save', style: TextStyle(color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    ElevatedButton(
                      onPressed: isLoading
                          ? null
                          : () {
                              Navigator.of(context).pop();
                            },
                      child: Text('Cancel'),
                      style:
                          ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    ),
                  ],
                ),
              ),
              // Display circular progress indicator while loading data
            ],
          ),
        ),
      ),
    );
  }
}
