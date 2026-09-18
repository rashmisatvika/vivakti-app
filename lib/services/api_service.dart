import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:vivakti_app/utils/constants.dart';

class ApiService {
  static Future<bool> sendOtp(String phone) async {
    final response = await http.post(
      Uri.parse('${Constants.baseUrl}/auth/send-otp'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'phone': phone}),
    );
    return response.statusCode == 200;
  }

  static Future<Map<String, dynamic>?> verifyOtp(String phone, String otp) async {
    final response = await http.post(
      Uri.parse('${Constants.baseUrl}/auth/verify-otp'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'phone': phone, 'otp': otp}),
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    }
    return null;
  }

  static Future<Map<String, dynamic>?> detectService(String category) async {
    final response = await http.post(
      Uri.parse('${Constants.baseUrl}/ai/detect-service'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'category': category}),
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    }
    return null;
  }
}
