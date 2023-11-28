import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_it/features/shared/widgets/page.dart';
import 'package:shop_it/core/config/config.dart';
import 'package:shop_it/features/home/presentation/controllers/home_controller.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final HomeController homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return AppPage(
      body: LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
        // Determine the device type based on the current width
        final DeviceType deviceType = AppConfig.getDeviceType(constraints.maxWidth);

        return Container();
      }),
    );
  }
}
