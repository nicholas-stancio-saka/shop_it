import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_it/features/home/presentation/widgets/top_bart.dart';
import 'package:shop_it/features/product_list/presentation/views/product_list.dart';
import 'package:shop_it/features/shared/widgets/page.dart';
import 'package:shop_it/features/home/presentation/controllers/home_controller.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final HomeController homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return AppPage(
      body: Column(
        children: [
          HomeTopBar(homeController),
          Expanded(
            child: ProductListScreen(),
          ),
        ],
      ),
    );
  }
}
