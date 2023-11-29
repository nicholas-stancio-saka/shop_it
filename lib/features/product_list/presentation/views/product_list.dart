import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shop_it/features/product_list/domain/entities/category.dart';
import 'package:shop_it/features/product_list/presentation/controllers/product_list_controller.dart';
import 'package:shop_it/features/product_list/presentation/widgets/category_row.dart';
import 'package:shop_it/features/product_list/presentation/widgets/product_card.dart';
import 'package:shop_it/features/shared/entities/view_state.dart';
import 'package:shop_it/features/shared/widgets/error_page.dart';

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
          _buildTitleBar('John'), // TODO: Use the local storage name, defaults to 'Guest'
          Container(
            height: 20,
          ),
          Obx(() {
            if (productListController.viewStateCategory.value.state == ViewState.loading) {
              return Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    height: 40,
                    width: double.infinity,
                    color: Colors.grey[300]!,
                  ));

              // TODO: Do better shimmer
            } else if (productListController.viewStateCategory.value.state == ViewState.failed) {
              return Container();
            }

            return CategoryRow(
              categories: productListController.categoryList,
              onCategoryTap: (Category category) {
                productListController.updateCategory(category);
              },
            );
          }),
          Container(
            height: 20,
          ),
          Expanded(
            child: Obx(() {
              if (productListController.viewStateProducts.value.state == ViewState.loading) {
                return Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: GridView.builder(
                      padding: const EdgeInsets.all(4.0),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 4.0,
                        mainAxisSpacing: 4.0,
                        childAspectRatio: 0.6,
                      ),
                      itemCount: 6,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          color: Colors.grey[300]!,
                        );
                      },
                    ));

                // TODO: Do better shimmer
              } else if (productListController.viewStateProducts.value.state == ViewState.failed) {
                return AppErrorPage(
                  message: productListController.viewStateProducts.value.message,
                  callback: productListController.viewStateProducts.value.callback,
                );
              }

              return GridView.builder(
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
                  );
                },
              );
            }),
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
