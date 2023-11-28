import 'package:flutter/material.dart';
import 'package:shop_it/features/product_list/domain/entities/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final void Function()? onTap;

  const ProductCard({required this.product, this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    // Get the width of the card to set the image height
    double width = MediaQuery.of(context).size.width / 2;

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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: width,
                  height: width / 1.25,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(10.0)),
                    child: Image.network(
                      product.imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
                    child: Text(
                      product.name,
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'USD ${product.price.toStringAsFixed(2)}',
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 4.0),
                      Row(
                        children: [
                          const Icon(Icons.star, size: 16.0, color: Colors.amber),
                          const SizedBox(width: 4.0),
                          Text(
                            product.rating,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          const SizedBox(width: 4.0),
                          Text(
                            '${product.reviewCount} Reviews',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
