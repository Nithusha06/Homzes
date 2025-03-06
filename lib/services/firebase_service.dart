import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/property.dart';
import 'imgbb_service.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final ImgBBService _imgBBService = ImgBBService();

  // Add a property
  Future<void> addProperty(Property property) async {
    try {
      await _firestore.collection('properties').add({
        'imageUrl': property.imageUrl,
        'title': property.title,
        'description': property.description,
        'price': property.price,
        'location': property.location,
        'beds': property.beds,
        'bathrooms': property.bathrooms,
      });
    } catch (e) {
      print('Error adding property: $e');
      throw e;
    }
  }

  // Get all properties
  Future<List<Property>> getProperties() async {
    try {
      final QuerySnapshot snapshot = await _firestore.collection('properties').get();
      
      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        print('Raw imageUrl from Firebase: ${data['imageUrl']}'); // Debug print
        final property = Property.fromMap(data);
        print('Processed imageUrl: ${property.imageUrl}'); // Debug print
        return property;
      }).toList();
    } catch (e) {
      print('Error fetching properties: $e');
      return [];
    }
  }

  // Add property with image
  Future<void> addPropertyWithImage(
    String title,
    File imageFile,
    String location,
    double price,
    int beds,
    int bathrooms,
  ) async {
    try {
      // Upload to ImgBB first
      String? imageUrl = await _imgBBService.uploadImage(imageFile);
      
      if (imageUrl != null) {
        // Create property with ImgBB URL
        Property property = Property(
          title: title,
          imageUrl: imageUrl,
          location: location,
          price: price,
          beds: beds,
          bathrooms: bathrooms,
          description: '',
        );
        
        // Add to Firestore
        await addProperty(property);
      }
    } catch (e) {
      print('Error adding property: $e');
      throw e;
    }
  }

  Future<String> uploadImage(File image) async {
    try {
      final String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      final Reference ref = _storage.ref().child('property_images/$fileName');
      final UploadTask uploadTask = ref.putFile(image);
      final TaskSnapshot snapshot = await uploadTask;
      final String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print('Error uploading image: $e');
      return '';
    }
  }
} 