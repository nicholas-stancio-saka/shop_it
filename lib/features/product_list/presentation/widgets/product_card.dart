import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_it/features/product_list/domain/entities/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final void Function()? onTap;
  final bool isAlternate;

  const ProductCard({
    required this.product,
    this.onTap,
    this.isAlternate = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: Colors.white,
        elevation: 1.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: Container(
            color: Colors.white,
            child: !isAlternate ? _buildMainCardContent(context) : _buildAlternateCardContent(),
          ),
        ),
      ),
    );
  }

  Widget _buildMainCardContent(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final cardWidth = constraints.maxWidth;

        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: cardWidth,
              height: cardWidth * 0.9, // 90 % of width
              child: _buildImage(),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTitlePrice(),
                    const Spacer(),
                    _buildRatingReview(),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildAlternateCardContent() {
    return Row(
      children: [
        _buildImage(),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _buildTitlePrice(maxLines: 2),
                const Spacer(),
                _buildRatingReview(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildImage() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Image.network(
        product.imageUrl,
        fit: BoxFit.contain,
      ),
    );
  }

  Widget _buildTitlePrice({int? maxLines}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          product.name,
          style: Theme.of(Get.context!).textTheme.titleSmall!.copyWith(
                fontWeight: FontWeight.bold,
              ),
          maxLines: maxLines ?? 3,
          overflow: TextOverflow.ellipsis,
        ),
        Container(
          height: 5,
        ),
        Text(
          'USD ${product.price.toStringAsFixed(2)}',
          style: Theme.of(Get.context!).textTheme.titleSmall!.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
      ],
    );
  }

  Widget _buildRatingReview() {
    return Row(
      children: [
        const Icon(Icons.star, size: 16.0, color: Colors.amber),
        const SizedBox(width: 4.0),
        Text(
          product.rating.toString(),
          style: Theme.of(Get.context!).textTheme.bodySmall,
        ),
        const SizedBox(width: 4.0),
        Text(
          '${product.reviewCount} Reviews',
          style: Theme.of(Get.context!).textTheme.bodySmall,
        ),
      ],
    );
  }
}
