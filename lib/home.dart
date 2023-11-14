import 'dart:convert';
import 'package:bottom_nav/EditPage/edit_basic.dart';
import 'package:bottom_nav/EditPage/edit_further_details.dart';
import 'package:bottom_nav/EditPage/edit_parents_detail.dart';
import 'package:bottom_nav/Fetchmodules/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Calling a get request to fetch the user data
  late final ApiService apiService;
  final storage = FlutterSecureStorage();

// Route to the basic edit page
  void _onBasicEdit(Map<String, dynamic>? userData) async {
    final updatedData = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            editBasicPage(userData: userData, storage: storage),
      ),
    );

    if (updatedData != null) {
      setState(() {
        userData = updatedData;
      });
    }
  }

  // Route to the parent edit page
  void _onParentsEdit(Map<String, dynamic>? userData) async {
    final updatedData = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            EditParentPage(userData: userData, storage: storage),
      ),
    );

    if (updatedData != null) {
      setState(() {
        userData = updatedData;
      });
    }
  }

  // Route to the further edit page
  void _onFurtherEdit(Map<String, dynamic>? userData) async {
    final updatedData = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            FurtherEditPage(userData: userData, storage: storage),
      ),
    );

    if (updatedData != null) {
      setState(() {
        userData = updatedData;
      });
    }
  }

  // Map to store the student data
  Future<Map<String, dynamic>> studentData() async {
    try {
      // All the student data will be stored in the student data
      Map<String, dynamic> userData = await apiService.getUserDetailsAPI();
      return userData;
    } catch (e) {
      print('Error while fetching from the api service');
      throw e;
    }
  }

  @override
  void initState() {
    super.initState();
    apiService = ApiService(storage);
    studentData();
  }

  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    //  final Map<String, dynamic> userData = widget.userData;

    return FutureBuilder(
      future: studentData(),
      builder: (context, snapshot) {
        print(snapshot.data);
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasData) {
          Map<String, dynamic>? userData = snapshot.data;
          return Scaffold(
            backgroundColor: Color.fromARGB(255, 232, 232, 232),
            body: SingleChildScrollView(
              child: Stack(
                children: [
                  //Background Blue
                  Positioned(
                    child: _buildBackground(),
                  ),

                  //Name Card
                  Positioned(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 100,
                      ),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: _nameCard(userData),
                      ),
                    ),
                  ),

                  // Image Card
                  Positioned(
                    top: 30,
                    left: 110,
                    child: _imagePhoto(userData),
                  ),

                  // Basic Detail Text
                  Positioned(
                    top: 350,
                    left: 30,
                    right: 0,
                    child: Text(
                      'Basic Details:',
                      style: TextStyle(
                        color: Color(0xFFFF6600),
                        fontSize: 22,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),

                  // Basic Details Card
                  Positioned(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 380,
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: _basicDetail(userData),
                      ),
                    ),
                  ),

                  // Parents Detail Text
                  Positioned(
                    top: 640,
                    left: 30,
                    right: 0,
                    child: Text(
                      'Parents Details:',
                      style: TextStyle(
                        color: Color(0xFFFF6600),
                        fontSize: 22,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),

                  // Parents detail card
                  Positioned(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 670,
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: _parentsDetail(userData),
                      ),
                    ),
                  ),

                  // Further Details Text
                  Positioned(
                    top: 870,
                    left: 30,
                    right: 0,
                    child: Text(
                      'Permanent Address:',
                      style: TextStyle(
                        color: Color(0xFFFF6600),
                        fontSize: 22,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),

                  //Further Details Card
                  Positioned(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 900,
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: _furtherDetail(userData),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return Text('No data Fetched');
        }
      },
    );
  }

// Background box
  Widget _buildBackground() {
    return Container(
      height: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(70),
          bottomLeft: Radius.circular(70),
        ),
        color: Color(0xFF72BBFF),
      ),
    );
  }

