import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_it/core/theme.dart';
import 'package:shop_it/features/product_list/domain/entities/category.dart';

class CategoryRow extends StatelessWidget {
  final List<Category> categories;
  final ValueChanged<Category> onCategoryTap;

  CategoryRow({super.key, required this.categories, required this.onCategoryTap});

  final CategoryController controller = Get.put(CategoryController());

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 40,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          itemBuilder: (BuildContext context, int index) {
            return Obx(() {
              final category = categories[index];
              final bool isSelected = controller.selectedIndex.value == index;

              return GestureDetector(
                onTap: () => controller.onCategorySelected(index, onCategoryTap, categories),
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: isSelected ? AppTheme.primary : Colors.transparent,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Text(
                    category.name,
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.black54,
                    ),
                  ),
                ),
              );
            });
          },
        ));
  }
}

class CategoryController extends GetxController {
  var selectedIndex = 0.obs;

  void onCategorySelected(int index, ValueChanged<Category> onCategoryTap, List<Category> categories) {
    selectedIndex.value = index;

    onCategoryTap(categories[index]); // Callback
  }
}
