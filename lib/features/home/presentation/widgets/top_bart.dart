import 'package:flutter/material.dart';
import 'package:shop_it/features/home/presentation/controllers/home_controller.dart';

class HomeTopBar extends StatelessWidget {
  final HomeController homeController;

  const HomeTopBar(this.homeController, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 20,
        ),
        _iconBox(
          onTap: () => homeController.logout(),
          child: const Icon(Icons.person_outlined),
        ),
        Container(
          width: 10,
        ),
        _iconBox(),
        const Spacer(),
        SizedBox(
          height: 40,
          child: Image.asset('assets/images/logo-text-2.png'),
        ),
        const Spacer(),
        _iconBox(child: const Icon(Icons.search_outlined)),
        Container(
          width: 10,
        ),
        _iconBox(child: const Icon(Icons.shopping_cart_outlined)),
        Container(
          width: 20,
        ),
      ],
    );
  }

  Widget _iconBox({Widget? child, void Function()? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 22,
        height: 22,
        child: child,
      ),
    );
  }
}
