import 'dart:convert';

import 'package:bottom_nav/Drawer/internrecord.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class InternshipFormPage extends StatefulWidget {
  final Function onSubmit;

  InternshipFormPage({required this.onSubmit});

  @override
  _InternshipFormPageState createState() => _InternshipFormPageState();
}

class _InternshipFormPageState extends State<InternshipFormPage> {
  final TextEditingController companyNameController = TextEditingController();
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  DateTime? selectedStartDate;

  Future<void> _selectStartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedStartDate) {
      setState(() {
        selectedStartDate = picked;
        startDateController.text =
            DateFormat('yyyy-MM-ddTHH:mm:ss.000Z').format(picked.toUtc());
      });
    }
  }

  DateTime? selectedEndDate;

  Future<void> _selectEndDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedEndDate) {
      setState(() {
        selectedEndDate = picked;
        endDateController.text =
            DateFormat('yyyy-MM-ddTHH:mm:ss.000Z').format(picked.toUtc());
      });
    }
  }

  final FlutterSecureStorage storage = FlutterSecureStorage();

  Future<void> addInternshipRecord(InternshipRecord record) async {
    String? iStd_id = await storage.read(key: 'std_id');
    print('Adding: $iStd_id');

    Map<String, dynamic> postData = {
      'Company_name': record.Company_name,
      'Start_date': record.startDate,
      'End_date': record.endDate,
      'iDescription': record.description,
      'iStd_id': '0$iStd_id',
    };

    try {
      final response = await http.post(
        Uri.parse('http://172.20.10.2:8888/api/users/student/internship'),
        headers: {
          'Content-Type': 'application/json',
        },
        // body: jsonEncode(record),
        body: jsonEncode(postData),
      );

      print('Data to be posted: $postData');

      if (response.statusCode == 200) {
        print('Internship record added successfully!');
        // Show success dialog
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Success'),
              content: Text('Internship record added successfully!'),
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
      } else {
        print(
            'Failed to add internship record. Status code: ${response.statusCode}');
        // Show error dialog
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('Failed to add internship record.'),
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
      }
    } catch (e) {
      print('Error adding internship record: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Internship Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: companyNameController,
              decoration: InputDecoration(labelText: 'Company name'),
            ),
            TextField(
              controller: startDateController,
              decoration: InputDecoration(labelText: 'Start Date'),
              onTap: () => _selectStartDate(context),
            ),
            TextField(
              controller: endDateController,
              decoration: InputDecoration(labelText: 'End Date'),
              onTap: () => _selectEndDate(context),
            ),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                // Fetch student ID
                String? studentId = await storage.read(key: 'std_id');
                print("StudentId: $studentId");

                // Create a new InternshipRecord
                InternshipRecord newRecord = InternshipRecord(
                  Company_name: companyNameController.text,
                  startDate: startDateController.text,
                  endDate: endDateController.text,
                  description: descriptionController.text,
                  iStd_id: '0$studentId',
                );

                // Add the InternshipRecord to the database
                await addInternshipRecord(newRecord);

                widget.onSubmit(newRecord);
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
