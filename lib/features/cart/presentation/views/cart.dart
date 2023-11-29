import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shop_it/features/cart/presentation/controllers/cart_controller.dart';
import 'package:shop_it/features/cart/presentation/widgets/cart_item.dart';
import 'package:shop_it/features/shared/entities/view_state.dart';
import 'package:shop_it/features/shared/widgets/button.dart';
import 'package:shop_it/features/shared/widgets/page.dart';

class CartScreen extends StatelessWidget {
  CartScreen({super.key});

  final CartController cartController = Get.find();

  @override
  Widget build(BuildContext context) {
    return AppPage(
      title: 'Shopping Cart',
      actions: [
        GestureDetector(
          onTap: () => cartController.clearCart(),
          child: const SizedBox(
            width: 22,
            height: 22,
            child: Icon(Icons.delete_outlined),
          ),
        ),
      ],
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(child: _buildCartContent()),
                Container(
                  height: 120, // Space for bottom bar
                ),
              ],
            ),
            _buildBottomBar(),
          ],
        ),
      ),
    );
  }

  Widget _buildCartContent() {
    return Obx(() {
      if (cartController.viewState.value.state == ViewState.loading) {
        return Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              color: Colors.grey[300]!,
            ));

        // TODO: Do better shimmer
      } else if (cartController.viewState.value.state == ViewState.failed) {
        return Container();
      }

      return ListView.builder(
        itemCount: cartController.cartItemList.length,
        itemBuilder: (context, index) {
          final cartItem = cartController.cartItemList[index];

          return SizedBox(
            height: 150,
            child: CartItemCard(
              cartItem: cartItem,
              handleOnAdd: () => cartController.handleOnAdd(cartItem),
              handleOnDelete: () => cartController.handleOnDelete(cartItem),
              handleOnRemove: () => cartController.handleOnRemove(cartItem),
            ),
          );
        },
      );
    });
  }

  Widget _buildBottomBar() {
    return Obx(
      () => Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            children: [
              Text(
                'Total ${cartController.cartItemList.length} Items',
                style: Theme.of(Get.context!).textTheme.bodyMedium!.copyWith(
                      color: Colors.black54,
                      fontWeight: FontWeight.w500,
                    ),
              ),
              const Spacer(),
              Text(
                'USD ${cartController.totalPrice.value}',
                style: Theme.of(Get.context!).textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
          Container(
            height: 10,
          ),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: AppButton(
              padding: null,
              onTap: () {
                // TODO: Show checkout dialog
              },
              child: const Row(
                children: [
                  Text(
                    'Proceed To Checkout',
                  ),
                  Spacer(),
                  Icon(Icons.arrow_forward_rounded)
                ],
              ),
            ),
          ),
          Container(
            height: 20,
          ),
        ],
      ),
    );
  }
}
