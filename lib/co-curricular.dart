import 'package:flutter/material.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:carousel_slider/carousel_slider.dart';

final List<String> imgList = [
  'Images/Screenshot 2023-07-16 204536.png',
  'Images/Screenshot 2023-07-18 220546.png',
  'Images/Screenshot 2023-07-24 203058.png',
  'Images/Screenshot 2023-07-24 203117.png',
  'Images/Screenshot 2023-08-02 173401.png',
  'Images/Screenshot 2023-08-02 201455.png',
];

class CoCurricularPage extends StatelessWidget {
  final CarouselController _carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color.fromARGB(255, 255, 255, 255), // White background or the tab
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
            // Design for 1st Year Tab
            Container(
              child: Center(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
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
                            label: Text('Sl.No'),
                          ),
                          DataColumn(
                            label: Text('Name'),
                          ),
                          DataColumn(
                            label: Text('Student Number'),
                          ),
                        ],
                        rows: const [
                          DataRow(
                            cells: [
                              DataCell(
                                Text('1'),
                              ),
                              DataCell(
                                Text('John Doe'),
                              ),
                              DataCell(
                                Text('12345'),
                              ),
                            ],
                          ),
                          DataRow(
                            cells: [
                              DataCell(
                                Text('2'),
                              ),
                              DataCell(
                                Text('Jane Smith'),
                              ),
                              DataCell(
                                Text('67890'),
                              ),
                            ],
                          ),
                          // Add more DataRow widgets as needed
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
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
                            label: Text('Sl.No'),
                          ),
                          DataColumn(
                            label: Text('Name'),
                          ),
                          DataColumn(
                            label: Text('Student Number'),
                          ),
                        ],
                        rows: const [
                          DataRow(
                            cells: [
                              DataCell(
                                Text('1'),
                              ),
                              DataCell(
                                Text('John Doe'),
                              ),
                              DataCell(
                                Text('12345'),
                              ),
                            ],
                          ),
                          DataRow(
                            cells: [
                              DataCell(
                                Text('2'),
                              ),
                              DataCell(
                                Text('Jane Smith'),
                              ),
                              DataCell(
                                Text('67890'),
                              ),
                            ],
                          ),
                          // Add more DataRow widgets as needed
                        ],
                      ),
                    ),
                    CarouselSlider(
                      carouselController:
                          _carouselController, // Pass the controller here
                      options: CarouselOptions(
                        enableInfiniteScroll: false,
                        enlargeCenterPage: true,
                        enlargeFactor: 0.5,
                        viewportFraction: 0.8,
                        initialPage: 0,
                      ),
                      items: imgList
                          .map((item) => Container(
                                child: Center(
                                    child: Image.asset(item,
                                        fit: BoxFit.cover, width: 1000)),
                              ))
                          .toList(),
                    ),
                  ],
                ),
              ),
            ),

            // Design for 2nd Year Tab
            Container(
              color: Colors.green,
              child: Center(
                child: Text(
                  'Content for 2nd Year',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
            // Design for 3rd Year Tab
            Container(
              color: Color.fromARGB(255, 1, 123, 252),
              child: Center(
                child: Text(
                  'Content for 3rd Year',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
            // Design for 4th Year Tab
            Container(
              color: Color.fromARGB(255, 255, 220, 20),
              child: Center(
                child: Text(
                  'Content for 4th Year',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
          ],
          onChange: (index) => print(index),
        ),
      ),
    );
  }
}
