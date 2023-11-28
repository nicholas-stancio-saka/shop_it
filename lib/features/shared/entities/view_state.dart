import 'package:flutter/material.dart';

enum ViewState { loading, success, failed }

class ViewStateInfo {
  ViewState state;
  final String? message; // This can be used to display error messages for the Failed state
  final VoidCallback? callback; // Optional callback

  ViewStateInfo({required this.state, this.message, this.callback});
}
