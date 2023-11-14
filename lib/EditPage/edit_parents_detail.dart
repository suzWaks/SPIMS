import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class EditParentPage extends StatefulWidget {
  final Map<String, dynamic>? userData;
  final FlutterSecureStorage storage;

  EditParentPage({required this.userData, required this.storage});

  @override
  State<EditParentPage> createState() => _EditParentPageState();
}

class _EditParentPageState extends State<EditParentPage> {
  // Create a Map to store the updated data
  Map<String, dynamic> updatedData = {};

  late TextEditingController nameController;
  late TextEditingController cidController;
  late TextEditingController contactNumController;
  late TextEditingController emailController;

  @override
  void initState() {
    super.initState();
    // Set the initial values
    nameController = TextEditingController(text: widget.userData?['pname']);
    cidController = TextEditingController(text: widget.userData?['p_cid']);
    contactNumController = TextEditingController(
        text: widget.userData?['pcontact_num']?.toString());
    emailController = TextEditingController(text: widget.userData?['p_email']);

    // Initialize the updatedData with the initial userData
    updatedData = Map.from(widget.userData ?? {});
  }

  void resetValues() {
    setState(() {
      nameController.text = updatedData['pname'] ?? '';
      cidController.text = updatedData['p_cid'] ?? '';
      contactNumController.text = updatedData['pcontact_num']?.toString() ?? '';
      emailController.text = updatedData['p_email'] ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Parents Detail'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                          hintText: 'Enter Parents name',
                        ),
                        controller: nameController,
                        onChanged: (value) {
                          setState(() {
                            updatedData['pname'] = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
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
                          hintText: 'Enter Parents CID number',
                        ),
                        controller: cidController,
                        onChanged: (value) {
                          setState(() {
                            updatedData['p_cid'] = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
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
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        decoration: InputDecoration(
                          hintText: 'Enter Parents Contact Number',
                        ),
                        controller: contactNumController,
                        onChanged: (value) {
                          setState(() {
                            updatedData['pcontact_num'] = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    Text(
                      'Email: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Enter Parents email',
                        ),
                        controller: emailController,
                        onChanged: (value) {
                          setState(() {
                            updatedData['p_email'] = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
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
                            'pname': updatedData['pname'] ?? '',
                            'relation': updatedData['relation'] ?? '',
                            'p_cid': updatedData['p_cid'] ?? '',
                            'pcontact_num': updatedData['pcontact_num'] ?? '',
                            'p_email': updatedData['p_email'] ?? '',
                            'pstudent_num': formattedStudentId,
                          };

                          try {
                            var response = await http.patch(
                              Uri.parse(
                                  'http://172.20.10.2:8888/api/users/parent'),
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
                          print("Null StudentId");
                        }
                      },
                      icon: Icon(Icons.save, color: Colors.white),
                      label:
                          Text('Save', style: TextStyle(color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green),
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
