import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_it/features/product_search/presentation/controllers/search_controller.dart';
import 'package:shop_it/features/shared/widgets/page.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});

  final ProductSearchController productSearchController = Get.find();

  @override
  Widget build(BuildContext context) {
    return AppPage(
      title: '',
      actions: [
        GestureDetector(
          onTap: () => productSearchController.toCart(),
          child: const SizedBox(
            width: 22,
            height: 22,
            child: Icon(Icons.shopping_cart_outlined),
          ),
        ),
      ],
      body: Container(),
    );
  }
}
