import 'dart:convert';

import 'package:bottom_nav/EditPage/add_participation.dart';
import 'package:bottom_nav/EditPage/edit_participation.dart';
import 'package:flutter/material.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class CoCurricularPage extends StatefulWidget {
  @override
  State<CoCurricularPage> createState() => _CoCurricularPageState();
}

class _CoCurricularPageState extends State<CoCurricularPage> {
  final storage = FlutterSecureStorage();

  final CarouselController _carouselController = CarouselController();

  Future<List<Map<String, dynamic>>> fetchParticipationData() async {
    // Fetch the studetn Id
    String? studentId = await storage.read(key: 'std_id');

    print('StudentId: $studentId');

    if (studentId == null) {
      throw Exception('Student ID not found in Flutter Secure Storage');
    }

    final response = await http.get(
      Uri.parse(
          'http://172.20.10.2:8888/api/users/student/participation/0$studentId'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.cast<Map<String, dynamic>>();
    } else {
      throw Exception('Failed to load participation data');
    }
  }

  List<Map<String, dynamic>> filterParticipationByYear(
      List<Map<String, dynamic>> data, String year) {
    return data.where((record) => record['grade_year'] == year).toList();
  }

  void _onDataCellDoubleTap(Map<String, dynamic> record) async {
    // Store the record_id in Flutter Secure Storage
    await storage.write(
        key: 'selected_record_id', value: record['record_id'].toString());

    // Navigate to the edit page with the current record
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditParticipationPage(
          storage: storage,
          participationData: record,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color:
            Color.fromARGB(255, 255, 255, 255), // White background or the tab
        width: double.infinity, // Make the tab to fill the screen
        height: double.infinity,
        child: ContainedTabBarView(
          // Using the package contained_tab_bar_view
          tabBarProperties: const TabBarProperties(
            unselectedLabelColor: Color.fromARGB(
                255, 13, 22, 189), // Color of the unselected label
            indicator: BoxDecoration(
              color: Color.fromARGB(255, 13, 22,
                  189), // Color of the indicator on the selected tab
            ),
          ),
          tabs: [
            Text('1st Year'),
            Text('2nd Year'),
            Text('3rd Year'),
            Text('4th Year'),
          ],
          views: [
            // 1st Year tab
            Container(
              child: FutureBuilder(
                future: fetchParticipationData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (snapshot.hasData && snapshot.data != null) {
                    // List<Map<String, dynamic>> participationData =
                    //     snapshot.data!;
                    List<Map<String, dynamic>> participationData =
                        filterParticipationByYear(snapshot.data!, '1st year');

                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: DataTable(
                              border: TableBorder.all(
                                  color: Color.fromRGBO(0, 0, 0, 1)),
                              dataRowColor: MaterialStateProperty.all(
                                  Color.fromARGB(255, 255, 255, 255)),
                              headingRowColor: MaterialStateProperty.all(
                                  Color.fromRGBO(255, 102, 0, 1)),
                              headingTextStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color.fromRGBO(255, 255, 255, 1),
                              ),
                              columns: const [
                                DataColumn(
                                  label: Text('Participation Name'),
                                ),
                                DataColumn(
                                  label: Text('Year'),
                                ),
                                DataColumn(
                                  label: Text('Rank'),
                                ),
                              ],
                              rows: participationData
                                  .map(
                                    (record) => DataRow(
                                      cells: [
                                        DataCell(
                                          GestureDetector(
                                            onDoubleTap: () =>
                                                _onDataCellDoubleTap(
                                              record,
                                            ),
                                            child: Text(
                                                record['participation_name']
                                                    .toString()),
                                          ),
                                        ),
                                        // DataCell(
                                        //   Text(record['participation_name']
                                        //       .toString()),
                                        // ),
                                        DataCell(
                                          Text(record['year'].toString()),
                                        ),
                                        DataCell(
                                          Text(record['rank_position']
                                              .toString()),
                                        ),
                                      ],
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    AddParticipationPage(storage: storage),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  20.0), // Adjust the value for the desired level of circularity
                            ),
                            padding: EdgeInsets.all(
                                16.0), // Adjust the padding for the desired size
                            backgroundColor: Colors
                                .blue, // Adjust the background color as needed
                          ),
                          child: Text('Add Participation'),
                        ),
                      ],
                    );
                  } else {
                    return Text('No Participation Record for 1st Year');
                  }
                },
              ),
            ),

