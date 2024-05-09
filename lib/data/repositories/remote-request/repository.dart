import '/data/models/api_request.dart';
import '/data/models/api_response.dart';
import '/data/repositories/remote-request/api_client.dart';

class Repository {
  ApiClient apiClient = ApiClient();
  Future<ApiResponse> postData(
    ApiRequest apiRequest,
  ) async {
    return apiClient.postData(apiRequest);
  }

  Future<ApiResponse> getProducts() async {
    return apiClient.getProduct();
  }

  Future<ApiResponse> getVerify(String txnRef) async {
    return apiClient.getVerify(txnRef);
  }
}
