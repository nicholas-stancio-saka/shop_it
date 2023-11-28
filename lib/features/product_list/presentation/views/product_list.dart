import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_it/features/product_list/domain/entities/category.dart';
import 'package:shop_it/features/product_list/presentation/controllers/product_list_controller.dart';
import 'package:shop_it/features/product_list/presentation/widgets/category_row.dart';
import 'package:shop_it/features/product_list/presentation/widgets/product_card.dart';

class ProductListScreen extends StatelessWidget {
  ProductListScreen({super.key});

  final ProductListController productListController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
          ),
          _buildTitleBar('John'),
          Container(
            height: 20,
          ),
          CategoryRow(
            categories: productListController.categoryList,
            onCategoryTap: (Category value) {},
          ),
          Container(
            height: 20,
          ),
          Expanded(
            child: Obx(
              () => GridView.builder(
                padding: const EdgeInsets.all(4.0),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 4.0,
                  mainAxisSpacing: 4.0,
                  childAspectRatio: 0.6,
                ),
                itemCount: productListController.productList.length,
                itemBuilder: (BuildContext context, int index) {
                  return ProductCard(
                    product: productListController.productList[index],
                    onTap: () {
                      // TODO: Handle onTap
                      Get.toNamed('/product_detail', arguments: productListController.productList[index]);
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTitleBar(String userName) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Hi, $userName',
          style: Theme.of(Get.context!).textTheme.titleMedium,
        ),
        Text(
          'What are you looking for today?',
          style: Theme.of(Get.context!).textTheme.headlineMedium!.copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
