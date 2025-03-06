import 'dart:io';
import 'package:flutter/material.dart';
import '../services/storage_service.dart';
import '../services/firebase_service.dart';

class AddPropertyScreen extends StatefulWidget {
  @override
  _AddPropertyScreenState createState() => _AddPropertyScreenState();
}

class _AddPropertyScreenState extends State<AddPropertyScreen> {
  final StorageService _storageService = StorageService();
  final FirebaseService _firebaseService = FirebaseService();
  
  File? _selectedImage;
  final _titleController = TextEditingController();
  final _locationController = TextEditingController();
  final _priceController = TextEditingController();
  final _bedsController = TextEditingController();
  final _bathroomsController = TextEditingController();

  Future<void> _pickAndUploadImage() async {
    File? image = await _storageService.pickImage();
    if (image != null) {
      setState(() {
        _selectedImage = image;
      });
    }
  }

  Future<void> _submitProperty() async {
    if (_selectedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select an image')),
      );
      return;
    }

    try {
      // Show loading indicator
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(child: CircularProgressIndicator()),
      );

      // Upload image and get URL
      String? imageUrl = await _storageService.uploadImage(_selectedImage!);

      if (imageUrl != null) {
        // Add property to Firestore
        await _firebaseService.addPropertyWithImage(
          _titleController.text,
          _selectedImage!,
          _locationController.text,
          double.parse(_priceController.text),
          int.parse(_bedsController.text),
          int.parse(_bathroomsController.text),
        );

        // Hide loading indicator
        Navigator.pop(context);

        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Property added successfully')),
        );

        // Clear form
        _clearForm();
      }
    } catch (e) {
      // Hide loading indicator
      Navigator.pop(context);
      
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  void _clearForm() {
    setState(() {
      _selectedImage = null;
    });
    _titleController.clear();
    _locationController.clear();
    _priceController.clear();
    _bedsController.clear();
    _bathroomsController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Property')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // Image picker
            GestureDetector(
              onTap: _pickAndUploadImage,
              child: Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: _selectedImage != null
                    ? Image.file(_selectedImage!, fit: BoxFit.cover)
                    : Icon(Icons.add_photo_alternate, size: 50),
              ),
            ),
            SizedBox(height: 16),
            
            // Form fields
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: _locationController,
              decoration: InputDecoration(labelText: 'Location'),
            ),
            TextField(
              controller: _priceController,
              decoration: InputDecoration(labelText: 'Price'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _bedsController,
              decoration: InputDecoration(labelText: 'Number of Beds'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _bathroomsController,
              decoration: InputDecoration(labelText: 'Number of Bathrooms'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 24),
            
            // Submit button
            ElevatedButton(
              onPressed: _submitProperty,
              child: Text('Add Property'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
              ),
            ),
          ],
        ),
      ),
    );
  }
} 