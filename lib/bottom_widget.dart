import 'package:flutter/material.dart';

class BottomWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildCard(
            color: Color(0xFFF5E1C2), // Light beige
            iconPath: 'assets/Renthome.png',
            text: 'Rent'
          ),
          SizedBox(width: 16), // spacing between cards
          _buildCard(
            color: Color(0xFFF0F298), // Light yellow
            iconPath: 'assets/Buyhome.png',
            text: 'Buy'
          ),
          SizedBox(width: 16),
          _buildCard(
            color: Color(0xFFC6E7BE), // Light green
            iconPath: 'assets/Sellhome.png',
            text: 'Sell'
          ),
        ],
      ),
    );
  }

  Widget _buildCard({
    required Color color,
    required String iconPath,
    required String text,
  }) {
    return Container(
      width: 160,
      height: 172,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            top: 0,
            child: Container(
              width: 160,
              height: 172,
              decoration: ShapeDecoration(
                color: color,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
            ),
          ),
          Positioned(
            left: 20,
            top: 20,
            child: Container(
              width: 60,
              height: 60,
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: OvalBorder(),
              ),
            ),
          ),
          Positioned(
            left: 38,
            top: 38,
            child: Container(
              width: 24,
              height: 24,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(),
              child: Image.asset(
                iconPath,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            left: 20,
            top: 130,
            child: Text(
              text,
              style: TextStyle(
                color: Color(0xFF282828),
                fontSize: 20,
                fontFamily: 'Roboto Flex',
                fontWeight: FontWeight.w700,
                height: 1.10,
                letterSpacing: -0.40,
              ),
            ),
          ),
        ],
      ),
    );
  }
} 