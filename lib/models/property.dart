class Property {
  final String imageUrl;
  final String title;
  final String description;
  final double price;
  final String location;
  final int beds;
  final int bathrooms;
  final double? rating;
  final int? reviews;

  Property({
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.price,
    required this.location,
    required this.beds,
    required this.bathrooms,
    this.rating,
    this.reviews,
  });

  // Convert Property object to a Map
  Map<String, dynamic> toMap() {
    return {
      'imageUrl': imageUrl,
      'title': title,
      'description': description,
      'price': price,
      'location': location,
      'beds': beds,
      'bathrooms': bathrooms,
      'rating': rating,
      'reviews': reviews,
    };
  }

  // Create Property object from a Map
  factory Property.fromMap(Map<String, dynamic> data) {
    print('Raw data from Firebase: $data'); // Debug raw data
    
    // Directly access the imageUrl field
    String imageUrl = data['imageUrl'] ?? '';
    print('Original imageUrl from data: $imageUrl'); // Debug print
    
    if (imageUrl.isNotEmpty) {
      try {
        // Basic URL cleanup
        imageUrl = imageUrl
            .replaceAll('"', '')
            .replaceAll("'", '')
            .replaceAll('@', '')
            .trim();
        print('After cleanup: $imageUrl'); // Debug print
        
        // Parse and validate URL
        final uri = Uri.parse(imageUrl);
        if (!uri.isAbsolute) {
          throw FormatException('URL must be absolute');
        }
        
        print('Final URL: $imageUrl'); // Debug print
      } catch (e) {
        print('URL processing error: $e');
        imageUrl = 'https://i.ibb.co/KxvL4Fy0/house-image-4.jpg'; // Use direct URL as fallback
      }
    } else {
      print('ImageUrl was empty');
      imageUrl = 'https://i.ibb.co/KxvL4Fy0/house-image-4.jpg'; // Use direct URL as fallback
    }
    
    // Create and return the Property object
    final property = Property(
      imageUrl: imageUrl,
      title: data['title']?.toString() ?? '',
      description: data['description']?.toString() ?? '',
      price: (data['price'] ?? 0).toDouble(),
      location: data['location']?.toString() ?? '',
      beds: int.tryParse(data['beds']?.toString() ?? '0') ?? 0,
      bathrooms: int.tryParse(data['bathrooms']?.toString() ?? '0') ?? 0,
      rating: (data['rating'] ?? 0).toDouble(),
      reviews: int.tryParse(data['reviews']?.toString() ?? '0') ?? 0,
    );
    
    print('Created Property with imageUrl: ${property.imageUrl}'); // Debug final URL
    return property;
  }
}