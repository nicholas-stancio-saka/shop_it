import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_it/core/theme.dart';
import 'package:shop_it/features/product_list/domain/entities/product.dart';
import 'package:shop_it/features/shared/widgets/button.dart';
import 'package:shop_it/features/shared/widgets/page.dart';

class ProductDetail extends StatelessWidget {
  final Product product;

  const ProductDetail(this.product, {super.key});

  @override
  Widget build(BuildContext context) {
    return AppPage(
      title: '',
      actions: const [
        // TODO: To Cart
      ],
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 80.0), // Add Padding for button
            child: ListView(
              children: [
                _buildImage(),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: _buildContent(),
                ),
              ],
            ),
          ),
          _buildProceedButton(),
        ],
      ),
    );
  }

  Widget _buildImage() {
    return Image.network(product.imageUrl);
  }

  Widget _buildContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "USD ${product.price.toStringAsFixed(2)}",
              style: Theme.of(Get.context!).textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primary,
                  ),
            ),
            const Spacer(),
            Icon(
              Icons.favorite_border,
              color: AppTheme.primary,
            )
          ],
        ),
        const SizedBox(height: 8.0),
        Text(
          product.name,
          style: Theme.of(Get.context!).textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 8.0),
        _buildRatingReview(),
        const SizedBox(height: 16.0),
        Text(
          product.description,
          style: const TextStyle(fontSize: 16.0),
        ),
      ],
    );
  }

  Widget _buildRatingReview() {
    return Row(
      children: [
        const Icon(Icons.star, size: 22.0, color: Colors.amber),
        const SizedBox(width: 4.0),
        Text(
          product.rating.toString(),
          style: Theme.of(Get.context!).textTheme.bodyMedium!.copyWith(color: Colors.black54),
        ),
        const SizedBox(width: 18.0),
        Text(
          '${product.reviewCount} Reviews',
          style: Theme.of(Get.context!).textTheme.bodyMedium!.copyWith(color: Colors.black54),
        ),
      ],
    );
  }

  Widget _buildProceedButton() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.all(16),
        height: 50,
        child: AppButton(
          onTap: () {
            // TODO: To Cart
          },
          child: const Text(
            'Add To Cart',
          ),
        ),
      ),
    );
  }
}
