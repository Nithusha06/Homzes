import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class StorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final ImagePicker _picker = ImagePicker();

  // Pick image from gallery
  Future<File?> pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1920,  // Optimize image size
        maxHeight: 1080,
        imageQuality: 85, // Compress image
      );
      if (image != null) {
        return File(image.path);
      }
      return null;
    } catch (e) {
      print('Error picking image: $e');
      return null;
    }
  }

  // Upload image and get URL
  Future<String?> uploadImage(File imageFile) async {
    try {
      // Create unique file name
      String fileName = 'property_${DateTime.now().millisecondsSinceEpoch}.jpg';
      
      // Create storage reference
      Reference ref = _storage.ref().child('property_images/$fileName');
      
      // Upload image
      await ref.putFile(
        imageFile,
        SettableMetadata(
          contentType: 'image/jpeg',
          cacheControl: 'public, max-age=31536000',  // Cache for 1 year
        ),
      );
      
      // Get download URL
      String downloadURL = await ref.getDownloadURL();
      return downloadURL;
    } catch (e) {
      print('Error uploading image: $e');
      return null;
    }
  }
} 