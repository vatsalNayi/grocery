import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery_app/core/values/strings.dart';
import 'package:grocery_app/custom_widgets/item_quantity_widget.dart';
import 'package:grocery_app/custom_widgets/svg_icon.dart';
import 'package:grocery_app/models/cart_model.dart';
import '../../../core/values/colors.dart';
import '../cart_controller.dart';

class CartItem extends StatelessWidget {
  final CartController controller;
  final CartModel? cartData;
  final int cartIndex;
  const CartItem({
    super.key,
    required this.controller,
    this.cartData,
    required this.cartIndex,
  });

  String formatVariationText(String? variationText) {
    if (variationText == null || !variationText.contains('-')) {
      return '';
    }

    // Split the variationText on '-'
    List<String> parts = variationText.split('-');

    // Assuming the format is always color-size
    String color = parts[0].toUpperCase();
    String size = parts[1];

    return 'Color: $color & Size: $size';
  }

  @override
  Widget build(BuildContext context) {
    // log('${cartData!.productVariations![0].attributes![cartIndex]}');
    return ListTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.r),
      ),
      contentPadding: EdgeInsets.only(left: 5.w, right: 10.h),
      minLeadingWidth: 0.0,
      tileColor: AppColors.reddishOrange,
      leading: Container(
        width: 70.w,
        height: 70.h,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Image.network(
          '${cartData?.images?.first.src}',
          width: 52.w,
          height: 32.h,
        ),
      ),
      title: Text(
        '${cartData!.name}',
        style: GoogleFonts.poppins(
          fontSize: 15.sp,
          fontWeight: FontWeight.w400,
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Text(
          //   '3 KG (static)',
          //   // 'Size: '$cartData!.variationText?.toUpperCase()',
          //   // formatVariationText(
          //   //     '${cartData!.variationText?.toUpperCase()}'),
          //   style: GoogleFonts.poppins(
          //     fontSize: 15.sp,
          //     // color: AppColors.black.withOpacity(0.7),
          //     fontWeight: FontWeight.w400,
          //   ),
          // ),
          // Text(
          //   '12 Calories (static)',
          //   // '${cartData!.productVariations![cartIndex].attributes}',
          //   style: GoogleFonts.poppins(
          //     fontSize: 15.sp,
          //     fontWeight: FontWeight.w600,
          //   ),
          // ),
          Row(
            children: [
              Text(
                // '\$45.00',
                '₹${cartData?.prices?.regularPrice}',
                style: GoogleFonts.poppins(
                  decoration: TextDecoration.lineThrough,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(width: 5.w),
              Text(
                // '\$45.00',
                '₹${cartData?.prices?.salePrice}',
                style: GoogleFonts.poppins(
                  fontSize: 16.sp,
                  color: AppColors.lawnGreen,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              Get.find<CartController>().removeFromCart(cartIndex);
            },
            child: const SvgIcon(
              imagePath: ImagePath.deleteSvg,
            ),
          ),
          ItemQuantityWidget(
            isQtyBg: true,
            controller: controller,
            cartData: cartData,
          ),
        ],
      ),
    );
  }
}
