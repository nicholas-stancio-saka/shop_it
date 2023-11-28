// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:developer';

import 'package:shop_it/core/config/config.dart';

/// Use this class for printing logs
class AppLogging {
  static simplePrint(Object? object) {
    if (AppConfig.enableLog) {
      print(object);
    }
  }

  static simpleLog(String message,
      {DateTime? time, int? sequenceNumber, int level = 0, String name = '', Zone? zone, Object? error, StackTrace? stackTrace}) {
    if (AppConfig.enableLog) {
      log(
        message,
        time: time,
        sequenceNumber: sequenceNumber,
        level: level,
        name: name,
        zone: zone,
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  static customLog(String page, String tag, String message,
      {DateTime? time, int? sequenceNumber, int level = 0, String name = '', Zone? zone, Object? error, StackTrace? stackTrace}) {
    if (AppConfig.enableLog) {
      log(
        '$page ($tag) --> $message',
        time: time,
        sequenceNumber: sequenceNumber,
        level: level,
        name: name,
        zone: zone,
        error: error,
        stackTrace: stackTrace,
      );
    }
  }
}
