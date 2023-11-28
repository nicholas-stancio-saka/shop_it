import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_it/core/theme.dart';

class TitleChildWidget extends StatelessWidget {
  final String title;
  final double titleWidth;
  final Widget child;
  final double childWidth;
  final bool isError;
  final bool isChildFlexible;
  final MainAxisAlignment mainAxisAlignment;

  const TitleChildWidget({
    super.key,
    required this.title,
    required this.titleWidth,
    required this.child,
    required this.childWidth,
    this.isError = false,
    this.isChildFlexible = false,
    this.mainAxisAlignment = MainAxisAlignment.start,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      children: [
        SizedBox(
            width: titleWidth,
            child: Text(
              title,
              style: Theme.of(Get.context!).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w600),
            )),
        const Text(':'),
        Container(
          width: 10,
        ),
        isChildFlexible ? Flexible(child: child) : SizedBox(width: childWidth, child: child),
        if (isError) ...[
          Container(
            width: 10,
          ),
          Icon(
            Icons.error,
            color: AppTheme.error,
          ),
        ]
      ],
    );
  }
}
