import 'package:flutter/material.dart';

class AppCard extends StatelessWidget {
  final Widget child;
  final Color backgroundColor;
  final List<Color>? gradientColors;
  final EdgeInsetsGeometry? padding;
  final BorderRadiusGeometry? borderRadius;

  const AppCard({
    super.key,
    required this.child,
    this.backgroundColor = Colors.white,
    this.gradientColors,
    this.padding,
    this.borderRadius,
  }) : assert(gradientColors == null || gradientColors.length == 2, 'Provide exactly 2 colors for the gradient.');

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: borderRadius ?? BorderRadius.circular(10.0),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1E6F8CA6),
            blurRadius: 9.0,
            offset: Offset(0, 5.42),
          ),
        ],
        color: gradientColors == null ? backgroundColor : null,
        gradient: gradientColors != null
            ? LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: gradientColors!,
              )
            : null,
      ),
      child: child,
    );
  }
}
