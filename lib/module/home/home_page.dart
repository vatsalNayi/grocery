import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery_app/core/values/colors.dart';
import 'package:grocery_app/core/values/strings.dart';
import 'package:grocery_app/custom_widgets/custom_appbar.dart';
import 'package:grocery_app/custom_widgets/custom_textfield.dart';
import 'package:grocery_app/custom_widgets/svg_icon.dart';
import 'package:grocery_app/custom_widgets/textfield_decoration.dart';
import 'package:grocery_app/helper/product_type.dart';
import 'package:grocery_app/models/category_model.dart';
import 'package:grocery_app/module/categories/controller/category_controller.dart';
import 'package:grocery_app/module/home/banner/controller/banner_controller.dart';
import 'package:grocery_app/module/home/home_controller.dart';
import 'package:grocery_app/module/home/products/all_product_screen.dart';
import 'package:grocery_app/module/home/products/controller/product_controller.dart';
import 'package:grocery_app/module/home/widgets/grid_product.dart';
import '../../routes/pages.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    HomeController controller = Get.put(HomeController());
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Hi there!',
        leadingIcon: ImagePath.homeMenu,
        trailingIcon: ImagePath.notification,
        trailingColor: AppColors.iconColor,
        onTapTrailing: () {
          Get.toNamed(Routes.getNotificationRoute());
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.getSearchRoute());
                },
                child: customDecorationForTextfield(
                  child: CustomTextfield(
                    isEnabled: false,
                    hintText: 'Search for products',
                    hintStyle: GoogleFonts.poppins(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.gradient1,
                    ),
                    border: InputBorder.none,
                    prefixIcon: const SvgIcon(
                      imagePath: ImagePath.search,
                      color: AppColors.iconColor,
                    ),
                  ),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 17.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Categories',
                        style: GoogleFonts.poppins(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      GetBuilder<CategoryController>(
                          builder: (categoryController) {
                        final categoryList = categoryController.categoryList;
                        return GestureDetector(
                          onTap: () {
                            Get.toNamed(
                              Routes.getCategoryProductRoute(
                                categoryList![1],
                              ),
                            );
                          },
                          child: Text(
                            'See All',
                            style: GoogleFonts.poppins(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                ),
                SizedBox(height: 14.h),
                GetBuilder<CategoryController>(
                  builder: (categoryController) {
                    return
                        // categoryController.getCatLoading
                        //     ? const Center(
                        //         child: Padding(
                        //           padding: EdgeInsets.only(top: 10.0),
                        //           child: CupertinoActivityIndicator(),
                        //         ),
                        //       ) :
                        categoryController.categoryList != null &&
                                categoryController.categoryList!.isNotEmpty
                            ? SizedBox(
                                height: 300.h,
                                child: GridView.builder(
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 24.w),
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 8.w,
                                    mainAxisSpacing: 20.h,
                                    // childAspectRatio: 0.7, // Gridview's item's size
                                  ),
                                  itemCount:
                                      categoryController.categoryList!.length,
                                  itemBuilder: (context, index) {
                                    final categoryList =
                                        categoryController.categoryList![index];
                                    return GestureDetector(
                                      onTap: () {
                                        Get.toNamed(
                                          Routes.getCategoryProductRoute(
                                            categoryList,
                                          ),
                                        );
                                      },
                                      child: Container(
                                        color: AppColors.categoryBg,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image.network(
                                              categoryList.image!.src
                                                  .toString(),
                                              height: 80.h,
                                              width: 80.w,
                                            ),
                                            SizedBox(height: 20.h),
                                            Text(
                                              '${categoryList.name}',
                                              style: GoogleFonts.poppins(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              )
                            : const SizedBox();
                  },
                ),
                SizedBox(height: 17.h),
                GetBuilder<BannerController>(
                  builder: (bannerController) {
                    final bannerList = bannerController.bannerList;
                    return bannerController.getBannerLoading
                        ? const Center(
                            child: Padding(
                              padding: EdgeInsets.only(top: 12.0),
                              child: CupertinoActivityIndicator(),
                            ),
                          )
                        : bannerList.isEmpty
                            ? const SizedBox()
                            : SizedBox(
                                height: 170.h,
                                child: PageView.builder(
                                  itemCount: bannerList.length,
                                  onPageChanged: controller.onPageChanged,
                                  itemBuilder: (context, index) {
                                    final banner = bannerList[index];
                                    return GestureDetector(
                                      onTap: () {
                                        if (banner.resourceType == 'product' &&
                                            banner.product != null) {
                                          Get.toNamed(
                                              Routes.getProductDetailsRoute(
                                                  banner.product, null, false));
                                        } else if (banner.resourceType ==
                                                'category' &&
                                            banner.category != null) {
                                          Get.toNamed(
                                            Routes.getCategoryProductRoute(
                                              CategoryModel(
                                                  id: banner.category),
                                            ),
                                          );
                                        }
                                      },
                                      child: Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 24.w),
                                        // padding: EdgeInsets.symmetric(
                                        //   horizontal: 10.w,
                                        //   vertical: 20.h,
                                        // ),
                                        decoration: BoxDecoration(
                                          color: AppColors.categoryBg,
                                          borderRadius:
                                              BorderRadius.circular(25.r),
                                        ),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(25.r),
                                          child: Image.network(
                                            '${bannerList[index].image}',
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        // child: Image.network(
                                        //   '${bannerList[index].image}',
                                        //   // height: 99.h,
                                        //   // width: 183.w,
                                        //   fit: BoxFit.contain,
                                        // ),
                                      ),
                                    );
                                  },
                                ),
                              );
                  },
                ),
                const SizedBox(height: 20.0),
                GetBuilder<BannerController>(
                  builder: (bannerController) {
                    return buildIndicator(bannerController.bannerList);
                  },
                ),
                SizedBox(height: 40.h),

                /// Add Popular products if needed:
                // const PopularProductView(isPopular: true),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'For You',
                        style: GoogleFonts.poppins(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.to(() => const AllProductScreen(
                                productType: ProductType.LATEST_PRODUCT,
                                // productType: isPopular
                                //     ? ProductType.POPULAR_PRODUCT
                                //     : newArrival
                                //         ? ProductType.LATEST_PRODUCT
                                //         : ProductType.REVIEWED_PRODUCT,
                              ));
                        },
                        child: Row(
                          children: [
                            Text(
                              'View more',
                              style: GoogleFonts.poppins(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(
                              width: 2.w,
                            ),
                            const SvgIcon(
                              imagePath: ImagePath.doubleArrow,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 14.h,
                ),

                GetBuilder<ProductController>(
                  builder: (productController) {
                    final productList = productController.productList;
                    return productController.isLoading
                        ? const Center(child: CupertinoActivityIndicator())
                        : productController.productList != null
                            ? GridView.builder(
                                padding: EdgeInsets.symmetric(horizontal: 24.w),
                                itemCount: productList!.length,
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 16.w,
                                  mainAxisSpacing: 14.h,
                                  childAspectRatio:
                                      0.8, // Gridview's item's size
                                ),
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      Get.toNamed(Routes.getProductDetailsRoute(
                                        productList[index].id,
                                        null,
                                        false,
                                      ));
                                    },
                                    child: GridProducts(
                                      index: index,
                                      productList: productList[index],
                                    ),
                                  );
                                },
                              )
                            : const SizedBox();
                  },
                ),
                SizedBox(height: 40.h),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildIndicator(bannerList) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        for (int i = 0; i < bannerList.length; i++)
          GetBuilder<HomeController>(builder: (controller) {
            return Container(
              width: controller.getCurrentPage == i ? 16.r : 10.r,
              height: controller.getCurrentPage == i ? 16.r : 10.r,
              margin: EdgeInsets.symmetric(horizontal: 5.w),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: controller.getCurrentPage == i ? null : AppColors.bgGrey,
                gradient:
                    controller.getCurrentPage == i ? gradientTopToBottom : null,
              ),
            );
          }),
      ],
    );
  }
}
