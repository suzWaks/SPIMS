import 'package:flutter/material.dart';

class InternRecordPage extends StatefulWidget {
      final bool isDarkModeEnabled;
    const InternRecordPage({Key? key,required this.isDarkModeEnabled}) : super(key: key);
  @override
  _InternRecordPageState createState() => _InternRecordPageState();
}

class _InternRecordPageState extends State<InternRecordPage> {
  @override
  Widget build(BuildContext context) {
         final bool isDarkModeEnabled = widget.isDarkModeEnabled;
    return Scaffold(
         backgroundColor: isDarkModeEnabled
      ? const Color.fromARGB(255, 86, 83, 83)
      : const Color.fromARGB(255, 255, 255, 255),
      body: Padding(
        padding: const EdgeInsets.all(20.0), // Adjust the padding as needed
        child: Column(
          mainAxisAlignment:MainAxisAlignment.start, // Align content at the top
          crossAxisAlignment:CrossAxisAlignment.center, // Center the content horizontally
          children: [
            const Text(
              'Intern Record',
              style: TextStyle(
                fontSize: 35.0, // Adjust the font size as needed
                color: Color.fromARGB( 255, 255, 102, 0), // Adjust the color as needed
                fontFamily: '', // Specify the desired font family
              ),
            ),
            const SizedBox(height: 20),
            CustomTab(isDarkModeEnabled: isDarkModeEnabled),
            const SizedBox(height: 16), // Add space between the tabs
            CustomTab2(isDarkModeEnabled: isDarkModeEnabled),// Add the CustomTab widget here
          ],
        ),
      ),
    );
  }
}

class CustomTab extends StatelessWidget {
  final bool isDarkModeEnabled;

  const CustomTab({Key? key, required this.isDarkModeEnabled}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    
    return Container(
      alignment: Alignment.topCenter,
      decoration: BoxDecoration(
        color: isDarkModeEnabled
            ? const Color.fromRGBO(52, 52, 52, 1)
            : const Color(0xFFF1F8F8),
        borderRadius: BorderRadius.circular(30.0),
        border: Border.all(
          color:
              Color.fromARGB(255, 255, 102, 0), // Set the color of the border
          width: 1.0,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 184, 184, 184).withOpacity(0.5),
            spreadRadius: 1.5,
            blurRadius: 5,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '    Druk Smart',
              style: TextStyle(
                fontSize: 30.0,
                color: Colors.black,
              ),
            ),
            const Text(
              '23/06/2023 - 10/07/2023',
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.grey,
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Color.fromARGB(255, 255, 102, 0),
                    width: 2.0,
                  ),
                ),
              ),
              padding:
                  const EdgeInsets.symmetric(vertical: 15.0, horizontal: 12.0),
              child: const Text(
                '   Specialising in ERP',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class CustomTab2 extends StatelessWidget {
   final bool isDarkModeEnabled;

  const CustomTab2({Key? key, required this.isDarkModeEnabled}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      decoration: BoxDecoration(
          color: isDarkModeEnabled
            ? const Color.fromRGBO(52, 52, 52, 1)
            : const Color(0xFFF1F8F8),
        borderRadius: BorderRadius.circular(30.0),
        border: Border.all(
          color:
              Color.fromARGB(255, 255, 102, 0), // Set the color of the border
          width: 1.0,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 184, 184, 184).withOpacity(0.5),
            spreadRadius: 1.5,
            blurRadius: 5,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '           DHI',
              style: TextStyle(
                fontSize: 30.0,
                color: Colors.black,
              ),
            ),
            const Text(
              '23/06/2023 - 10/07/2023',
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.grey,
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Color.fromARGB(255, 255, 102, 0),
                    width: 2.0,
                  ),
                ),
              ),
              padding:
                  const EdgeInsets.symmetric(vertical: 15.0, horizontal: 12.0),
              child: const Text(
                '   Specialising in ERP',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

