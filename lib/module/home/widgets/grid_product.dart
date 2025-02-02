import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery_app/core/values/colors.dart';
import 'package:grocery_app/models/product_model.dart';
import 'package:grocery_app/module/wishlist/controller/wish_controller.dart';

class GridProducts extends StatelessWidget {
  ProductModel productList;
  int index;
  GridProducts({
    super.key,
    required this.productList,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Container(
            color: AppColors.categoryBg,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(
                  '${productList.images?.first.src}',
                  fit: BoxFit.cover,
                  width: 100.w,
                  height: 100.h,
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 5.h,
                  ),
                  decoration: BoxDecoration(
                    gradient: gradientTopToBottom,
                    borderRadius: BorderRadius.circular(5.r),
                  ),
                  child: Text(
                    '1 KG',
                    style: GoogleFonts.poppins(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.white,
                    ),
                  ),
                ),
                SizedBox(height: 6.h),
                Text(
                  // 'Bell Pepper',
                  '${productList.name}',
                  style: GoogleFonts.poppins(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.black.withOpacity(.7),
                  ),
                ),
                Text(
                  // '\$47.00',
                  '₹${productList.price}',
                  style: GoogleFonts.poppins(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 8.h),
                // GetBuilder<ProductController>(builder: (productController) {
                //   return GestureDetector(
                //     onTap: () {
                //       // Get.find<CartController>().addToCart(
                //       //   productController.cartModel,
                //       //   index,
                //       // );
                //     },
                //     child: Text(
                //       'ADD TO CART',
                //       style: GoogleFonts.poppins(
                //         fontSize: 15.sp,
                //         fontWeight: FontWeight.w600,
                //         color: AppColors.black.withOpacity(.7),
                //       ),
                //     ),
                //   );
                // }),
              ],
            ),
          ),
        ),
        Positioned(
          top: 10.0,
          right: 10.0,
          child: GetBuilder<WishListController>(builder: (wishListController) {
            return GestureDetector(
              onTap: () {
                Get.find<WishListController>()
                    .addProductToWishlist(productList);
              },
              child: Icon(
                wishListController.wishIdList.contains(productList.id)
                    ? Icons.favorite
                    : Icons.favorite_border,
                color: wishListController.wishIdList.contains(productList.id)
                    ? AppColors.red
                    : Theme.of(context).hintColor,
              ),
            );
          }),
        ),
      ],
    );
  }
}
