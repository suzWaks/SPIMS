import 'package:flutter/material.dart';
import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:custom_line_indicator_bottom_navbar/custom_line_indicator_bottom_navbar.dart';

class AdminUploadPage extends StatefulWidget {
  @override
  _AdminUploadPage createState() => _AdminUploadPage();
}

class _AdminUploadPage extends State<AdminUploadPage> {
  bool isDarkModeEnabled = false;
  int _selectedIndex = 1;
  @override
  Widget build(BuildContext context) {
    final backgroundColor = isDarkModeEnabled
        ? const Color.fromRGBO(52, 52, 52, 1)
        : Color.fromARGB(255, 255, 255, 255);
    return Scaffold(
      appBar: AppBar(
        title: Text('CST - SPIMS Admin Panel'),
        actions: <Widget>[
          // Widget to toggle between light and dark mode
          Transform.scale(
            scale: 0.7, // Adjust the scale factor for the toggle size
            child: DayNightSwitcher(
              isDarkModeEnabled: isDarkModeEnabled,
              onStateChanged: (isDarkModeEnabled) {
                setState(() {
                  this.isDarkModeEnabled = isDarkModeEnabled;
                });
              },
            ),
          ),
        ],
        // Configure the app bar with a flexible space and gradient background
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: const [
                Color.fromRGBO(0, 40, 168, 1),
                Color.fromARGB(255, 0, 53, 229),
                Color.fromARGB(255, 0, 43, 183),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: backgroundColor,
      bottomNavigationBar: ClipRRect(
        // Create a custom bottom navigation bar with line indicator
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        child: CustomLineIndicatorBottomNavbar(
          // Configure the custom bottom navigation bar
          selectedColor: Color.fromRGBO(255, 255, 245, 1),
          unSelectedColor: Color.fromARGB(255, 255, 255, 255),
          backgroundColor: backgroundColor,
          currentIndex: _selectedIndex,
          unselectedIconSize: 30,
          selectedIconSize: 35,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          enableLineIndicator: true,
          lineIndicatorWidth: 3,
          indicatorType: IndicatorType.Bottom,
          gradient: LinearGradient(
            colors: const [
              Color.fromRGBO(0, 40, 168, 1),
              Color.fromARGB(255, 0, 53, 229),
              Color.fromARGB(255, 0, 43, 183),
            ],
          ),
          customBottomBarItems: [
            //Bottom Navigation Items
            CustomBottomBarItems(
              label: 'Search',
              icon: Icons.search_outlined,
            ),
            CustomBottomBarItems(
              label: 'Home',
              icon: Icons.home_outlined,
            ),
            CustomBottomBarItems(
              label: 'Settings',
              icon: Icons.settings_outlined,
            ),
          ],
        ),
      ),
      body: Center(
        child: SingleChildScrollView(

          child: Padding(
            
            padding: const EdgeInsets.all(10),
            child: DataTable(
              border: backgroundColor == Colors.white
                  ? TableBorder.all(color: Colors.black)
                  : TableBorder.all(color: Color.fromRGBO(0, 0, 0, 1)),
              dataRowColor: backgroundColor == Colors.white
                  ? MaterialStateProperty.all(Color.fromARGB(255, 255, 255, 255))
                  : MaterialStateProperty.all(Color.fromARGB(255, 226, 220, 220)),
              headingRowColor: backgroundColor == Colors.white ? MaterialStateProperty.all(Color.fromRGBO(255, 102, 0, 1)) : MaterialStateProperty.all(Color.fromRGBO(234, 94, 0, 1)),
              headingTextStyle: TextStyle(
                fontWeight: FontWeight.bold,
                color: backgroundColor == Colors.white ? Color.fromRGBO(255, 255, 255, 1) : Color.fromRGBO(255, 255, 255, 1),
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
                // Add more DataRow widgets as needed
              ],
            ),
          ),
        ),
      ),
    );
  }
}
