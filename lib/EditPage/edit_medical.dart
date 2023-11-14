import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class EditMedicalPage extends StatefulWidget {
  final Map<String, dynamic>? userData;
  final FlutterSecureStorage storage;

  EditMedicalPage({required this.userData, required this.storage});

  @override
  State<EditMedicalPage> createState() => _EditMedicalPageState();
}

class _EditMedicalPageState extends State<EditMedicalPage> {
  Map<String, dynamic> updatedData = {};
  late TextEditingController bloodController;
  late TextEditingController ageController;
  late TextEditingController descriptionController;
  late TextEditingController diagnosisController;

  String? updatedBlood;
  String? updatedAge;
  String? updatedDescription;
  String? updatedDiagnosis;

  late String defaultBlood;
  late String defaultAge;
  late String defaultDescription;
  late String defaultDiagnosis;

  bool isEditing = false;

  @override
  void initState() {
    super.initState();
    bloodController =
        TextEditingController(text: widget.userData?['blood_group']);
    ageController = TextEditingController(text: widget.userData?['age']);
    descriptionController =
        TextEditingController(text: widget.userData?['description']);
    diagnosisController =
        TextEditingController(text: widget.userData?['diagnosis']);

    updatedBlood = widget.userData?['blood_group'];
    updatedAge = widget.userData?['age'];
    updatedDescription = widget.userData?['description'];
    updatedDiagnosis = widget.userData?['diagnosis'];

    updatedData = Map.from(widget.userData ?? {});

    defaultBlood = widget.userData?['blood_group'] ?? '';
    defaultAge = widget.userData?['age'] ?? '';
    defaultDescription = widget.userData?['description'] ?? '';
    defaultDiagnosis = widget.userData?['diagnosis'] ?? '';

    isEditing = false;
  }

  void resetValues() {
    setState(() {
      updatedBlood = defaultBlood;
      updatedAge = defaultAge;
      updatedDescription = defaultDescription;
      updatedDiagnosis = defaultDiagnosis;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Medical Details'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Blood group
              Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    Text(
                      'Blood Group: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: updatedBlood,
                        items:
                            ['A+', 'B+', 'AB+', 'O+', 'A-', 'B-', 'AB-', 'O-']
                                .map((type) => DropdownMenuItem<String>(
                                      value: type,
                                      child: Text(type),
                                    ))
                                .toList(),
                        onChanged: (value) {
                          setState(() {
                            updatedBlood = value;
                            bloodController.text = value!;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),

              // Age
              Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    Text(
                      'Age: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Enter your Age',
                        ),
                        controller: ageController,
                        onChanged: (value) {
                          setState(() {
                            updatedAge = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),

              // Diagnosis
              Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    Text(
                      'Diagnosis: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Enter your Diagnosis',
                        ),
                        controller: diagnosisController,
                        onChanged: (value) {
                          setState(() {
                            updatedDiagnosis = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),

              // Description
              Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    Text(
                      'Description: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: GestureDetector(
                        onDoubleTap: () {
                          setState(() {
                            isEditing = !isEditing;
                            updatedDescription =
                                widget.userData?['description'];
                            descriptionController.text = updatedDescription!;
                          });
                        },
                        child: isEditing
                            ? TextField(
                                decoration: InputDecoration(
                                  hintText:
                                      'Enter your Description for your Diagnosis',
                                ),
                                controller: descriptionController,
                                onChanged: (value) {
                                  setState(() {
                                    updatedDescription = value;
                                  });
                                },
                                maxLines: null,
                              )
                            : Text(
                                updatedDescription ?? '',
                                style: TextStyle(fontSize: 16),
                              ),
                      ),
                    ),
                  ],
                ),
              ),

              //Button to save and cancel
              Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () async {
                        final storage = FlutterSecureStorage();
                        String? studentId = await storage.read(key: 'std_id');
                        print(studentId);

                        if (studentId != null) {
                          String formattedStudentId = studentId.padLeft(8, '0');

                          Map<String, dynamic> postData = {
                            'blood_group': updatedBlood,
                            'age': updatedAge,
                            'description': updatedDescription,
                            'diagnosis': updatedDiagnosis,
                            'student_id': formattedStudentId,
                          };

                          try {
                            var response = await http.patch(
                              Uri.parse(
                                  'http://172.20.10.2:8888/api/users/student/medical'),
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
                                          Navigator.of(context).pop();
                                          Navigator.pop(context, postData);
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
                          print('Null StudentId');
                        }
                      },
                      icon: Icon(Icons.save, color: Colors.white),
                      label:
                          Text('Save', style: TextStyle(color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                    ),
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
                                    Navigator.of(context).pop();
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                      icon: Icon(Icons.cancel, color: Colors.white),
                      label:
                          Text('Cancel', style: TextStyle(color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
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
