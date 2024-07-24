import 'dart:convert';
import 'package:http/http.dart' as http;

class HttpRequests {
  final String baseUrl;
  final Duration timeoutDuration;

  HttpRequests(
      {required this.baseUrl,
      this.timeoutDuration = const Duration(seconds: 10)});

  Future<http.Response> getRequest(String endpoint,
      {Map<String, String>? headers}) async {
    try {
      final url = Uri.parse('$baseUrl$endpoint');
      final response =
          await http.get(url, headers: headers).timeout(timeoutDuration);
      return response;
    } on http.ClientException catch (e) {
      throw Exception('HTTP Client Exception: ${e.message}');
    } on Exception catch (e) {
      throw Exception('Error performing GET request: $e');
    }
  }

  Future<http.Response> postRequest(String endpoint,
      {Map<String, dynamic>? body, Map<String, String>? headers}) async {
    try {
      final url = Uri.parse('$baseUrl$endpoint');
      final response = await http
          .post(
            url,
            headers: headers,
            body: jsonEncode(body),
          )
          .timeout(timeoutDuration);
      return response;
    } on http.ClientException catch (e) {
      throw Exception('HTTP Client Exception: ${e.message}');
    } on Exception catch (e) {
      throw Exception('Error performing POST request: $e');
    }
  }

  Future<http.Response> patchRequest(String endpoint,
      {Map<String, dynamic>? body, Map<String, String>? headers}) async {
    try {
      final url = Uri.parse('$baseUrl$endpoint');
      final response = await http
          .patch(
            url,
            headers: headers,
            body: jsonEncode(body),
          )
          .timeout(timeoutDuration);
      return response;
    } on http.ClientException catch (e) {
      throw Exception('HTTP Client Exception: ${e.message}');
    } on Exception catch (e) {
      throw Exception('Error performing PATCH request: $e');
    }
  }

  Future<http.Response> deleteRequest(String endpoint,
      {Map<String, String>? headers}) async {
    try {
      final url = Uri.parse('$baseUrl$endpoint');
      final response =
          await http.delete(url, headers: headers).timeout(timeoutDuration);
      return response;
    } on http.ClientException catch (e) {
      throw Exception('HTTP Client Exception: ${e.message}');
    } on Exception catch (e) {
      throw Exception('Error performing DELETE request: $e');
    }
  }
}
