import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:teen_gaule_thakali/e_museum_item.dart';

class EMuseumServices {
  static final Uri ROOT = Uri.parse('http://192.168.10.100/teen-gaule-thakali/actions/e_museum_actions.php');
  static const _E_MUSEUM_GET_DATA = 'E_MUSEUM_GET_DATA';

  // Parse JSON array into List<EMuseum>
  static List<EMuseumItem> parseResponse(String responseBody) {
    final parsed = jsonDecode(responseBody) as List<dynamic>;
    return parsed.map<EMuseumItem>((json) => EMuseumItem.fromJson(json as Map<String, dynamic>)).toList();
  }

  // Fetch e-museum data and return a list of EMuseum or handle errors
  Future<Map<String, dynamic>> eMuseumGetData() async {
    try {
      var map = <String, dynamic>{};
      map['action'] = _E_MUSEUM_GET_DATA;
      final response = await http.post(ROOT, body: map);

      if (response.statusCode == 200) {
        // Check if response is an array (successful data)
        final decoded = jsonDecode(response.body);
        if (decoded is List) {
          return {
            'status': 'success',
            'data': parseResponse(response.body),
          };
        } else if (decoded is Map && decoded.containsKey('message')) {
          // Handle "No data found" case (HTTP 404)
          return {
            'status': 'no_data',
            'message': decoded['message'],
          };
        } else {
          // Unexpected response format
          return {
            'status': 'error',
            'message': 'Unexpected response format',
          };
        }
      } else {
        // Handle non-200 status codes
        final decoded = jsonDecode(response.body);
        return {
          'status': 'error',
          'message': decoded['error'] ?? 'HTTP ${response.statusCode} error',
        };
      }
    } catch (e) {
      // Handle exceptions (e.g., network issues, JSON parsing errors)
      return {
        'status': 'exception',
        'message': 'Exception: $e',
      };
    }
  }
}