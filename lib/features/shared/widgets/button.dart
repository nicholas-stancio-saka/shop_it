import 'package:flutter/material.dart';
import 'package:shop_it/core/theme.dart';

enum AppButtonType { fill, outline }

class AppButton extends StatelessWidget {
  final Widget child;
  final double height;
  final double? width;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry padding;
  final AppButtonType type;
  final double borderRadius;

  const AppButton({
    required this.child,
    this.height = 40.0,
    this.width,
    this.onTap,
    this.padding = const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
    this.type = AppButtonType.fill,
    this.borderRadius = 10.0,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(borderRadius),
    );

    return SizedBox(
      height: height,
      width: width,
      child: type == AppButtonType.fill
          ? ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: Theme.of(context).primaryColor, // Deprecated in later versions of Flutter. Use `backgroundColor` instead.
                shape: shape,
                padding: padding,
              ),
              onPressed: onTap,
              child: child,
            )
          : OutlinedButton(
              style: OutlinedButton.styleFrom(
                shape: shape,
                padding: padding,
                side: BorderSide(color: Theme.of(context).primaryColor),
              ),
              onPressed: onTap,
              child: child,
            ),
    );
  }
}

/// Jap's design
class AppButtonV2 extends StatelessWidget {
  final Widget child;
  final double height;
  final double? width;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry padding;
  final AppButtonType type;
  final double borderRadius;

  const AppButtonV2({
    required this.child,
    this.height = 40.0,
    this.width,
    this.onTap,
    this.padding = const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
    this.type = AppButtonType.fill,
    this.borderRadius = 10.0,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(borderRadius),
    );

    return SizedBox(
      height: height,
      width: width,
      child: type == AppButtonType.fill
          ? ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: Theme.of(context).primaryColor, // Deprecated in later versions of Flutter. Use `backgroundColor` instead.
                shape: shape,
                padding: padding,
              ),
              onPressed: onTap,
              child: child,
            )
          : OutlinedButton(
              style: OutlinedButton.styleFrom(
                shape: shape,
                padding: padding,
                side: BorderSide(color: Theme.of(context).primaryColor),
              ),
              onPressed: onTap,
              child: child,
            ),
    );
  }
}

/// A button with gradient. Note that this is self-made button, hence few functionalities might not exist
class AppGradientButton extends StatelessWidget {
  final Widget child;
  final double height;
  final void Function()? onTap;
  final EdgeInsetsGeometry padding;
  final AppButtonType type;
  final Color? textColor;
  final Color? fillColor;
  final List<Color>? gradientColors;
  final Color? outlineColor;
  final Widget? leading;
  final double? afterLeadingSpace;
  final double borderRadius;
  final double? borderWidth;

  const AppGradientButton({
    required this.child,
    this.height = 40.0,
    this.onTap,
    this.padding = const EdgeInsets.symmetric(vertical: 5, horizontal: 14),
    this.type = AppButtonType.fill,
    this.textColor = Colors.white,
    this.fillColor,
    this.gradientColors,
    this.outlineColor,
    this.leading,
    this.afterLeadingSpace,
    this.borderRadius = 5.0,
    this.borderWidth,
    super.key,
  })  : assert(type == AppButtonType.fill || gradientColors == null, 'Gradient colors should only be specified for filled buttons.'),
        assert(gradientColors == null || gradientColors.length == 2, 'Provide exactly 2 colors for the gradient.');

  @override
  Widget build(BuildContext context) {
    BoxDecoration decoration;

    if (type == AppButtonType.fill) {
      decoration = BoxDecoration(
        color: gradientColors == null ? (fillColor ?? AppTheme.primary) : null,
        gradient: gradientColors != null
            ? LinearGradient(
                colors: gradientColors!,
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              )
            : null,
        border: Border.all(
          color: outlineColor ?? AppTheme.primary,
          width: borderWidth ?? 1.0,
        ),
        borderRadius: BorderRadius.circular(borderRadius),
      );
    } else {
      decoration = BoxDecoration(
        border: Border.all(
          color: outlineColor ?? AppTheme.primary,
          width: borderWidth ?? 1.0,
        ),
        borderRadius: BorderRadius.circular(borderRadius),
      );
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        padding: padding,
        decoration: decoration,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (leading != null) leading!,
            if (leading != null) SizedBox(width: afterLeadingSpace ?? 10),
            DefaultTextStyle(
              style: TextStyle(color: type == AppButtonType.fill ? textColor : outlineColor),
              child: child,
            )
          ],
        ),
      ),
    );
  }
}
