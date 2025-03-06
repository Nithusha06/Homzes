import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'welcome_bloc.dart';
import 'bottom_widget.dart'; // Import the BottomWidget
import 'search_catalog_screen1.dart'; // Add this import

// BigIconButton class definition
class BigIconButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min, // Ensure the column takes minimum space
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            shape: BoxShape.circle, // Make the container circular
            border: Border.all(width: 1, color: Colors.white), // Circular border
          ),
          child: ClipOval(
            child: Image.asset(
              'assets/more.png', // Add the more.png image here
              width: 50, // Match the container size
              height: 50, // Match the container size
              fit: BoxFit.cover, // Cover the entire circle
            ),
          ),
        ),
      ],
    );
  }
}

// New FindTheBestPlaceForYou class definition
class FindTheBestPlaceForYou extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 245,
          child: Text(
            'Find the best place for you',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 36,
              fontFamily: 'Roboto Flex',
              fontWeight: FontWeight.w700,
              height: 1,
              letterSpacing: -0.72,
            ),
          ),
        ),
      ],
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WelcomeCubit(),
      child: Scaffold(
        body: Stack(
          children: [
            // Background Image
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/background.png'), // Add your image here
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Black overlay with 74% opacity
            Container(
              color: Colors.black.withOpacity(0.74), // 74% opacity
            ),
            // Overlay content
            Positioned(
              top: 40,
              left: 20,
              child: Text(
                'Homezs',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Positioned(
              top: 40,
              right: 20,
              child: Padding( // Added Padding to prevent overflow
                padding: const EdgeInsets.only(right: 10), // Adjust as needed
                child: BigIconButton(), // Add the BigIconButton here
              ),
            ),
            // Add the FindTheBestPlaceForYou widget
            Positioned(
              bottom: 30,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  FindTheBestPlaceForYou(),
                  SizedBox(height: 30),  // Add spacing between text and cards
                  BottomWidget(),
                  SizedBox(height: 40),  // Spacing before the button
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: BigButton(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BigButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SearchCatalogScreen1(),
              ),
            );
          },
          child: Container(
            width: 353,
            height: 48,
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 13),
            decoration: ShapeDecoration(
              color: Color(0xFF37AD5F),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Create an account',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'Roboto Flex',
                    fontWeight: FontWeight.w600,
                    height: 1.40,
                    letterSpacing: -0.16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}