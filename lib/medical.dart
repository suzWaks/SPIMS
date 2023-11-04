import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class MedicalPage extends StatefulWidget {
  const MedicalPage({Key? key,required this.isDarkModeEnabled}) : super(key: key);

  final bool isDarkModeEnabled;
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

  @override
  void dispose() {
    _allergiesController.dispose();
    _medicationController.dispose();
    _seizuresController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
 final bool isDarkModeEnabled = widget.isDarkModeEnabled;
    return Scaffold(
        backgroundColor: isDarkModeEnabled
      ? const Color.fromARGB(255, 86, 83, 83)
      : const Color.fromARGB(255, 255, 255, 255),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Stack(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(110.0),
                    child: Image.asset(
                      "Images/suz.jpg",
                      width: 170,
                      height: 170,
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 40,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    color: const Color.fromARGB(255, 255, 255, 255),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Suzal Wakhley',
                          style: TextStyle(
                           
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Blood Group: A+',
                          style: TextStyle(
                       
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          'DOB: 27/06/2003',
                          style: TextStyle(
                        
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          'Age: 20',
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
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: _showEmergencyContactInfo,
                style: ElevatedButton.styleFrom(
                  primary: const Color.fromARGB(255, 255, 102, 0),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
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
            Container(
              width: MediaQuery.of(context).size.width - 40,
              decoration: BoxDecoration(
                     color: widget.isDarkModeEnabled
            ? const Color.fromRGBO(52, 52, 52, 1)
            : const Color(0xFFF1F8F8),
                borderRadius: BorderRadius.circular(30.0),
              ),
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    const Expanded(
      child: Text(
        'Allergies: Dust & Mites',
        style: TextStyle(
          fontSize: 18,
        ),
      ),
    ),
    IconButton(
      icon: const Icon(Icons.edit),
      color: const Color.fromARGB(255, 240, 106, 17),
      onPressed: () {
        // Handle edit button press
      },
    ),
  ],
),

                  const Text(
                    'Medication:               None',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  const Text(
                    'Seizures/ Strokes:    Never',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.all(5),
                    color: const Color.fromARGB(255, 255, 255, 255),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'I have never been diagnosed with a medical condition that requires ongoing care and management. '
                          'I am committed to following my healthcare provider\'s recommendations and maintaining a positive outlook '
                          'on my journey towards better health.',
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
            ElevatedButton.icon(
              onPressed: _showAddPrescriptionDialog,
              style: ElevatedButton.styleFrom(
                primary: const Color.fromARGB(255, 0, 40, 168),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                padding: const EdgeInsets.all(16.0),
                fixedSize: const Size(300.0, 60.0),
              ),
              icon: const Icon(Icons.photo_outlined, color: Colors.white),
              label: const Text(
                'Add Prescription',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              height: 300,
              child: Stack(
                children: [
                  CarouselSlider(
                    carouselController: _carouselController,
                    options: CarouselOptions(
                      enableInfiniteScroll: false,
                      viewportFraction: 0.8,
                      initialPage: 0,
                      onPageChanged: (index, reason) {
                        setState(() {
                          currentPage = index;
                        });
                      },
                    ),
                    items: [
                      Container(
                        width: 200,
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: const DecorationImage(
                            image: AssetImage("Images/pres.png"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        width: 200,
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: const DecorationImage(
                            image: AssetImage("Images/pres2.png"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    left: 10,
                    top: 120,
                    child: IconButton(

                      icon: const Icon(Icons.arrow_back_outlined),
                      color: const Color.fromARGB(255, 255, 102, 0),
                      onPressed: () {
                        _carouselController.previousPage();
                      },
                    ),
                  ),
                  Positioned(
                    right: 10,
                    top: 120,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_forward_outlined),
                      color: const Color.fromARGB(255, 255, 102, 0),
                      onPressed: () {
                        _carouselController.nextPage();
                      },
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        for (int i = 0; i < 3; i++)
                          Container(
                            width: 10,
                            height: 10,
                            margin: const EdgeInsets.symmetric(horizontal: 2),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: i == currentPage
                                  ? const Color.fromARGB(255, 255, 102, 0)
                                  : Colors.grey,
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showEmergencyContactInfo() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildEmergencyContact('Mr. X', 'Father', '17614757'),
              const SizedBox(height: 20),
              _buildEmergencyContact('Mrs. Y', 'Mother', '17118279'),
            ],
          ),
        );
      },
    );
  }

  Widget _buildEmergencyContact(
      String name, String relation, String phoneNumber) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        Text(
          relation,
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
        Text(
          phoneNumber,
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
      ],
    );
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
            padding: const EdgeInsets.all(16),
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
                      child: const Icon(Icons.close),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Text('Choose an option:'),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    // Handle adding prescription from gallery
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    primary: const Color.fromARGB(
                        255, 0, 40, 168), // Set your desired color
                  ),
                  child: const Text('Choose from Gallery'),
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
                  child: const Text('Choose File'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
 
  
  
}
