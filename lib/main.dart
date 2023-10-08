import 'package:bottom_nav/Drawer/aboutus.dart';
import 'package:bottom_nav/Drawer/headerdrawer.dart';
import 'package:bottom_nav/Drawer/internrecord.dart';
import 'package:bottom_nav/Drawer/moneyreceipt.dart';
import 'package:bottom_nav/admin.dart';
import 'package:bottom_nav/home.dart';
import 'package:bottom_nav/medical.dart';
import 'package:bottom_nav/settings.dart';
import 'package:flutter/material.dart';
import 'package:custom_line_indicator_bottom_navbar/custom_line_indicator_bottom_navbar.dart';
import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:bottom_nav/co-curricular.dart';

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
  PageController _pageController = PageController();

  int _selectedIndex = 2; // default index

  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _selectedIndex);
  }

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

  bool isDarkModeEnabled = false;

  @override
  Widget build(BuildContext context) {
    // Define the background color based on the isDarkModeEnabled variable
    final backgroundColor = isDarkModeEnabled
        ? const Color.fromRGBO(52, 52, 52, 1)
        : Color.fromARGB(255, 255, 255, 255);

    return Scaffold(
      appBar: AppBar(
        title: Text('CST - SPIMS'),
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
        // leading: IconButton(
        //   icon: const Icon(Icons.menu_outlined),
        //   onPressed: () {},
        // ),
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
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                HeaderDrawer(),
                DrawerList(),
              ],
            ),
          ),
        ),
        // child: ListView(
        //   children: [
        //     ListTile(
        //       title: const Text('Co-curricular'),
        //       onTap: (){

        //       },
        //     ),
        //   ],
        // ),
      ),
      // Set the Scaffold's background color
      backgroundColor: backgroundColor,
      body: PageView(
        controller: _pageController,
        children: screens,
      ),

      // Center(
      //   child: screens.elementAt(_selectedIndex),
      // ),

      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        child: CustomLineIndicatorBottomNavbar(
          selectedColor: Color.fromRGBO(255, 255, 245, 1),
          unSelectedColor: Color.fromARGB(255, 255, 255, 255),
          backgroundColor: backgroundColor, // Use the same background color
          currentIndex: _selectedIndex,
          unselectedIconSize: 30,
          selectedIconSize: 35,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
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

  Widget DrawerList() {
    return Container(
      padding: EdgeInsets.only(top: 15),
      child: Column(
        children: [
          menuItem(5, "Intern Record", Icons.business_center_outlined),
          Divider(),
          menuItem(6, "Money Receipt", Icons.request_quote_outlined),
          Divider(),
          menuItem(7, "About", Icons.help_outline_outlined),
        ],
      ),
    );
  }

  Widget menuItem(int index, String title, IconData icon) {
    return Material(
      color: index == _selectedIndex ? Colors.grey[200] : Colors.transparent,
      child: InkWell(
        onTap: () {
          setState(() {
            _selectedIndex = index;
          });
          _pageController.jumpToPage(index);

          Navigator.of(context).pop();
        },
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: Icon(
                  icon,
                  size: 30,
                  color: Colors.blueAccent,
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
