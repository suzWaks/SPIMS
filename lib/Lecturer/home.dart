import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ExampleItem {
  final String title;

  ExampleItem({
    required this.title,
  });
}

class ExampleItemPager {
  int pageIndex = 0;
  final int pageSize;

  ExampleItemPager({
    this.pageSize = 20,
  });

  List<ExampleItem> nextBatch() {
    List<ExampleItem> batch = [];

    for (int i = 0; i < pageSize; i++) {
      batch.add(ExampleItem(title: 'Item ${pageIndex * pageSize + i}'));
    }

    pageIndex += 1;

    return batch;
  }
}

class Home extends StatefulWidget {
  const Home({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<Home> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    late Color mycolor = Theme.of(context).primaryColor;
    ExampleItemPager pager = ExampleItemPager();

    return Scaffold(
      body: ListView(children: [
        Center(
          child: Padding(
            // Setting Padding for the images
            padding: const EdgeInsets.only(
                top: 0.0), // Adjust the top padding as needed
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      constraints: BoxConstraints(
                          maxHeight: 200, maxWidth: double.infinity),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            Color(0xff022AAB),
                            Color(0xff2452E1),
                          ],
                        ),

                        // ignore: prefer_const_constructors
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.zero,
                          topRight: Radius.zero,
                          bottomLeft: Radius.elliptical(700, 590),
                          bottomRight: Radius.elliptical(700, 590),
                        ),

                        image: DecorationImage(
                          image: AssetImage('Images/settings.jpg'),
                          fit: BoxFit.fitWidth,
                          colorFilter: ColorFilter.mode(
                              mycolor.withOpacity(0.5), BlendMode.dstATop),
                        ),
                      ),
                    ),
                    const Column(
                      children: [
                        Text(
                          'Student Personal',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 33,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          'Management',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 33,
                              fontWeight: FontWeight.w400),
                        ),
                        Text(
                          'System',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 33,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 50),
                const Column(
                  children: [
                    Text(
                      'Search Student',
                      style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w400,
                          color: Color(
                            0xFF0028A8,
                          )),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(
                              width: 0.8,
                              color: Colors.red, // Default border color
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(
                              width: 2,
                              color: Color.fromARGB(
                                  255, 46, 201, 38), // Focused border color
                            ),
                          ),
                          // enabledBorder: OutlineInputBorder(
                          //   borderSide: BorderSide(
                          //     color: Colors
                          //         .red, // Change this color to your desired border color
                          //     width: 0.8,
                          //   ),
                          // ),
                          // focusedBorder: OutlineInputBorder(
                          //   borderSide: BorderSide(
                          //     width:
                          //         2, // Increase the width to make it more prominent when focused
                          //     color: Color.fromARGB(255, 46, 201,
                          //         38), // Change this color to your desired focused border color
                          //   ),
                          // ),
                          hintText: 'Search Student Number',
                          prefixIcon: Padding(
                            padding: EdgeInsets.all(10),
                            child: SvgPicture.asset('Images/search.svg'),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(Icons.close_sharp),
                            onPressed: () {
                              // Implement the handling
                            },
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
