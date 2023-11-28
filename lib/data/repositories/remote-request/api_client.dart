import "dart:convert";

import 'package:grocery/data/models/api_request.dart';
import 'package:grocery/data/models/api_response.dart';
import 'package:grocery/data/models/products.dart';
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

  Future getProduct() async {
    String baseUrl = 'https://fakestoreapi.com/products';
    var url = Uri.parse(baseUrl);
    var response = await http.get(url);
    List<Products> products = [];

    if (response.statusCode == 200) {
      var responseBody = json.decode(response.body);
      for (var productData in responseBody) {
        Products product = Products.fromJson(productData);
        products.add(product);
      }
      return products;
    }
  }
}
