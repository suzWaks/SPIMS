// import 'package:flutter/material.dart';

// class AcademicPage extends StatefulWidget {
//   const AcademicPage({Key? key}) : super(key: key);

//   @override
//   _AdminPageState createState() => _AdminPageState();
// }

// class _AdminPageState extends State<AcademicPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Padding(
//           padding:
//               const EdgeInsets.only(top: 0.0), // Adjust top padding as needed
//           child: Column(
//             children: <Widget>[
//               const SizedBox(height: 20), // Add spacing below the text

//               Row(
//                 mainAxisAlignment:
//                     MainAxisAlignment.spaceBetween, // Adjust spacing as needed
//                 children: <Widget>[
//                   ElevatedButton(
//                     onPressed: () {
//                       // Handle left arrow button press
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.white, // Background color
//                       shape: const CircleBorder(), // Make it circular
//                       side: const BorderSide(
//                           color: Colors.orange), // Border color
//                     ),
//                     child: const Icon(
//                       Icons.arrow_back,
//                       color: Colors.orange,
//                       size: 28,
//                     ),
//                   ),
//                   const Text(
//                     'First Year',
//                     style: TextStyle(
//                       color: Colors.orange, // Text color
//                       fontFamily: 'Roboto',
//                       fontSize: 28,
//                       fontWeight: FontWeight.w400,
//                       fontStyle: FontStyle.normal,
//                       letterSpacing: 0.16, // Adjust as needed
//                       height: 0.57143, // Adjust as needed
//                     ),
//                   ),
//                   ElevatedButton(
//                     onPressed: () {
//                       // Handle right arrow button press
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.white, // Background color
//                       shape: const CircleBorder(), // Make it circular
//                       side: const BorderSide(
//                           color: Colors.orange), // Border color
//                     ),
//                     child: const Icon(
//                       Icons.arrow_forward,
//                       color: Colors.orange,
//                       size: 28,
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 20), // Add spacing below the buttons

//               const SizedBox(height: 20), // Add spacing below the divider
//               const Text(
//                 'Mid Term', // Text for the first container
//                 style: TextStyle(
//                   color: Colors.grey,
//                   fontFamily: 'Roboto',
//                   fontSize: 18,
//                 ),
//               ),
//               const SizedBox(height: 2),

//               // Containers with "Add" buttons
//               Container(
//                 width: 244, // Fixed width
//                 height: 180, // Fixed height
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(10),
//                   color: Colors.white, // Background color
//                   boxShadow: const [
//                     BoxShadow(
//                       color: Color.fromRGBO(0, 0, 0, 0.25),
//                       offset: Offset(0, 4),
//                       blurRadius: 4,
//                     ),
//                   ],
//                 ),
//                 child: const Center(
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: <Widget>[
//                       Icon(
//                         Icons.add,
//                         color: Colors.orange,
//                         size: 24,
//                       ),
//                       SizedBox(
//                           width:
//                               8), // Add spacing between the "+" sign and "Add" text
//                       Text(
//                         'Add',
//                         style: TextStyle(
//                           color: Colors.orange,
//                           fontSize: 18,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 20), // Add spacing between containers
//               const Divider(
//                 color: Color.fromRGBO(201, 201, 201, 1.0), // Divider color
//                 thickness: 2, // Divider thickness
//                 height: 0, // Default height
//                 indent: 20, // Left indent
//                 endIndent: 20, // Right indent
//               ),
//               const SizedBox(height: 20), // Add spacing between containers

//               // Text above the second container
//               const Text(
//                 'Semester End',
//                 style: TextStyle(
//                   color: Colors.grey,
//                   fontFamily: 'Roboto',
//                   fontSize: 18,
//                 ),
//               ),
//               const SizedBox(height: 2),

//               // Second container
//               Container(
//                 width: 244, // Fixed width
//                 height: 180, // Fixed height
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(10),
//                   color: Colors.white, // Background color
//                   boxShadow: const [
//                     BoxShadow(
//                       color: Color.fromRGBO(0, 0, 0, 0.25),
//                       offset: Offset(0, 4),
//                       blurRadius: 4,
//                     ),
//                   ],
//                 ),
//                 child: const Center(
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: <Widget>[
//                       Icon(
//                         Icons.add,
//                         color: Colors.orange,
//                         size: 24,
//                       ),
//                       SizedBox(
//                           width:
//                               8), // Add spacing between the "+" sign and "Add" text
//                       Text(
//                         'Add',
//                         style: TextStyle(
//                           color: Colors.orange,
//                           fontSize: 18,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               const SizedBox(
//                   height:
//                       20), // Add spacing between the buttons and the next row

//               // Row of buttons with arrows below the page
//               Row(
//                 mainAxisAlignment:
//                     MainAxisAlignment.spaceBetween, // Adjust spacing as needed
//                 children: <Widget>[
//                   ElevatedButton(
//                     onPressed: () {
//                       // Handle left arrow button press
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.white, // Background color
//                       shape: const CircleBorder(), // Make it circular
//                       side: const BorderSide(
//                           color: Colors.orange), // Border color
//                     ),
//                     child: const Icon(
//                       Icons.arrow_back,
//                       color: Colors.orange,
//                       size: 28,
//                     ),
//                   ),
//                   ElevatedButton(
//                     onPressed: () {
//                       // Handle right arrow button press
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.white, // Background color
//                       shape: const CircleBorder(), // Make it circular
//                       side: const BorderSide(
//                           color: Colors.orange), // Border color
//                     ),
//                     child: const Icon(
//                       Icons.arrow_forward,
//                       color: Colors.orange,
//                       size: 28,
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// void main() {
//   runApp(const MaterialApp(
//     home: AcademicPage(),
//   ));
// }
