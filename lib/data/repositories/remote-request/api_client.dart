import "dart:convert";
import "package:http/http.dart" as http;

import '/data/models/api_request.dart';
import '/data/models/api_response.dart';

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

  Future<ApiResponse> getProduct() async {
    String baseUrl = 'https://fakestoreapi.com/products';
    var url = Uri.parse(baseUrl);
    var response = await http.get(url);
    return ApiResponse.fromResponse(response);
  }

  Future<ApiResponse> getVerify(String txnRef) async {
    String baseUrl = 'https://api.chapa.co/v1/transaction/verify/$txnRef';
    String key = "CHASECK_TEST-KzqTmzYnjSL5UDnlA7YuiAZY3OoeujYo";

    var headers = {
      "Authorization": "Bearer $key",
      "Content-Type": "application/json"
    };

    var url = Uri.parse(baseUrl);
    var response = await http.get(url, headers: headers);

    return ApiResponse.fromResponse(response);
  }
}
