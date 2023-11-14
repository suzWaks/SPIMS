import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class FurtherEditPage extends StatefulWidget {
  final Map<String, dynamic>?
      userData; // Add a property to receive the user data
  final FlutterSecureStorage storage;

  // const editBasicPage({Key? key, this.userData}) : super(key: key);
  FurtherEditPage({required this.userData, required this.storage});

  @override
  State<FurtherEditPage> createState() => _FurtherEditPageState();
}

class _FurtherEditPageState extends State<FurtherEditPage> {
  // Create a Map to store the updated data
  Map<String, dynamic> updatedData = {};

  late String? updatedDzongkhag;
  late String? updatedGewog;
  late String? updatedVillage;
  late String? updatedhouseNo;
  late String? updatedThramNo;
  late String? updatedCountry;

  late TextEditingController _gewogController;
  late TextEditingController _villageController;
  late TextEditingController _houseNoController;
  late TextEditingController _thramNoController;
  late TextEditingController _countryController;

  // Default values
  late String defaultDzongkhag;
  late String defaultGewog;
  late String defaultVillage;
  late String defaulthouseNo;
  late String defaultThramNo;
  late String defaultCountry;

  @override
  void initState() {
    super.initState();

    // Initialize the controllers with the initial values
    _gewogController = TextEditingController(text: widget.userData?['gewog']);
    _villageController =
        TextEditingController(text: widget.userData?['village']);
    _houseNoController =
        TextEditingController(text: widget.userData?['house_no']);
    _thramNoController =
        TextEditingController(text: widget.userData?['thram_no']);
    _countryController =
        TextEditingController(text: widget.userData?['country']);

    // Set the initial value
    updatedDzongkhag = widget.userData?['dzongkhag'];
    updatedGewog = widget.userData?['gewog'];
    updatedVillage = widget.userData?['village'];
    updatedhouseNo = widget.userData?['house_no'];
    updatedThramNo = widget.userData?['thram_no'];
    updatedCountry = widget.userData?['country'];

    // Initialize the updatedData with the initial userData
    updatedData = Map.from(widget.userData ?? {});

    // Initialize the default values
    defaultDzongkhag = widget.userData?['dzongkhag'] ?? '';
    defaultGewog = widget.userData?['gewog'] ?? '';
    defaultVillage = widget.userData?['village'] ?? '';
    defaulthouseNo = widget.userData?['house_no'] ?? '';
    defaultThramNo = widget.userData?['thram_no'] ?? '';
    defaultCountry = widget.userData?['country'] ?? '';
  }

  void resetValues() {
    setState(() {
      updatedGewog = defaultGewog;
      updatedVillage = defaultVillage;
      updatedhouseNo = defaulthouseNo;
      updatedThramNo = defaultThramNo;
      updatedCountry = defaultCountry;

      _gewogController.text = defaultGewog;
      _villageController.text = defaultVillage;
      _houseNoController.text = defaulthouseNo;
      _thramNoController.text = defaultThramNo;
      _countryController.text = defaultCountry;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Permanent Details'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Dzongkhag
              Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    Text(
                      'Dzongkhag: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: updatedDzongkhag,
                        items: [
                          'Bumthang',
                          'Chhukha',
                          'Dagana',
                          'Gasa',
                          'Haa',
                          'Lhuntse',
                          'Mongar',
                          'Paro',
                          'Pemagatshel',
                          'Punakha',
                          'Samdrup Jongkhar',
                          'Samtse',
                          'Sarpang',
                          'Thimphu',
                          'Trashigang',
                          'Trashiyangtse',
                          'Trongsa',
                          'Tsirang',
                          'Wangdue Phodrang',
                          'Zhemgang'
                        ]
                            .map((type) => DropdownMenuItem<String>(
                                  value: type,
                                  child: Text(type),
                                ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            updatedDzongkhag = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),

              // Gewog
              Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    Text(
                      'Gewog: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Enter your Gewog',
                        ),
                        controller: _gewogController,
                        onChanged: (value) {
                          setState(() {
                            updatedGewog = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),

              // Village
              Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    Text(
                      'Village: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Enter your Village Name',
                        ),
                        controller: _villageController,
                        onChanged: (value) {
                          setState(() {
                            updatedVillage = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),

              // House No
              Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    Text(
                      'House No: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Enter your House Number',
                        ),
                        controller: _houseNoController,
                        onChanged: (value) {
                          setState(() {
                            updatedhouseNo = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),

              // ThramNo
              Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    Text(
                      'Thram No: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Enter your Thram Number',
                        ),
                        controller: _thramNoController,
                        onChanged: (value) {
                          setState(() {
                            updatedThramNo = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),

              // Country
              Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    Text(
                      'Country: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Enter your Country Name',
                        ),
                        controller: _countryController,
                        onChanged: (value) {
                          setState(() {
                            updatedCountry = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),

              // Button to save and
              Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment
                      .spaceEvenly, // Adjust alignment as needed
                  children: [
                    //Save Button
                    ElevatedButton.icon(
                      onPressed: () async {
                        final storage = FlutterSecureStorage();
                        String? studentId = await storage.read(key: 'std_id');
                        print(studentId);

                        // Make the post request
                        if (studentId != null) {
                          // Convert studentId to string and pad with leading zeros if needed
                          String formattedStudentId = studentId.padLeft(8, '0');

                          // Update the relevant parts to use the updatedData
                          Map<String, dynamic> postData = {
                            'dzongkhag': updatedDzongkhag,
                            'gewog': updatedGewog,
                            'village': updatedVillage,
                            'house_no': updatedhouseNo,
                            'thram_no': updatedThramNo,
                            'country': updatedCountry,
                            'student_id': formattedStudentId,
                          };

                          try {
                            var response = await http.patch(
                              Uri.parse(
                                  'http://172.20.10.2:8888/api/users/student/permanent'),
                              headers: {
                                'Content-Type': 'application/json',
                              },
                              body: jsonEncode(postData),
                            );

                            if (response.statusCode == 200) {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Row(
                                      children: [
                                        Icon(
                                          Icons.check_circle,
                                          color: Colors.green,
                                        ),
                                        SizedBox(width: 8),
                                        Text('Success'),
                                      ],
                                    ),
                                    content: Text('Data Updated Successfully'),
                                    actions: <Widget>[
                                      TextButton(
                                        child: Text('OK'),
                                        onPressed: () {
                                          Navigator.of(context)
                                              .pop(); // Close the dialog
                                          Navigator.pop(context,
                                              postData); // Pass the updated data back
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            } else {
                              print(
                                  'Failed to update the data. Status code: ${response.statusCode}');
                            }
                          } catch (error) {
                            print('Error fetching user data: $error');
                            throw error;
                          }
                        } else {
                          print("Null StudentId");
                        }
                      },

                      icon: Icon(Icons.save, color: Colors.white), // Save icon
                      label:
                          Text('Save', style: TextStyle(color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Colors.green), // Set the button color to green
                    ),

                    // Cancel button
                    ElevatedButton.icon(
                      onPressed: () {
                        resetValues();
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Cancelled'),
                              content: Text('Changes have been cancelled.'),
                              actions: <Widget>[
                                TextButton(
                                  child: Text('OK'),
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pop(); // Close the dialog
                                    Navigator.pop(
                                        context); // Navigate back to the home page
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                      icon: Icon(Icons.cancel,
                          color: Colors.white), // Cancel icon
                      label:
                          Text('Cancel', style: TextStyle(color: Colors.white)),
                      style:
                          ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
