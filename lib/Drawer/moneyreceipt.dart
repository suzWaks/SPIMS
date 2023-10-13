import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

final List<String> imgList = [
  'Images/rec1.jpeg',
  'Images/rec2.jpeg',
  'Images/rec3.jpeg',
];

class MoneyReceiptPage extends StatefulWidget {
  final CarouselController _carouselController = CarouselController();
  @override
  _MoneyReceiptPageState createState() => _MoneyReceiptPageState();
}

class _MoneyReceiptPageState extends State<MoneyReceiptPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0), // Adjust the padding as needed
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text(
              'Money Receipt',
              style: TextStyle(
                fontSize: 35.0,
                color: Color.fromARGB(255, 255, 102, 0),
                fontFamily: '', 
              ),
            ),
            const SizedBox(height: 25), // Added some space between text and images

            CarouselSlider(
              carouselController: widget._carouselController,
              options: CarouselOptions(
                enableInfiniteScroll: false,
                viewportFraction: 0.8,
                initialPage: 0,
              ),
              items: imgList
                  .map(
                    (item) => Container(
                      margin: const EdgeInsets.symmetric(horizontal: 5.0),
                      padding: const EdgeInsets.all(15.0), // Increased padding
                      width: 800, // Expanded the container width
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0), // Adjusted border radius
                        boxShadow: [
                          BoxShadow(
                            color: const Color.fromARGB(255, 228, 220, 220).withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3), // changes position of shadow
                          ),
                        ],
                        border: Border.all(
                          color: Colors.white, // Set the color of the border
                          width: 2.0,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15.0),
                        child: Image.asset(item, fit: BoxFit.cover),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
