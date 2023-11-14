import 'dart:convert';
import 'dart:io';
import 'package:bottom_nav/EditPage/edit_medical.dart';
import 'package:bottom_nav/Fetchmodules/api_service.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class MedicalPage extends StatefulWidget {
  const MedicalPage({Key? key}) : super(key: key);

  @override
  _MedicalPageState createState() => _MedicalPageState();
}

class _MedicalPageState extends State<MedicalPage> {
  final TextEditingController _allergiesController = TextEditingController();
  final TextEditingController _medicationController = TextEditingController();
  final TextEditingController _seizuresController = TextEditingController();
  final CarouselController _carouselController = CarouselController();
  int currentPage = 0;
  bool isEditing = false;

  // Calling a get request to fetch the user data
  late final ApiService apiService;
  final storage = FlutterSecureStorage();

  // Function to fetch the medical images for a particular student
  Future<List<String>> fetchMedicalImages() async {
    // Fetching studentId from Flutter Secure Storage
    String? studentId = await storage.read(key: 'std_id');

    if (studentId == null) {
      throw Exception('Student ID not found in Flutter Secure Storage');
    }

    final response =
        await http.get(Uri.parse('http://172.20.10.2:8888/users/0$studentId'));

    print(response.body);
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);

      // Extracting imagesMedical from the response
      List<String> MedicalFiles = [];
      for (var item in data) {
        String medical_Url = item['imagesMedical'];
        File imageFile = File(
            medical_Url); //convert the image paths obtained from the server into File objects.
        MedicalFiles.add(medical_Url);
        print('MedicalFiles: $MedicalFiles');
      }
      return MedicalFiles;
    } else {
      throw Exception('Failed to load medical images');
    }
  }

  String _formatDateOfBirth(String? dob) {
    if (dob != null && dob.isNotEmpty) {
      final DateTime dateTime = DateTime.parse(dob);
      final String formattedDate =
          DateFormat('dd/MM/yyyy').format(dateTime.toLocal());
      return formattedDate;
    }
    return '';
  }

  Widget _buildUserAvatar(Map<String, dynamic>? userData) {
    String imageUrl = userData?['image_url'];
    return imageUrl != null
        ? CircleAvatar(
            radius: 100,
            backgroundImage: NetworkImage(imageUrl),
          )
        : CircleAvatar(
            radius: 100,
          );
  }

  // Route to the basic edit page
  void _onMedicalEdit(Map<String, dynamic>? userData) async {
    final updatedData = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            EditMedicalPage(userData: userData, storage: storage),
      ),
    );

    if (updatedData != null) {
      setState(() {
        userData = updatedData;
      });
    }
  }

  @override
  void dispose() {
    _allergiesController.dispose();
    _medicationController.dispose();
    _seizuresController.dispose();
    super.dispose();
  }

  // Map to store the medical data
  Future<Map<String, dynamic>> fetchMedical() async {
    try {
      Map<String, dynamic> userData = await apiService.getUserDetailsAPI();
      return userData;
    } catch (e) {
      print('Error while fetching data from the api service: $e');
      throw e;
    }
  }

  @override
  void initState() {
    super.initState();
    apiService = ApiService(storage);
    fetchMedical();
    fetchMedicalImages();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchMedical(), // Use fetchMedical as the future
      builder: (context, snapshot) {
        print(snapshot.data);
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasData) {
          Map<String, dynamic>? userData = snapshot.data;
          String imageUrl = userData?['image_url'];

          // Fetch medical image for the student
          return FutureBuilder(
              future: fetchMedicalImages(),
              builder: (context, imageSnapshot) {
                if (imageSnapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (imageSnapshot.hasData) {
                  // List<File>? MedicalFiles = imageSnapshot.data;
                  List<String>? medicalFilePaths = imageSnapshot.data;
                  List<File> MedicalFiles =
                      medicalFilePaths!.map((path) => File(path)).toList();

                  return Scaffold(
                    body: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20),
                          Stack(
                            children: [
                              // Images
                              Align(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: _buildUserAvatar(userData),
                                ),
                              ),

                              // Basic Details
                              Positioned(
                                top: 20,
                                right: 10,
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  color:
                                      const Color.fromARGB(255, 255, 255, 255),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${userData?['name'] ?? ''}',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        'Blood Group: ${userData?['blood_group'] ?? ''}',
                                        style: TextStyle(
                                          fontSize: 20,
                                        ),
                                      ),
                                      Text(
                                        'DOB: ${_formatDateOfBirth(userData?['dob'] ?? '')}',
                                        style: TextStyle(
                                          fontSize: 20,
                                        ),
                                      ),
                                      Text(
                                        'Age: ${userData?['age'] ?? ''}',
                                        style: TextStyle(
                                          fontSize: 20,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 0),

                          // Emergency Contact Number
                          Align(
                            alignment: Alignment.centerRight,
                            child: ElevatedButton(
                              onPressed: () =>
                                  _showEmergencyContactInfo(userData),
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(255, 255, 102, 0),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                              ),
                              child: const Text(
                                'Emergency Contact Info',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),

                          //Diagnosis
                          Container(
                            width: MediaQuery.of(context).size.width - 40,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 212, 226, 238),
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        'Diagnosis: ${userData?['diagnosis'] ?? ''}',
                                        style: TextStyle(
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onDoubleTap: () =>
                                          _onMedicalEdit(userData),
                                      child:
                                          SvgPicture.asset('Images/edit.svg'),
                                    )
                                  ],
                                ),

                                // Description
                                const Text(
                                  'Description',
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Container(
                                  padding: const EdgeInsets.all(5),
                                  color:
                                      const Color.fromARGB(255, 255, 255, 255),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${userData?['description'] ?? ''}',
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),

                          //Add Prescription button
                          ElevatedButton.icon(
                            onPressed: _showAddPrescriptionDialog,
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 0, 40, 168),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              padding: const EdgeInsets.all(16.0),
                              fixedSize: const Size(300.0, 60.0),
                            ),
                            icon: const Icon(Icons.photo_outlined,
                                color: Colors.white),
                            label: const Text(
                              'Add Prescription',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),

                          //Image Carousal
                          // Container(
                          //   height: 300,
                          //   child: Stack(
                          //     children: [
                          //       CarouselSlider(
                          //         carouselController: _carouselController,
                          //         options: CarouselOptions(
                          //           enableInfiniteScroll: false,
                          //           enlargeCenterPage: true,
                          //           viewportFraction: 0.8,
                          //           initialPage: 0,
                          //           onPageChanged: (index, reason) {
                          //             setState(() {
                          //               currentPage = index;
                          //             });
                          //           },
                          //         ),
                          //         items: [
                          //           for (int i = 0;
                          //               i < MedicalFiles.length;
                          //               i++)
                          //             // for (File imageFile in MedicalFiles)
                          //             Container(
                          //               width: 200,
                          //               margin: const EdgeInsets.symmetric(
                          //                   horizontal: 8),
                          //               decoration: BoxDecoration(
                          //                 borderRadius:
                          //                     BorderRadius.circular(15),
                          //               ),
                          //               child: Image.file(
                          //                 MedicalFiles[i],
                          //                 fit: BoxFit.cover,
                          //               ),
                          //             ),
                          //           // Container(
                          //           //   width: 200,
                          //           //   margin: const EdgeInsets.symmetric(
                          //           //       horizontal: 8),
                          //           //   decoration: BoxDecoration(
                          //           //     borderRadius: BorderRadius.circular(15),
                          //           //     image: const DecorationImage(
                          //           //       image: AssetImage("Images/pres2.png"),
                          //           //       fit: BoxFit.cover,
                          //           //     ),
                          //           //   ),
                          //           // ),
                          //         ],
                          //       ),
                          //       Positioned(
                          //         left: 10,
                          //         top: 120,
                          //         child: IconButton(
                          //           icon: Icon(Icons.arrow_back_outlined),
                          //           color:
                          //               const Color.fromARGB(255, 255, 102, 0),
                          //           onPressed: () {
                          //             _carouselController.previousPage();
                          //           },
                          //         ),
                          //       ),
                          //       Positioned(
                          //         right: 10,
                          //         top: 120,
                          //         child: IconButton(
                          //           icon: Icon(Icons.arrow_forward_outlined),
                          //           color:
                          //               const Color.fromARGB(255, 255, 102, 0),
                          //           onPressed: () {
                          //             _carouselController.nextPage();
                          //           },
                          //         ),
                          //       ),
                          //       Positioned(
                          //         // bottom: 0,
                          //         bottom: 10,
                          //         left: 0,
                          //         right: 0,
                          //         child: Row(
                          //           mainAxisAlignment: MainAxisAlignment.center,
                          //           children: [
                          //             for (int i = 0;
                          //                 i < MedicalFiles.length;
                          //                 i++)
                          //               Container(
                          //                 width: 10,
                          //                 height: 10,
                          //                 margin: EdgeInsets.symmetric(
                          //                     horizontal: 2),
                          //                 decoration: BoxDecoration(
                          //                   shape: BoxShape.circle,
                          //                   color: i == currentPage
                          //                       ? Color.fromARGB(
                          //                           255, 255, 102, 0)
                          //                       : Colors.grey,
                          //                 ),
                          //               ),
                          //           ],
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  );
                } else {
                  return Text('No Medicall Images Fetched');
                }
              });
        } else {
          return Text('No data Fetched');
        }
      },
    );
  }

  void _showEmergencyContactInfo(Map<String, dynamic>? userData) {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Container(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Name: ${userData?['pname'] ?? ''}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    'Relation: ${userData?['relation'] ?? ''}',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    'Contact Number: ${userData?['pcontact_num'] ?? ''}',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  void _showAddPrescriptionDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            padding: EdgeInsets.all(16),
            height: 200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.close),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Text('Choose an option:'),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    // Handle adding prescription from gallery
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    primary: const Color.fromARGB(
                        255, 0, 40, 168), // Set your desired color
                  ),
                  child: Text('Choose from Gallery'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Handle adding prescription from file
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    primary: const Color.fromARGB(
                        255, 0, 40, 168), // Set your desired color
                  ),
                  child: Text('Choose File'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
