import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery_app/core/values/colors.dart';
import 'package:grocery_app/core/values/strings.dart';
import 'package:grocery_app/custom_widgets/svg_icon.dart';
import 'package:grocery_app/models/product_model.dart';
import 'package:grocery_app/module/wishlist/controller/wish_controller.dart';
import 'package:grocery_app/routes/pages.dart';

class WishedItems extends StatelessWidget {
  final ProductModel productData;
  final int index;
  const WishedItems({
    Key? key,
    required this.productData,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WishListController>(builder: (wishListController) {
      return wishListController.wishProductList != null
          ? wishListController.wishProductList!.isNotEmpty
              ? GestureDetector(
                  onTap: () {
                    Get.toNamed(
                      Routes.getProductDetailsRoute(
                        productData.id!,
                        '',
                        false,
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: index % 2 == 0 || index % 3 == 0
                          ? AppColors.seaPink.withOpacity(0.15)
                          : AppColors.hitPink.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.network(
                                '${productData.images!.first.src}',
                                height: 100.h,
                                width: 100.w,
                              ),
                              Text(
                                '${productData.name}',
                                style: GoogleFonts.poppins(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                // '\$60.00',
                                '₹${productData.price}',
                                style: GoogleFonts.poppins(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          top: 9.w,
                          right: 9.w,
                          child: GestureDetector(
                            onTap: () {
                              Get.find<WishListController>()
                                  .removeProductWishlist(index);
                            },
                            child: Container(
                              height: 36.h,
                              width: 36.w,
                              decoration: const BoxDecoration(
                                color: AppColors.white,
                                shape: BoxShape.circle,
                              ),
                              child: const SvgIcon(
                                imagePath: ImagePath.heart,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : const Center(
                  child: Text('Your Wishlist is empty'),
                )
          : const Center(
              child: CupertinoActivityIndicator(),
            );
    });
  }
}
