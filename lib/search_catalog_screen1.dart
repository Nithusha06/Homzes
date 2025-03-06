import 'package:flutter/material.dart';
import 'featured_tab.dart';
import 'offered_tab.dart';
import 'search_catalog_screen2.dart';

void main() {
  runApp(const FigmaToCodeApp());
}

class FigmaToCodeApp extends StatelessWidget {
  const FigmaToCodeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color.fromARGB(255, 18, 32, 47),
      ),
      home: SearchCatalogScreen1(),
    );
  }
}

class SearchCatalogScreen1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(160),
        child: Stack(
          children: [
            AppBar(
              automaticallyImplyLeading: false,
              title: null,
              backgroundColor: Color(0xFFF0F298),
              toolbarHeight: 160,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(30),
                ),
              ),
              elevation: 4,
            ),
            Positioned(
              top: 40, // Position from top
              left: 16, // Position from left
              child: Image.asset(
                'assets/more1.png',
                width: 60,
                height: 60,
                fit: BoxFit.contain,
              ),
            ),
            Positioned(
              top: 40,
              right: 16,
              child: Row(
                children: [
                  Text(
                    'Hi, Stanislav',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(width: 8), // Space between text and circle
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Color(0xFFA9A9A9),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        'S',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              left: 16,
              right: 16,
              bottom: 20,
              child: Container(
                width: 353,
                height: 50,
                child: Stack(
                  children: [
                    Container(
                      width: 353,
                      height: 50,
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 54,
                      top: 14,
                      child: Text(
                        'Search',
                        style: TextStyle(
                          color: Color(0xFF535353),
                          fontSize: 16,
                          fontFamily: 'Roboto Flex',
                          fontWeight: FontWeight.w600,
                          height: 1.40,
                          letterSpacing: -0.16,
                        ),
                      ),
                    ),
                    Positioned(
                      left: 20,
                      top: 13,
                      child: Image.asset(
                        'assets/Search.png',
                        width: 24,
                        height: 24,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Featured(),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SearchCatalogScreen2(),
                      ),
                    );
                  },
                  child: Text(
                    'View all',
                    style: TextStyle(
                      color: Color(0xFF7E7E7E),
                      fontSize: 14,
                      fontFamily: 'Roboto Flex',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          FeaturedTab(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'New offers',
                  style: TextStyle(
                    color: Color(0xFF282828),
                    fontSize: 18,
                    fontFamily: 'Roboto Flex',
                    fontWeight: FontWeight.w700,
                    height: 1.10,
                    letterSpacing: -0.36,
                  ),
                ),
                Text(
                  'View all',
                  style: TextStyle(
                    color: Color(0xFF7E7E7E),
                    fontSize: 14,
                    fontFamily: 'Roboto Flex',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          OfferedTab(),
        ],
      ),
    );
  }
}

class Featured extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text(
        'Featured',
        style: TextStyle(
          color: Color(0xFF282828),
          fontSize: 18,
          fontFamily: 'Roboto Flex',
          fontWeight: FontWeight.w700,
          height: 1.10,
          letterSpacing: -0.36,
        ),
      ),
    );
  }
}
