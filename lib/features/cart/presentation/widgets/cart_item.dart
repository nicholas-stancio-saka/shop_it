import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_it/features/cart/domain/entities/cart_item.dart';

class CartItemCard extends StatelessWidget {
  final CartItem cartItem;
  final void Function()? handleOnRemove;
  final void Function()? handleOnAdd;
  final void Function()? handleOnDelete;

  const CartItemCard({
    required this.cartItem,
    this.handleOnRemove,
    this.handleOnAdd,
    this.handleOnDelete,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 1.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5.0),
        child: Container(
          color: Colors.white,
          child: _buildMainCardContent(),
        ),
      ),
    );
  }

  Widget _buildMainCardContent() {
    return LayoutBuilder(builder: (context, constraints) {
      final cardHeight = constraints.maxHeight;

      return Row(
        children: [
          SizedBox(
            width: cardHeight, // 1 : 1
            height: cardHeight, // 1 : 1
            child: _buildImage(),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _buildTitlePrice(maxLines: 2),
                  const Spacer(),
                  _buildBottomBar(),
                ],
              ),
            ),
          ),
        ],
      );
    });
  }

  Widget _buildImage() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Image.network(
        cartItem.imageUrl,
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
          cartItem.name,
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
          'USD ${cartItem.price.toStringAsFixed(2)}',
          style: Theme.of(Get.context!).textTheme.titleSmall!.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
      ],
    );
  }

  Widget _buildBottomBar() {
    return Row(
      children: [
        GestureDetector(
          onTap: handleOnRemove,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.black45),
            ),
            child: const Icon(Icons.remove),
          ),
        ),
        Container(
          width: 5,
        ),
        Container(
          width: 30,
          child: Center(
            child: Text(
              cartItem.qty.toString(),
              style: Theme.of(Get.context!).textTheme.titleMedium,
            ),
          ),
        ),
        Container(
          width: 5,
        ),
        GestureDetector(
          onTap: handleOnAdd,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.black45),
            ),
            child: const Icon(Icons.add),
          ),
        ),
        const Spacer(),
        GestureDetector(
          onTap: handleOnDelete,
          child: const Icon(Icons.delete_outlined),
        ),
      ],
    );
  }
}
