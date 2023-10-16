import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color(0xFF202020),
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
                  // top: 0,
                ),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: _nameCard(),
                ),
              ),
            ),

            // Image Card
            Positioned(
              top: 30,
              left: 110,
              child: _imagePhoto(),
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
                  child: _basicDetail(),
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
                  child: _parentsDetail(),
                ),
              ),
            ),

            // Further Details Text
            Positioned(
              top: 870,
              left: 30,
              right: 0,
              child: Text(
                'Further Details:',
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
                  child: _furtherDetail(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
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
Widget _nameCard() {
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
          'Suzal Wakhley',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        Text(
          '02210228',
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
          'B.E Information Technology',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    ),
  );
}

// Image
Widget _imagePhoto() {
  return Container(
    alignment: Alignment.center,
    child: ClipRRect(
      borderRadius: BorderRadius.circular(110),
      child: Image.asset(
        'Images/suz.jpg',
        width: 170,
        height: 170,
      ),
    ),
  );
}

// Basic Details Card
Widget _basicDetail() {
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
            // child: SvgPicture.asset(
            //   'Images.edit.svg',
            // ),
            child: Icon(Icons.edit),
          ),
        ),
        Column(
          children: [
            SizedBox(height: 10),
            Text(
              'DOB: ',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Text(
              'Sex: ',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.black,
              ),
            ),
            Text(
              'Religion',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'CID No:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Contact No: ',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Email Address: ',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Scholarship Type: ',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Year: ',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Semsester: ',
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
Widget _parentsDetail() {
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
            // child: SvgPicture.asset(
            //   'Images.edit.svg',
            // ),
            child: Icon(Icons.edit),
          ),
        ),
        Column(
          children: [
            SizedBox(height: 15),
            Text(
              'Name: ',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Text(
              'Relation: ',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.black,
              ),
            ),
            Text(
              'Occupation',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'CID No:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Contact No: ',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Email Address: ',
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
Widget _furtherDetail() {
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
            // child: SvgPicture.asset(
            //   'Images.edit.svg',
            // ),
            child: Icon(Icons.edit),
          ),
        ),
        Column(
          children: [
            SizedBox(height: 15),
            Text(
              'Name: ',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Text(
              'Relation: ',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.black,
              ),
            ),
            Text(
              'Occupation',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'CID No:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Contact No: ',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Email Address: ',
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
