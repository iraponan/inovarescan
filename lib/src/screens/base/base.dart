import 'package:bottom_bar_matu/bottom_bar_matu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inovarescan/src/config/custom_colors.dart';
import 'package:inovarescan/src/controllers/navigation.dart';
import 'package:inovarescan/src/helpers/utils/consts.dart';
import 'package:inovarescan/src/screens/base/components/custom_bottom_bar_item.dart';
import 'package:inovarescan/src/screens/home/home.dart';

class BaseScreen extends StatelessWidget {
  const BaseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Color colorSelected = Colors.white;
    Color colorUnselected = Colors.white.withAlpha(100);

    return GetX<NavigationController>(builder: (navigationController) {
      return Scaffold(
        body: PageView(
          controller: navigationController.pageController,
          physics: NeverScrollableScrollPhysics(),
          children: [
            HomeScreen(),
            Container(
              color: Colors.yellow,
            ),
            Container(
              color: Colors.green,
            ),
            Container(
              color: Colors.blue,
            ),
          ],
        ),
        bottomNavigationBar: BottomBarDoubleBullet(
          backgroundColor: CustomColors.customSwathColor,
          selectedIndex: navigationController.currentIndex,
          items: [
            BottomBarItem(
              iconBuilder: (color) => CustomBottomBarItem(
                colorSelected: colorSelected,
                colorUnselected: colorUnselected,
                iconData: Icons.home_outlined,
                label: 'Home',
                isSelected: navigationController.currentIndex == NavigationTabs.home.index,
              ),
            ),
            BottomBarItem(
              iconBuilder: (color) => CustomBottomBarItem(
                colorSelected: colorSelected,
                colorUnselected: colorUnselected,
                iconData: Icons.shopping_cart_checkout_outlined,
                label: 'Pedidos',
                isSelected: navigationController.currentIndex == NavigationTabs.movements.index,
              ),
            ),
            BottomBarItem(
              iconBuilder: (color) => CustomBottomBarItem(
                colorSelected: colorSelected,
                colorUnselected: colorUnselected,
                iconData: Icons.inventory_2_outlined,
                label: 'Estoque',
                isSelected: navigationController.currentIndex == NavigationTabs.stock.index,
              ),
            ),
            BottomBarItem(
              iconBuilder: (color) => CustomBottomBarItem(
                colorSelected: colorSelected,
                colorUnselected: colorUnselected,
                iconData: Icons.person,
                label: 'Perfil',
                isSelected: navigationController.currentIndex == NavigationTabs.profile.index,
              ),
            ),
          ],
          onSelect: (page) => navigationController.navigatePageView(page: page),
        ),
      );
    });
  }
}
