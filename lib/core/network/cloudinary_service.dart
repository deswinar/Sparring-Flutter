import 'dart:convert';
import 'dart:io';
import 'package:cloudinary_flutter/cloudinary_object.dart';
import 'package:http/http.dart' as http;

class CloudinaryException implements Exception {
  final String message;
  final int? statusCode;

  CloudinaryException(this.message, [this.statusCode]);

  @override
  String toString() {
    return 'CloudinaryException: $message${statusCode != null ? ' (StatusCode: $statusCode)' : ''}';
  }
}

class CloudinaryService {
  late final CloudinaryObject _cloudinaryObject;

  CloudinaryService({required String cloudName}) {
    _cloudinaryObject = CloudinaryObject.fromCloudName(cloudName: cloudName);
  }

  /// Upload file to Cloudinary
  Future<String?> uploadFile(File imageFile,
      {required String publicId, String folderName = ''}) async {
    final url =
        Uri.parse('https://api.cloudinary.com/v1_1/djnfz4ehq/image/upload');
    try {
      final request = http.MultipartRequest('POST', url);
      // request.headers['Authorization'] = 'Basic $base64Auth';
      request.fields['upload_preset'] = 'custom1';
      request.files
          .add(await http.MultipartFile.fromPath('file', imageFile.path));

      final response = await request.send();

      if (response.statusCode != 200) {
        final responseBody = await response.stream.bytesToString();
        throw CloudinaryException(
            'Failed to upload image: $responseBody', response.statusCode);
      }

      final responseData = await response.stream.bytesToString();
      final jsonResponse = jsonDecode(responseData);

      if (jsonResponse['url'] == null) {
        throw CloudinaryException(
            'Invalid response from Cloudinary: url is missing');
      }

      return jsonResponse['url'];
    } catch (e) {
      if (e is CloudinaryException) {
        rethrow; // Re-throw CloudinaryExceptions to be handled by the caller
      } else if (e is SocketException) {
        throw CloudinaryException('Network error: ${e.message}');
      } else {
        throw CloudinaryException(
            'An unexpected error occurred: ${e.toString()}');
      }
    }
  }

  /// Delete file from Cloudinary by public ID
  Future<bool> deleteFile(String publicId) async {
    final url =
        Uri.parse('https://api.cloudinary.com/v1_1/djnfz4ehq/image/destroy');
    try {
      final request = http.MultipartRequest('POST', url);

      final response = await request.send();

      if (response.statusCode != 200) {
        final responseBody = await response.stream.bytesToString();
        throw CloudinaryException(
            'Failed to delete image: $responseBody', response.statusCode);
      }

      final responseData = await response.stream.bytesToString();
      final jsonResponse = jsonDecode(responseData);

      if (jsonResponse['url'] == null) {
        throw CloudinaryException(
            'Invalid response from Cloudinary: url is missing');
      }

      return jsonResponse['url'];
    } catch (e) {
      if (e is CloudinaryException) {
        rethrow; // Re-throw CloudinaryExceptions to be handled by the caller
      } else if (e is SocketException) {
        throw CloudinaryException('Network error: ${e.message}');
      } else {
        throw CloudinaryException(
            'An unexpected error occurred: ${e.toString()}');
      }
    }
  }
}
