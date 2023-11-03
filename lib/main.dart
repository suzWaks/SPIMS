// Import necessary packages and files
import 'package:bottom_nav/AdminPanel/adminHome.dart';
import 'package:bottom_nav/Drawer/aboutus.dart';
import 'package:bottom_nav/Login/login.dart';
import 'package:flutter/material.dart';
import 'package:custom_line_indicator_bottom_navbar/custom_line_indicator_bottom_navbar.dart';
import 'package:day_night_switcher/day_night_switcher.dart';
// import 'package:bottom_nav/Drawer/aboutus.dart';
import 'package:bottom_nav/Drawer/headerdrawer.dart';
import 'package:bottom_nav/Drawer/internrecord.dart';
import 'package:bottom_nav/Drawer/moneyreceipt.dart';
import 'package:bottom_nav/academic.dart';
import 'package:bottom_nav/home.dart';
import 'package:bottom_nav/medical.dart';
import 'package:bottom_nav/settings.dart';
import 'package:bottom_nav/co-curricular.dart';
// import 'package:bottom_nav/AdminPanel/adminhome.dart';

// // Entry point of the Flutter application
// void main() {
//   runApp(const MainApp());
// }

// To run the Login app
void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Login(),
  ));
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
      home: const MyExample(),
    );
  }
}

// Define the main widget, MyExample, as a StatefulWidget
class MyExample extends StatefulWidget {
  const MyExample({super.key});

  @override
  _MyExampleState createState() => _MyExampleState();
}

// Define the state for MyExample
class _MyExampleState extends State<MyExample> {
  PageController _pageController =
      PageController(); //Initialize the page controller for drawer menu items
  int _selectedIndex =
      2; // Default selected index for the bottom navigation bar

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
        initialPage:
            _selectedIndex); // Initialize the page controller with the default index
  }

  // List of screens that can be navigated to
  final screens = [
    CoCurricularPage(),
    AcademicPage(),
    HomePage(),
    MedicalPage(),
    SettingsPage(),
    InternRecordPage(),
    MoneyReceiptPage(),
    AboutUsPage(),
    AdminHomePage(),
  ];

  bool isDarkModeEnabled = false; // State for enabling dark mode

  @override
  Widget build(BuildContext context) {
    // Determine the background color based on the dark mode state
    final backgroundColor = isDarkModeEnabled
        ? const Color.fromRGBO(52, 52, 52, 1)
        : const Color.fromARGB(255, 255, 255, 255);

 return Scaffold(
  appBar: AppBar(
    title: const Text('CST - SPIMS'),
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
    flexibleSpace: Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromRGBO(0, 40, 168, 1),
            Color.fromARGB(255, 0, 53, 229),
            Color.fromARGB(255, 0, 43, 183),
          ],
        ),
      ),
    ),
  ),
  drawer: Drawer(
    child: SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            HeaderDrawer(),
            DrawerList(),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      '3IT Copyrights reserved - 2023',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  ),
  backgroundColor: backgroundColor,
  body: PageView(
    controller: _pageController,
    children: screens,
    physics: NeverScrollableScrollPhysics(), // Add this line
  ),
  bottomNavigationBar: ClipRRect(
    borderRadius: const BorderRadius.only(
      topLeft: Radius.circular(20),
      topRight: Radius.circular(20),
    ),
    child: CustomLineIndicatorBottomNavbar(
      selectedColor: const Color.fromRGBO(255, 255, 245, 1),
      unSelectedColor: const Color.fromARGB(255, 255, 255, 255),
      backgroundColor: backgroundColor,
      currentIndex: _selectedIndex,
      unselectedIconSize: 30,
      selectedIconSize: 35,
      onTap: (index) {
        setState(() {
          _selectedIndex = index;
          _pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        });
      },
      enableLineIndicator: true,
      lineIndicatorWidth: 3,
      indicatorType: IndicatorType.Bottom,
      gradient: const LinearGradient(
        colors: [
          Color.fromRGBO(0, 40, 168, 1),
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

  // Define a method to create items in the app's drawer
  Widget DrawerList() {
    return Container(
      padding: const EdgeInsets.only(top: 15),
      child: Column(
        children: [
          menuItem(
              5,
              "Intern Record",
              Icons
                  .business_center_outlined), //Values passed as parameters to the menuItem method
          const Divider(),
          menuItem(6, "Money Receipt", Icons.request_quote_outlined),
          const Divider(),
          menuItem(7, "About", Icons.help_outline_outlined),
          Divider(),
          menuItem(9, "Admin Panel", Icons.admin_panel_settings_outlined),
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
          padding: const EdgeInsets.all(16),
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
                  style: const TextStyle(color: Colors.black, fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
