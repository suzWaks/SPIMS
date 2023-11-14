import 'dart:convert';

import 'package:bottom_nav/Drawer/internrecord.dart';
import 'package:bottom_nav/EditPage/add_internship.dart';
import 'package:bottom_nav/Fetchmodules/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class InternshipRecord {
  final String Company_name;
  final String startDate;
  final String endDate;
  final String description;
  final String iStd_id;

  InternshipRecord({
    required this.Company_name,
    required this.startDate,
    required this.endDate,
    required this.description,
    required this.iStd_id,
  });
}

class InternRecordPage extends StatefulWidget {
  @override
  _InternRecordPageState createState() => _InternRecordPageState();
}

class _InternRecordPageState extends State<InternRecordPage> {
  late List<InternshipRecord> internshipRecords;
  // late int currentIndex;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    internshipRecords = [];
  }

  Future<List<dynamic>> fetchInternshipRecords() async {
    final storage = FlutterSecureStorage();
    String? iStd_id = await storage.read(key: 'std_id');
    print(iStd_id);

    try {
      final response = await http.get(Uri.parse(
          'http://172.20.10.2:8888/api/users/student/intern/0$iStd_id'));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        internshipRecords.addAll(data.map((record) {
          return InternshipRecord(
            Company_name: record['Company_name'] ?? '',
            startDate: record['Start_date'] ?? '',
            endDate: record['End_date'] ?? '',
            description: record['iDescription'] ?? '',
            iStd_id: record['iStd_id'] ?? '',
          );
        }).toList());

        return data;
      } else {
        print('Failed to load internship records');
        return [];
      }
    } catch (e) {
      print('Error while fetching data from the API: $e');
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Intern Record',
              style: TextStyle(
                fontSize: 35.0,
                color: Color.fromARGB(255, 255, 102, 0),
              ),
            ),
            const SizedBox(height: 20),
            FutureBuilder<List<dynamic>>(
              future: fetchInternshipRecords(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // print('waiting');
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (!snapshot.hasData || internshipRecords.isEmpty) {
                  return Center(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 100,
                        ),
                        Text(
                          'No Internship Record',
                          style: TextStyle(fontSize: 25),
                        ),
                      ],
                    ),
                  );
                } else {
                  List<dynamic> internshipRecords =
                      snapshot.data as List<dynamic>;

                  print('Records: $internshipRecords');

                  return Expanded(
                    child: ListView.builder(
                      itemCount: internshipRecords.length,
                      itemBuilder: (context, index) {
                        InternshipRecord record = InternshipRecord(
                          Company_name:
                              internshipRecords[index]['Company_name'] ?? '',
                          startDate:
                              internshipRecords[index]['Start_date'] ?? '',
                          endDate: internshipRecords[index]['End_date'] ?? '',
                          description:
                              internshipRecords[index]['iDescription'] ?? '',
                          iStd_id: internshipRecords[index]['iStd_id'] ?? '',
                        );

                        String formattedStartDate = DateFormat('dd-MM-yyyy')
                            .format(DateTime.parse(record.startDate));
                        String formattedEndDate = DateFormat('dd-MM-yyyy')
                            .format(DateTime.parse(record.endDate));

                        return Column(
                          children: [
                            CustomTab(internshipRecord: record),
                            SizedBox(height: 16),
                          ],
                        );
                      },
                    ),
                  );
                }
              },
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => InternshipFormPage(
                      onSubmit: (InternshipRecord newRecord) {
                        print("New Internship record added: $newRecord");
                      },
                    ),
                  ),
                );
              },
              child: Text('Add Internship Record'),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: EdgeInsets.symmetric(
                    vertical: 16, horizontal: 32), // Adjust the padding values
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomTab extends StatelessWidget {
  final InternshipRecord? internshipRecord;

  CustomTab({required this.internshipRecord});

  @override
  Widget build(BuildContext context) {
    if (internshipRecord == null) {
      return Center(
        child: Text('No Internship Data'),
      );
    }

    // Format date
    String formattedStartDate = DateFormat('dd/MM/yyyy')
        .format(DateTime.parse(internshipRecord!.startDate));
    String formattedEndDate = DateFormat('dd/MM/yyyy')
        .format(DateTime.parse(internshipRecord!.endDate));

    return Container(
      alignment: Alignment.topCenter,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
        border: Border.all(
          color: Color.fromARGB(255, 255, 102, 0),
          width: 1.0,
        ),
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(255, 184, 184, 184).withOpacity(0.5),
            spreadRadius: 1.5,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '    ${internshipRecord?.Company_name ?? ''}',
              style: TextStyle(
                fontSize: 30.0,
                color: Colors.black,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              ' $formattedStartDate-$formattedEndDate',
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.grey,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              ' ${internshipRecord?.description ?? ''}',
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.grey,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Color.fromARGB(255, 255, 102, 0),
                    width: 2.0,
                  ),
                ),
              ),
              padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 12.0),
            ),
          ],
        ),
      ),
    );
  }
}
