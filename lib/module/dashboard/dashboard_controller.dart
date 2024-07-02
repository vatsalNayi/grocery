import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_app/module/cart/cart_page.dart';
import 'package:grocery_app/module/categories/category_page.dart';
import 'package:grocery_app/module/home/home_page.dart';
import 'package:grocery_app/module/more/more_page.dart';
import 'package:grocery_app/module/wishlist/wishlist_page.dart';

class DashboardController extends GetxController {
  RxInt selectedIndex = 0.obs;

  onItemTapped(int index) {
    selectedIndex.value = index;
  }

  RxList<Widget> pages = [
    const HomePage(),
    const CartPage(
      fromNav: true,
    ),
    const WishListPage(),
    const CategoriesPage(),
    const MorePage(),
  ].obs;
}
