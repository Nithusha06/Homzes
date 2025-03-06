import 'package:flutter/material.dart';
import 'models/property.dart';
import 'services/firebase_service.dart';

class FeaturedTab extends StatelessWidget {
  final FirebaseService _firebaseService = FirebaseService();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Property>>(
      future: _firebaseService.getProperties(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          print('Firebase error: ${snapshot.error}');
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        final properties = snapshot.data ?? [];
        print('Loaded properties: ${properties.length}');
        if (properties.isEmpty) {
          return Center(child: Text('No properties found'));
        }

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: properties.map((property) {
              print('Property imageUrl: ${property.imageUrl}');
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: PropertyCard(property: property),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}

class PropertyCard extends StatelessWidget {
  final Property property;

  const PropertyCard({required this.property});

  @override
  Widget build(BuildContext context) {
    print('Building PropertyCard with imageUrl: ${property.imageUrl}'); // Debug print

    return Container(
      width: 200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                width: 200,
                height: 150,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    property.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      print('Error loading image: $error'); // Debug print
                      print('Stack trace: $stackTrace'); // Debug print
                      return Container(
                        color: Colors.grey[300],
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.error_outline, size: 30),
                              SizedBox(height: 4),
                              Text('Error: $error', 
                                style: TextStyle(fontSize: 10),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      print('Loading progress: $loadingProgress'); // Debug print
                      return Container(
                        color: Colors.grey[200],
                        child: Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded / 
                                    loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              // Price tag
              Positioned(
                right: 8,
                bottom: 8,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '\$${property.price}',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            property.title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 4),
          Text(
            property.description,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
