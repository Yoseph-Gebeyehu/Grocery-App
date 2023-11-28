import 'dart:convert';

class ApiResponse {
  int? status;
  dynamic body;
  String? checkoutUrl;

  ApiResponse({
    required this.status,
    this.body,
    this.checkoutUrl,
  });

  factory ApiResponse.fromResponse(dynamic response) {
    int code = response.statusCode;
    dynamic body;
    String checkoutUrl;

    try {
      body = jsonDecode(response.body);
      checkoutUrl = body['data']['checkout_url'];
    } catch (e) {
      body = null;
      checkoutUrl = '';
    }

    return ApiResponse(
      status: code,
      body: body,
      checkoutUrl: checkoutUrl,
    );
  }
}
