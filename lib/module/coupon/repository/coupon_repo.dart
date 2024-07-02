import 'package:get/get_connect/http/src/response/response.dart';
import 'package:grocery_app/core/utils/app_constants.dart';
import 'package:grocery_app/data/services/api_client.dart';

class CouponRepo {
  final ApiClient apiClient;
  CouponRepo({required this.apiClient});

  Future<Response> getCouponList(int offset) async {
    return await apiClient
        .getData(AppConstants.COUPON_LIST_URI + offset.toString());
  }

  Future<Response> applyCoupon(String couponCode) async {
    return await apiClient
        .getData('${AppConstants.APPLY_COUPON_URI}$couponCode');
  }
}
