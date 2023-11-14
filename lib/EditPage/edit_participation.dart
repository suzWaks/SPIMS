import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class EditParticipationPage extends StatefulWidget {
  final Map<String, dynamic>? participationData;
  final FlutterSecureStorage storage;

  EditParticipationPage(
      {required this.participationData, required this.storage});

  @override
  State<EditParticipationPage> createState() => _EditParticipationPageState();
}

class _EditParticipationPageState extends State<EditParticipationPage> {
  // Create a Map to store the updated data
  Map<String, dynamic> updatedParticipationData = {};

  late TextEditingController participationNameController;
  late TextEditingController yearController;

  String? updatedRank;
  String? updatedGradeYear;

  // Define default values
  late String defaultParticipationName;
  late String defaultYear;
  late String defaultRank;
  late String defaultGradeYear;

  @override
  void initState() {
    super.initState();

    // Initialize controllers with the initial values
    participationNameController = TextEditingController(
        text: widget.participationData?['participation_name']);
    yearController =
        TextEditingController(text: widget.participationData?['year']);

    // Set the initial values
    updatedRank = widget.participationData?['rank_position'];
    updatedGradeYear = widget.participationData?['grade_year'];

    // Initialize the updatedParticipationData with the initial data
    updatedParticipationData = Map.from(widget.participationData ?? {});

    // Initialize the default values
    defaultParticipationName =
        widget.participationData?['participation_name'] ?? '';
    defaultYear = widget.participationData?['year'] ?? '';
    defaultRank = widget.participationData?['rank_position'] ?? '';
    defaultGradeYear = widget.participationData?['grade_year'] ?? '';
  }

  void resetValues() {
    setState(() {
      participationNameController.text = defaultParticipationName;
      yearController.text = defaultYear;
      updatedRank = defaultRank;
      updatedGradeYear = defaultGradeYear;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Participation Details'),
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
                        onChanged: (value) {
                          setState(() {
                            updatedParticipationData['participation_name'] =
                                value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),

              // Year
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
                          hintText: 'Enter Year of Participation',
                        ),
                        controller: yearController,
                        onChanged: (value) {
                          setState(() {
                            updatedParticipationData['year'] = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),

              // Rank
              Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    Text(
                      'Rank Position: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: updatedRank,
                        items: ['1st', '2nd', '3rd', 'Participation']
                            .map((rank) => DropdownMenuItem<String>(
                                  value: rank,
                                  child: Text(rank),
                                ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            updatedRank = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),

              // Grade Year
              Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    Text(
                      'Grade Year: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: updatedGradeYear,
                        items: ['1st year', '2nd year', '3rd year', '4th year']
                            .map((grade) => DropdownMenuItem<String>(
                                  value: grade,
                                  child: Text(grade),
                                ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            updatedGradeYear = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),

              // Button to save and cancel
              Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Save Button
                    ElevatedButton.icon(
                      onPressed: () async {
                        final storage = FlutterSecureStorage();
                        String? studentId = await storage.read(key: 'std_id');

                        // Make the post request
                        if (studentId != null) {
                          // Convert studentId to string and pad with leading zeros if needed
                          String formattedStudentId = studentId.padLeft(8, '0');
                          print(formattedStudentId);

                          // Read the stored record_id and parse it to an integer
                          String? storedRecordId = await widget.storage
                              .read(key: 'selected_record_id');
                          if (storedRecordId != null) {
                            updatedParticipationData['record_id'] =
                                int.parse(storedRecordId);
                          }
                          print('Record_id: $storedRecordId');

                          // Prepare the data to be sent in the request
                          // Map<String, dynamic> postData = {
                          //   'participation_name': updatedParticipationData[
                          //           'participation_name'] ??
                          //       '',
                          //   'year': updatedParticipationData['year'] ?? '',
                          //   'rank_position': updatedRank ?? '',
                          //   'grade_year': updatedGradeYear ?? '',
                          //   'record_id': storedRecordId,
                          // };

                          Map<String, dynamic> postData = {
                            'record_id': storedRecordId,
                            'participation_name':
                                updatedParticipationData['participation_name'],
                            'year': updatedParticipationData['year'],
                            'rank_position': updatedRank,
                            'grade_year': updatedGradeYear,
                            'participation_Std_id': formattedStudentId,
                          };

                          try {
                            var response = await http.patch(
                              Uri.parse(
                                  'http://172.20.10.2:8888/api/users/student/participation/$storedRecordId'),
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
