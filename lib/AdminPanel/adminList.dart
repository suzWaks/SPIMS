import 'package:bottom_nav/AdminPanel/adminUpload.dart';
import 'package:bottom_nav/AdminPanel/adminhome.dart';
import 'package:flutter/material.dart';
import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:custom_line_indicator_bottom_navbar/custom_line_indicator_bottom_navbar.dart';
import 'package:clickable_list_wheel_view/clickable_list_wheel_widget.dart';

class AdminListPage extends StatefulWidget {
  @override
  _AdminListPageState createState() => _AdminListPageState();
}

final _scrollController = FixedExtentScrollController();

const double _itemHeight = 90;
const int _itemCount = 9;

List<String> titles = [
  'B.E. Information Technology',
  'B.E. Electrical Engineering',
  'B.E. Engineering Geology',
  'B.E. Civil Engineering',
  'B.E. Instrumenation and Control Engineering',
  'B.E. Electronics and Communication Engineering',
  'B.E. Mechanical Engineering',
  'B.E. Water Resource Engineering',
  'Bachelor of Architecture',
];

class _AdminListPageState extends State<AdminListPage> {
  int _selectedIndex = 1;
  bool isDarkModeEnabled = false;
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
              colors: [
                const Color.fromRGBO(0, 40, 168, 1),
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
            colors: [
              const Color.fromRGBO(0, 40, 168, 1),
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
      body: Column(
        children: <Widget>[
          // Add a title at the top of the page
          Container(
            padding: EdgeInsets.only(top: 20),
            child: Text(
              'Department List',
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
                color: Colors.black, // Change the color as needed
              ),
            ),
          ),
          Expanded(
            child: ClickableListWheelScrollView(
              //List of departments
              scrollController: _scrollController,
              onItemTapCallback: (index) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          AdminUploadPage()), // Navigate to the AdminUploadPage
                );
              },
              itemHeight: _itemHeight,
              itemCount: titles.length,
              child: ListWheelScrollView.useDelegate(
                controller: _scrollController,
                itemExtent: _itemHeight,
                physics: FixedExtentScrollPhysics(),
                overAndUnderCenterOpacity: 0.4,
                perspective: 0.007,
                childDelegate: ListWheelChildBuilderDelegate(
                  builder: (context, index) =>
                      _child(titles[index]), // Use titles[index] as the title
                  childCount:
                      titles.length, // Use titles.length as the childCount
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _child(String title) {
    return SizedBox(
      height: _itemHeight,
      child: Card(
        child: Center(
          child: Text(
            title,
            textAlign: TextAlign.center, // Center-align the text horizontally
            style: TextStyle(
                color: const Color.fromRGBO(255, 102, 0, 1),
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
