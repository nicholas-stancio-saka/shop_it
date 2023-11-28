import 'package:flutter/material.dart';

class SfDataGridClipper extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) {
    return Rect.fromLTRB(
      1, // Start clipping 1 pixel in from the left to remove the left border
      1, // Start clipping 1 pixel in from the top to remove the top border
      size.width,
      size.height - 1,
    );
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    return false;
  }
}
