// Import necessary packages and files
import 'package:flutter/material.dart';
import 'package:custom_line_indicator_bottom_navbar/custom_line_indicator_bottom_navbar.dart';
import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:bottom_nav/Drawer/aboutus.dart';
import 'package:bottom_nav/Drawer/headerdrawer.dart';
import 'package:bottom_nav/Drawer/internrecord.dart';
import 'package:bottom_nav/Drawer/moneyreceipt.dart';
import 'package:bottom_nav/admin.dart';
import 'package:bottom_nav/home.dart';
import 'package:bottom_nav/medical.dart';
import 'package:bottom_nav/settings.dart';
import 'package:bottom_nav/co-curricular.dart';

// Entry point of the Flutter application
void main() {
  runApp(const MainApp());
}

// Define the main Flutter application
class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, //Disable the debug banner
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyExample(),
    );
  }
}

// Define the main widget, MyExample, as a StatefulWidget
class MyExample extends StatefulWidget {
  @override
  _MyExampleState createState() => _MyExampleState();
}

// Define the state for MyExample
class _MyExampleState extends State<MyExample> {
  PageController _pageController =
      PageController(); //Initialize the page controller for drawer menu items
  int _selectedIndex =
      2; // Default selected index for the bottom navigation bar

  void initState() {
    super.initState();
    _pageController = PageController(
        initialPage:
            _selectedIndex); // Initialize the page controller with the default index
  }

  // List of screens that can be navigated to
  final screens = [
    CoCurricularPage(),
    AdminPage(),
    HomePage(),
    MedicalPage(),
    SettingsPage(),
    InternRecordPage(),
    MoneyReceiptPage(),
    AboutUsPage(),
  ];

  bool isDarkModeEnabled = false; // State for enabling dark mode

  @override
  Widget build(BuildContext context) {
    // Determine the background color based on the dark mode state
    final backgroundColor = isDarkModeEnabled
        ? const Color.fromRGBO(52, 52, 52, 1)
        : Color.fromARGB(255, 255, 255, 255);

    return Scaffold(
      appBar: AppBar(
        title: Text('CST - SPIMS'),
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
      drawer: Drawer(
        // Define the app's drawer
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                HeaderDrawer(), // Display the header of the drawer, defined in headerdrawer.dart
                DrawerList(), // Display the list of menu items in the drawer
              ],
            ),
          ),
        ),
      ),
      backgroundColor: backgroundColor, // Set the scaffold's background color
      body: PageView(
        controller:
            _pageController, // Display the selected screen from the drawer menu
        children:
            screens, // Display the selected screen from the bottom navigation bar OR drawer menu
      ),
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
              _pageController.animateToPage(
                  index, //Navigator for drawer menu items
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut);
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

  // Define a method to create items in the app's drawer
  Widget DrawerList() {
    return Container(
      padding: EdgeInsets.only(top: 15),
      child: Column(
        children: [
          menuItem(
              5,
              "Intern Record",
              Icons
                  .business_center_outlined), //Values passed as parameters to the menuItem method
          Divider(),
          menuItem(6, "Money Receipt", Icons.request_quote_outlined),
          Divider(),
          menuItem(7, "About", Icons.help_outline_outlined),
        ],
      ),
    );
  }

  // Define a method to create individual drawer menu items
  Widget menuItem(int index, String title, IconData icon) {
    //Parameters passed from the DrawerList method to create individual menu items
    return Material(
      color: index == _selectedIndex
          ? Colors.grey[200]
          : Colors.transparent, // Highlight the selected menu item
      child: InkWell(
        onTap: () {
          setState(() {
            _selectedIndex = index;
          });
          _pageController.jumpToPage(
              index); //jumps to the page of the selected menu item defined in the screens list

          Navigator.of(context)
              .pop(); //To close the drawer after selecting the menu item
        },
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            //Display the icon and title of the menu item in a single row
            children: [
              Expanded(
                child: Icon(
                  icon,
                  size: 30,
                  color: const Color.fromRGBO(0, 43, 185, 1),
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  title,
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
