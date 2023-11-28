import 'package:flutter/material.dart';

enum DeviceType { pc, laptop, tablet, mobile } // Assumes semua potrait

/// Debug:
/// - Internal logging
/// - No External logging
/// - Debug ENV
///
/// Profile:
/// - Internal logging
/// - External logging
/// - Debug ENV
///
/// Release:
/// - No internal logging
/// - External logging
/// - Release ENV
enum AppType { debug, profile, release }

class AppConfig {
  static const toggleApiLog = true; // Use this to toggle api logging

  // Used for better debuging. Currently used for debug alerts
  static AppType appType = const String.fromEnvironment(
            'APP_TYPE',
            defaultValue: 'release',
          ) ==
          'release'
      ? AppType.release
      : const String.fromEnvironment(
                'APP_TYPE',
                defaultValue: 'release',
              ) ==
              'profile'
          ? AppType.profile
          : AppType.debug;

  static const baseUrl = String.fromEnvironment(
    'BASE_URL',
    defaultValue: 'https://fakestoreapi.com',
  );

  // NOTE: Case sensitive
  static bool enableLog = (const String.fromEnvironment('ENABLE_LOG', defaultValue: 'false') == 'true') ? true : false;

  // For API logging
  static bool enableApiLog = enableLog && toggleApiLog;

  // ----- Device Screen Management -----
  static Map<DeviceType, int> deviceWidthConfig = {
    DeviceType.pc: 1440, // All Functionalities, full column in table
    DeviceType.laptop: 1024, // All Functionalities, most column in table
    DeviceType.tablet: 768, // All Functionalities, half column in table
    DeviceType.mobile: 375, // Only view, few column in table
  };

  static DeviceType getDeviceType(double width) {
    if (width >= deviceWidthConfig[DeviceType.pc]!) {
      return DeviceType.pc;
    } else if (width >= deviceWidthConfig[DeviceType.laptop]!) {
      return DeviceType.laptop;
    } else if (width >= deviceWidthConfig[DeviceType.tablet]!) {
      return DeviceType.tablet;
    } else {
      return DeviceType.mobile;
    }
  }

  // ----- Global Loader -----
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}