// Name for Card
  Widget _nameCard(Map<String, dynamic>? userData) {
    return Container(
      height: 230,
      width: 350,
      decoration: BoxDecoration(
        color: Color(0xfff0f7f7),
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 110,
          ),
          Text(
            '${userData?['name'] ?? ''}',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Text(
            '${userData?['student_id'] ?? ''}',
            // '',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
              color: Colors.black,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            '${userData?['department'] ?? ''}',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

// Circular avatar
  Widget _imagePhoto(Map<String, dynamic>? userData) {
    String imageUrl = userData?['image_url'];
    return imageUrl != null
        ? CircleAvatar(
            radius: 85,
            backgroundImage: NetworkImage(imageUrl),
          )
        : CircleAvatar(
            radius: 85,
          );
  }

// Basic Details Card
  Widget _basicDetail(Map<String, dynamic>? userData) {
    // To extract the date only
    String? dob = userData?['dob'];
    String formattedDate = '';

    if (dob != null && dob.isNotEmpty) {
      DateTime dobDateTime = DateTime.parse(dob);
      formattedDate =
          '${dobDateTime.day}/${dobDateTime.month}/${dobDateTime.year}';
    }
    return Container(
      height: 230,
      width: 350,
      decoration: BoxDecoration(
        color: Color(0xfff0f7f7),
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            left: 290,
            top: 5,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: GestureDetector(
                onDoubleTap: () => _onBasicEdit(
                    userData), //Calling onBasicEdit tab on double clicking
                child: SvgPicture.asset(
                  'Images/edit.svg',
                ),
              ),
            ),
          ),
          Column(
            children: [
              SizedBox(height: 10),
              Text(
                'DOB: $formattedDate',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Text(
                'Sex: ${userData?['sex'] ?? ''}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
              Text(
                'CID No: ${userData?['cid'] ?? ''}',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Contact No: ${userData?['contact_num'] ?? ''}',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Email: ${userData?['email'] ?? ''}',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Scholarship Type: ${userData?['scholarship_type'] ?? ''}',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Year: ${userData?['year'] ?? ''}',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Semester: ${userData?['sem'] ?? ''}',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

// Parents Details Card
  Widget _parentsDetail(Map<String, dynamic>? userData) {
    return Container(
      height: 170,
      width: 350,
      decoration: BoxDecoration(
        color: Color(0xfff0f7f7),
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            left: 290,
            top: 5,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: GestureDetector(
                onDoubleTap: () => _onParentsEdit(userData),
                child: SvgPicture.asset(
                  'Images/edit.svg',
                ),
              ),
            ),
          ),
          Column(
            children: [
              SizedBox(height: 15),
              Text(
                'Name: ${userData?['pname'] ?? ''}',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Text(
                'Relation: ${userData?['relation'] ?? ''}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
              Text(
                // 'Occupation: ${userData?['name'] ?? ''}',
                'Occupation',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'CID No: ${userData?['p_cid'] ?? ''}',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Contact No: ${userData?['pcontact_num'] ?? ''}',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Email: ${userData?['p_email'] ?? ''}',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

// Further Details Card
  Widget _furtherDetail(Map<String, dynamic>? userData) {
    return Container(
      height: 170,
      width: 350,
      decoration: BoxDecoration(
        color: Color(0xfff0f7f7),
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            left: 290,
            top: 5,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: GestureDetector(
                onDoubleTap: () => _onFurtherEdit(userData),
                child: SvgPicture.asset(
                  'Images/edit.svg',
                ),
              ),
            ),
          ),
          Column(
            children: [
              SizedBox(height: 15),
              Text(
                'Dzongkhag: ${userData?['dzongkhag'] ?? ''}',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Text(
                'Gewog:${userData?['gewog'] ?? ''} ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
              Text(
                'Village: ${userData?['village'] ?? ''} ',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'House No: ${userData?['house_no'] ?? ''} ',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Thram No: ${userData?['thram_no'] ?? ''} ',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Country: ${userData?['country'] ?? ''} ',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
