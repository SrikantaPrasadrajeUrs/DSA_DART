import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

/// Example URL endpoint
final Uri apiUrl = Uri.parse("https://jsonplaceholder.typicode.com/todos/1");

/// Entry point of the program
Future<void> main() async {
  print("🚀 Starting HTTP request demo...");

  // Execute GET request using http package
  await fetchDataWithHttpPackage();

  // Execute GET request using HttpClient
  await fetchDataWithHttpClient();

  print("🏁 Completed all HTTP operations.");
}

/// Fetches data using the `http` package.
/// Recommended for quick, high-level API calls.
Future<void> fetchDataWithHttpPackage() async {
  print("📡 Fetching data using 'http' package...");

  try {
    final response = await http.get(
      apiUrl,
      headers: {
        "Authorization": "Bearer dummy_token",
        "Accept": "application/json",
      },
    );

    if (response.statusCode == 200) {
      final decodedData = jsonDecode(response.body);
      print('✅ Success [http]: $decodedData');
    } else {
      print('❌ Failed [http]: Status ${response.statusCode}');
    }
  } catch (e) {
    print('🚨 Error [http]: $e');
  }
}

/// Fetches data using Dart's low-level `HttpClient`.
/// Suitable for advanced use cases (e.g., streaming, custom TLS, sockets).
Future<void> fetchDataWithHttpClient() async {
  print("\n-----------------------------");
  print("🔧 Fetching data using 'HttpClient'...");
  final HttpClient client = HttpClient();

  try {
    final HttpClientRequest request = await client.getUrl(apiUrl);
    request.headers
      ..set(HttpHeaders.acceptHeader, 'application/json')
      ..set(HttpHeaders.authorizationHeader, 'Bearer dummy_token');

    final HttpClientResponse response = await request.close();
    final String responseBody = await response.transform(utf8.decoder).join();

    if (response.statusCode == 200) {
      final decodedData = jsonDecode(responseBody);
      print('✅ Success [HttpClient]: $decodedData');
    } else {
      print('❌ Failed [HttpClient]: Status ${response.statusCode}');
      print('Response: $responseBody');
    }
  } catch (e) {
    print('🚨 Error [HttpClient]: $e');
  } finally {
    client.close();
  }
}