            // 2nd year Tab
            Container(
              child: FutureBuilder(
                future: fetchParticipationData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (snapshot.hasData && snapshot.data != null) {
                    // List<Map<String, dynamic>> participationData =
                    //     snapshot.data!;
                    List<Map<String, dynamic>> participationData =
                        filterParticipationByYear(snapshot.data!, '2nd year');

                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: DataTable(
                              border: TableBorder.all(
                                  color: Color.fromRGBO(0, 0, 0, 1)),
                              dataRowColor: MaterialStateProperty.all(
                                  Color.fromARGB(255, 255, 255, 255)),
                              headingRowColor: MaterialStateProperty.all(
                                  Color.fromRGBO(255, 102, 0, 1)),
                              headingTextStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color.fromRGBO(255, 255, 255, 1),
                              ),
                              columns: const [
                                DataColumn(
                                  label: Text('Participation Name'),
                                ),
                                DataColumn(
                                  label: Text('Year'),
                                ),
                                DataColumn(
                                  label: Text('Rank'),
                                ),
                              ],
                              rows: participationData
                                  .map(
                                    (record) => DataRow(
                                      cells: [
                                        DataCell(
                                          Text(record['participation_name']
                                              .toString()),
                                        ),
                                        DataCell(
                                          Text(record['year'].toString()),
                                        ),
                                        DataCell(
                                          Text(record['rank_position']
                                              .toString()),
                                        ),
                                      ],
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    AddParticipationPage(storage: storage),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  20.0), // Adjust the value for the desired level of circularity
                            ),
                            padding: EdgeInsets.all(
                                16.0), // Adjust the padding for the desired size
                            backgroundColor: Colors
                                .blue, // Adjust the background color as needed
                          ),
                          child: Text('Add Participation'),
                        ),
                      ],
                    );
                  } else {
                    return Text('No Participation Record for 2nd Year');
                  }
                },
              ),
              // color: Colors.green,
            ),

            // Design for 3rd Year Tab

            Container(
              child: FutureBuilder(
                future: fetchParticipationData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (snapshot.hasData && snapshot.data != null) {
                    // List<Map<String, dynamic>> participationData =
                    //     snapshot.data!;
                    List<Map<String, dynamic>> participationData =
                        filterParticipationByYear(snapshot.data!, '3rd year');

                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: DataTable(
                              border: TableBorder.all(
                                  color: Color.fromRGBO(0, 0, 0, 1)),
                              dataRowColor: MaterialStateProperty.all(
                                  Color.fromARGB(255, 255, 255, 255)),
                              headingRowColor: MaterialStateProperty.all(
                                  Color.fromRGBO(255, 102, 0, 1)),
                              headingTextStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color.fromRGBO(255, 255, 255, 1),
                              ),
                              columns: const [
                                DataColumn(
                                  label: Text('Participation Name'),
                                ),
                                DataColumn(
                                  label: Text('Year'),
                                ),
                                DataColumn(
                                  label: Text('Rank'),
                                ),
                              ],
                              rows: participationData
                                  .map(
                                    (record) => DataRow(
                                      cells: [
                                        DataCell(
                                          Text(record['participation_name']
                                              .toString()),
                                        ),
                                        DataCell(
                                          Text(record['year'].toString()),
                                        ),
                                        DataCell(
                                          Text(record['rank_position']
                                              .toString()),
                                        ),
                                      ],
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    AddParticipationPage(storage: storage),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  20.0), // Adjust the value for the desired level of circularity
                            ),
                            padding: EdgeInsets.all(
                                16.0), // Adjust the padding for the desired size
                            backgroundColor: Colors
                                .blue, // Adjust the background color as needed
                          ),
                          child: Text('Add Participation'),
                        ),
                      ],
                    );
                  } else {
                    return Text('No Participation Record for 3rd Year');
                  }
                },
              ),
              // color: Color.fromARGB(255, 1, 123, 252),
            ),

            // Design for 4th Year Tab

            Container(
              child: FutureBuilder(
                future: fetchParticipationData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (snapshot.hasData && snapshot.data != null) {
                    // List<Map<String, dynamic>> participationData =
                    //     snapshot.data!;
                    List<Map<String, dynamic>> participationData =
                        filterParticipationByYear(snapshot.data!, '4th year');

                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: DataTable(
                              border: TableBorder.all(
                                  color: Color.fromRGBO(0, 0, 0, 1)),
                              dataRowColor: MaterialStateProperty.all(
                                  Color.fromARGB(255, 255, 255, 255)),
                              headingRowColor: MaterialStateProperty.all(
                                  Color.fromRGBO(255, 102, 0, 1)),
                              headingTextStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color.fromRGBO(255, 255, 255, 1),
                              ),
                              columns: const [
                                DataColumn(
                                  label: Text('Participation Name'),
                                ),
                                DataColumn(
                                  label: Text('Year'),
                                ),
                                DataColumn(
                                  label: Text('Rank'),
                                ),
                              ],
                              rows: participationData
                                  .map(
                                    (record) => DataRow(
                                      cells: [
                                        DataCell(
                                          Text(record['participation_name']
                                              .toString()),
                                        ),
                                        DataCell(
                                          Text(record['year'].toString()),
                                        ),
                                        DataCell(
                                          Text(record['rank_position']
                                              .toString()),
                                        ),
                                      ],
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    AddParticipationPage(storage: storage),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  20.0), // Adjust the value for the desired level of circularity
                            ),
                            padding: EdgeInsets.all(
                                16.0), // Adjust the padding for the desired size
                            backgroundColor: Colors
                                .blue, // Adjust the background color as needed
                          ),
                          child: Text('Add Participation'),
                        ),
                      ],
                    );
                  } else {
                    return Text(
                      'No Participation Record for 4th Year',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                      ),
                    );
                  }
                },
              ),
              // color: Color.fromARGB(255, 255, 220, 20),
            ),
          ],
        ),
      ),
    );
  }
}
