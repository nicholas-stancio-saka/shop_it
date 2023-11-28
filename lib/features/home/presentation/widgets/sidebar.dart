import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_it/features/home/presentation/controllers/home_controller.dart';
import 'package:shop_it/core/theme.dart';

class SideBar extends StatelessWidget {
  final HomeController homeController;

  const SideBar(this.homeController, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      color: AppTheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Image.asset(
              'assets/images/logo-prosper-redesign-short.png',
              scale: 2,
            ),
            Container(
              height: 20,
            ),
            const Divider(
              color: Color(0xFF50527D),
            ),
            Container(
              height: 20,
            ),
            _buildSideIcons(0, 'assets/images/icon-home.png'),
            Container(
              height: 20,
            ),
            _buildSideIcons(1, 'assets/images/icon-settings.png'),
            Container(
              height: 20,
            ),
            const Spacer(),
            _buildSideIcons(
              -1,
              'assets/images/icon-logout.png',
              onTap: () {
                homeController.logout();
              },
            ),
            Container(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  _buildSideIcons(int index, String imagePath, {void Function()? onTap}) {
    return GestureDetector(
      onTap: onTap ??
          () {
            homeController.tabIndex.value = index;
          },
      child: onTap != null
          ? SizedBox(
              width: 25,
              height: 25,
              child: Image.asset(imagePath),
            )
          : Obx(
              () => SizedBox(
                width: 25,
                height: 25,
                child: Image.asset(
                  imagePath,
                  color: homeController.tabIndex.value == index ? null : const Color(0xFF50527D),
                ),
              ),
            ),
    );
  }
}
