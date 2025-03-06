import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ImgBBService {
  final String apiKey = 'YOUR_IMGBB_API_KEY';  // Replace with your API key

  Future<String?> uploadImage(File imageFile) async {
    try {
      // Read file as bytes
      final bytes = await imageFile.readAsBytes();
      // Convert to base64
      final base64Image = base64Encode(bytes);
      
      // Upload to ImgBB
      final response = await http.post(
        Uri.parse('https://api.imgbb.com/1/upload'),
        body: {
          'key': apiKey,
          'image': base64Image,
        },
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        return jsonResponse['data']['url'];
      }
      return null;
    } catch (e) {
      print('Error uploading to ImgBB: $e');
      return null;
    }
  }
} 