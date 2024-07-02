import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery_app/core/values/colors.dart';
import 'package:grocery_app/core/values/strings.dart';
import 'package:grocery_app/custom_widgets/custom_button.dart';
import 'package:grocery_app/module/auth/controller/auth_controller.dart';
import 'package:grocery_app/routes/pages.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: 50.h),
                child: Image.asset(
                  ImagePath.welcomeBg,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 16.h,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(ImagePath.welcome),
                SizedBox(height: 40.h),
                SizedBox(
                  width: 200.w,
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: 'We Deliver Grocery at  ',
                      style: GoogleFonts.poppins(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.black,
                      ),
                      children: [
                        TextSpan(
                          text: 'Your Doorstep',
                          style: GoogleFonts.poppins(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.gradient1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 12.h),
                Text(
                  'Save time and shop smart with us!',
                  style: GoogleFonts.poppins(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.black.withOpacity(.7),
                  ),
                ),
                SizedBox(height: 48.h),
                GetBuilder<AuthController>(builder: (authController) {
                  return CustomButton(
                    height: 40.h,
                    width: 180.w,
                    onPress: () {
                      authController.setIsWelcomed(true);
                      debugPrint('${authController.getIsWelcomed()}');
                      Get.offAndToNamed(Routes.dashboardPage);
                    },
                    btnText: 'GET STARTED',
                    style: GoogleFonts.poppins(
                      fontSize: 16.sp,
                      color: AppColors.white,
                      fontWeight: FontWeight.w600,
                    ),
                    loading: false,
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
