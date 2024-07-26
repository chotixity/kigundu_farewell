import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class ApiService {
  factory ApiService() => _instance;
  ApiService._internal();

  static final ApiService _instance = ApiService._internal();

  final _logger = Logger();
  final _baseUrl = "https://podcasts-backend-17aw.onrender.com/";
  final _timeout = const Duration(seconds: 60);

  // Helper method to set headers for each request
  Map<String, String> _getHeaders(String? token) {
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
  }

  Future<http.Response> _sendRequest(String url, String method,
      {Map<String, dynamic>? body, Map<String, String>? headers}) async {
    var uri = Uri.parse('$_baseUrl$url');
    try {
      switch (method) {
        case 'POST':
          return await http
              .post(uri, headers: headers, body: json.encode(body))
              .timeout(_timeout);
        case 'GET':
          return await http.get(uri, headers: headers).timeout(_timeout);
        case 'PUT':
          return await http
              .put(uri, headers: headers, body: json.encode(body))
              .timeout(_timeout);
        case 'DELETE':
          return await http.delete(uri, headers: headers).timeout(_timeout);
        default:
          throw 'Method not supported';
      }
    } on SocketException {
      throw Exception('No internet connection');
    } on TimeoutException {
      throw Exception('Session timeout');
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getReq(String url,
      {Map<String, String>? headers}) async {
    final response = await _sendRequest(url, 'GET', headers: headers);
    return _handleResponse(response);
  }

  Future<Map<String, dynamic>> postReq(String url,
      {Map<String, dynamic>? body, Map<String, String>? headers}) async {
    final response =
        await _sendRequest(url, 'POST', body: body, headers: headers);
    return _handleResponse(response);
  }

  Future<Map<String, dynamic>> putReq(String url,
      {Map<String, dynamic>? body, Map<String, String>? headers}) async {
    final response =
        await _sendRequest(url, 'PUT', body: body, headers: headers);
    return _handleResponse(response);
  }

  Future<Map<String, dynamic>> deleteReq(String url,
      {Map<String, String>? headers}) async {
    final response = await _sendRequest(url, 'DELETE', headers: headers);
    return _handleResponse(response);
  }

  Map<String, dynamic> _handleResponse(http.Response response) {
    final statusCode = response.statusCode;
    _logger.d("Status Code: $statusCode, Response Body: ${response.body}");

    if (response.statusCode >= 200 && response.statusCode < 300) {
      if (response.body.isEmpty) return {};
      try {
        final responseBody = json.decode(response.body);
        if (responseBody is List && responseBody.isNotEmpty) {
          return responseBody[0];
        } else if (responseBody is Map<String, dynamic>) {
          return responseBody;
        } else {
          _logger.d('Unexpected JSON structure: $responseBody');
          throw Exception('Unexpected JSON structure.');
        }
      } catch (e) {
        _logger.d('JSON decode error: $e');
        throw Exception('Failed to decode JSON');
      }
    } else {
      _logger.d('Error: ${response.body}');
      throw Exception('Error $statusCode: ${response.body}');
    }
  }

  Future<String> _refreshToken() async {
    // This function should be adapted based on your authentication flow.
    // Assuming you have some logic to get new tokens when they expire.
    // For now, just returning a placeholder.
    return '[NEW_ACCESS_TOKEN]';
  }
}
