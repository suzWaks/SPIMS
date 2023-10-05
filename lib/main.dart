import 'package:flutter/material.dart';
import 'package:custom_line_indicator_bottom_navbar/custom_line_indicator_bottom_navbar.dart';
import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:awesome_drawer_bar/awesome_drawer_bar.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyExample(),
    );
  }
}

class MyExample extends StatefulWidget {
  @override
  _MyExampleState createState() => _MyExampleState();
}

class _MyExampleState extends State<MyExample> {
  int _selectedIndex = 0; // default index

  List<Widget> _widgetOptions = [
    Text('Co-curricular'),
    Text('Academic'),
    Text('Home'),
    Text('Medical'),
    Text('Settings'),
  ];

  bool isDarkModeEnabled = false;

  @override
  Widget build(BuildContext context) {
    // Define the background color based on the isDarkModeEnabled variable
    final backgroundColor = isDarkModeEnabled
        ? const Color.fromRGBO(52, 52, 52, 1)
        : Color.fromARGB(255, 255, 255, 255);

    return Scaffold(
      appBar: AppBar(
        title: Text('Example'),
        actions: <Widget>[
          Transform.scale(
            scale: 0.7, // Adjust the scale factor as needed
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
        leading: IconButton(
          icon: const Icon(Icons.menu_outlined),
          onPressed: () {},
        ),
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
      // Set the Scaffold's background color
      backgroundColor: backgroundColor,
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        child: CustomLineIndicatorBottomNavbar(
          selectedColor: Color.fromRGBO(255, 255, 255, 1),
          unSelectedColor: Color.fromARGB(255, 255, 255, 255),
          backgroundColor: backgroundColor, // Use the same background color
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
            CustomBottomBarItems(
              label: 'Co-curricular',
              icon: Icons.rocket_launch_outlined,
            ),
            CustomBottomBarItems(
              label: 'Academic',
              icon: Icons.school_outlined,
            ),
            CustomBottomBarItems(
              label: 'Home',
              icon: Icons.home_outlined,
            ),
            CustomBottomBarItems(
              label: 'Medical',
              icon: Icons.local_hospital_outlined,
            ),
            CustomBottomBarItems(
              label: 'Settings',
              icon: Icons.settings_outlined,
            ),
          ],
        ),
      ),
    );
  }
}
