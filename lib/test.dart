// only for test

import 'package:teen_gaule_thakali/services/e_museum_services.dart';

void main() async {
  // Call async function to fetch museum data
  await _museumGetData();
}

Future<void> _museumGetData() async {
  final result = await EMuseumServices().eMuseumGetData();

  switch (result['status']) {
    case 'success':
      final museums = result['data'] as List;
      print('Fetched ${museums.length} museum records:');
      for (var museum in museums) {
        print(museum.toString()); // Assuming EMuseum has a toString method
      }
      break;
    case 'no_data':
      print('No data found: ${result['message']}');
      break;
    case 'error':
      print('Error: ${result['message']}');
      break;
    case 'exception':
      print('Exception: ${result['message']}');
      break;
    default:
      print('Unknown status: ${result['status']}');
  }
}