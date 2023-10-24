import 'package:bottom_nav/Lecturer/home.dart';
import 'package:bottom_nav/Lecturer/settings.dart';
import 'package:custom_line_indicator_bottom_navbar/custom_line_indicator_bottom_navbar.dart';
import 'package:flutter/material.dart';
import 'package:day_night_switcher/day_night_switcher.dart';

// Defining the main widget
class lecturer extends StatefulWidget {
  const lecturer({super.key});

  @override
  State<lecturer> createState() => _lecturerState();
}

// Defing the state
class _lecturerState extends State<lecturer> {
  // Initialized the page controller
  PageController _pageController = PageController();
  int selectIndex = 0;

  // Initailized the page controller with the default page
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: selectIndex);
  }

  // List of screens that can be navigated
  final screens = [
    Home(
      title: 'Title',
    ),
    Settings(),
  ];

  bool isDarkModeEnabled = false; //State of the dark mode

  @override
  Widget build(BuildContext context) {
    //Determine the background color based on the dark mode state
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
                }),
          )
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
      // Setting the background color for the scaffold
      backgroundColor: backgroundColor,
      body: PageView(
        controller:
            _pageController, // Display the selected screen from the drawer menu

        children:
            screens, // Display the selected screen from the bottom navigation bar
      ),

      // Bottom Navigation bar
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        child: CustomLineIndicatorBottomNavbar(
          // Configure the custom buttom navigation
          selectedColor: Color.fromRGBO(255, 255, 245, 1),
          unSelectedColor: Color.fromARGB(255, 255, 255, 255),
          backgroundColor: backgroundColor,
          currentIndex: selectIndex,
          unselectedIconSize: 30,
          selectedIconSize: 35,
          onTap: (index) {
            setState(() {
              selectIndex = index;
              _pageController.animateToPage(index,
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
          // Items in the nav bar
          customBottomBarItems: [
            CustomBottomBarItems(
              label: 'Home',
              icon: Icons.home_outlined,
            ),
            CustomBottomBarItems(
              label: 'Settings',
              icon: Icons.settings_outlined,
            )
          ],
        ),
      ),
    );
  }
}
