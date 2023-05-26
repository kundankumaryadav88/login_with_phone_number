import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = 'https://test-otp-api.7474224.xyz';

  Future<Map<String, dynamic>> sendOtp(String mobile) async {
    final requestBody = {"mobile": mobile};
    final url = Uri.parse('$baseUrl/sendotp.php');
    final response = await http.post(url, body: jsonEncode(requestBody));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception("Error sending OTP: {response.statusCode}");
    }
  }

  Future<Map<String, dynamic>> verifyOtp(String requestId, String code) async {
    final requestBody = {"request_id": requestId, 'code': code};
    final url = Uri.parse('$baseUrl/verifyotp.php');
    final response = await http.post(
      url,
      body: jsonEncode(requestBody),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      return responseData;
    } else {
      throw Exception('Failed to verify OTP');
    }
  }

  Future<Map<String, dynamic>> submitProfile(
      String name, String email, String jwt) async {
    final requestBody = {'name': name, 'email': email};
    final url = Uri.parse('$baseUrl/profilesubmit.php');
    final response = await http.post(
      url,
      headers: {'Token': ' $jwt'},
      body: jsonEncode(requestBody),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      return responseData;
    } else {
      throw Exception('Failed to submit profile');
    }
  }
}
