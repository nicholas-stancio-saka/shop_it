import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

// NOTE: May need to use this for better information
class InitOverlay {
  void showOverlay() {
    EasyLoading.show(
      dismissOnTap: false,
      maskType: EasyLoadingMaskType.black,
      indicator: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircularProgressIndicator(),
            SizedBox(height: 20),
            Text('Initializing...', style: TextStyle(fontSize: 24)),
          ],
        ),
      ),
    );
  }

  void hideOverlay() {
    EasyLoading.dismiss();
  }
}
