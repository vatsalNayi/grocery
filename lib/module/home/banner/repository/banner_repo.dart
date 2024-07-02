import 'package:get/get_connect/http/src/response/response.dart';
import 'package:grocery_app/core/utils/app_constants.dart';
import 'package:grocery_app/data/services/api_client.dart';

class BannerRepo {
  final ApiClient apiClient;
  BannerRepo({required this.apiClient});

  Future<Response> getBannerList() async {
    return await apiClient.getData(AppConstants.BANNER,
        apiVersion: WooApiVersion.noWooApi);
  }
}
