import "dart:convert";

import 'package:grocery/data/models/api_request.dart';
import 'package:grocery/data/models/api_response.dart';
import "package:http/http.dart" as http;

class ApiClient {
  Future<ApiResponse> postData(
    ApiRequest apiRequest,
  ) async {
    String baseUrl = "https://api.chapa.co/v1/transaction/initialize";
    String key = "CHASECK_TEST-KzqTmzYnjSL5UDnlA7YuiAZY3OoeujYo";

    var request = json.encode(apiRequest);

    var headers = {
      "Authorization": "Bearer $key",
      "Content-Type": "application/json"
    };
    http.Response response = await http.post(
      Uri.parse(baseUrl),
      headers: headers,
      body: request,
    );

    return ApiResponse.fromResponse(response);
  }
}
