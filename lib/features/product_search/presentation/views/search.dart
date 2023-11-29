import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shop_it/features/product_list/presentation/widgets/product_card.dart';
import 'package:shop_it/features/product_search/presentation/controllers/search_controller.dart';
import 'package:shop_it/features/shared/entities/view_state.dart';
import 'package:shop_it/features/shared/widgets/page.dart';
import 'package:shop_it/features/shared/widgets/text.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});

  final ProductSearchController productSearchController = Get.find();

  @override
  Widget build(BuildContext context) {
    return AppPage(
      title: 'Search',
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Column(
          children: [
            _buildSearchBox(),
            Container(
              height: 20,
            ),
            Expanded(
              child: _buildSearchContent(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBox() {
    return AppTextField(
      controller: productSearchController.searchTextController,
      suffixIcon: GestureDetector(
        onTap: () => productSearchController.clear(),
        child: const Icon(Icons.close),
      ),
      onChanged: (value) => productSearchController.updateSearchText(value),
    );
  }

  Widget _buildSearchContent() {
    return Obx(() {
      if (productSearchController.viewState.value.state == ViewState.loading) {
        return Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              height: 40,
              width: double.infinity,
              color: Colors.grey[300]!,
            ));

        // TODO: Do better shimmer
      } else if (productSearchController.viewState.value.state == ViewState.failed) {
        return Container();
      }

      return ListView.builder(
        itemCount: productSearchController.productList.length,
        itemBuilder: (context, index) {
          return SizedBox(
            height: 150,
            child: ProductCard(
              product: productSearchController.productList[index],
              isAlternate: true,
            ),
          );
        },
      );
    });
  }
}
