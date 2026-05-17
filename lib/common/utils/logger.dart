import 'dart:developer';
import 'package:flutter/foundation.dart';

class CustomLogger {
  CustomLogger._();

  static printKV(String key, dynamic v) {
    if (kDebugMode) {
      logPrint('$key: $v');
    }
  }

  static logPrint(dynamic s) {
    if (kDebugMode) {
      log(s);
    }
  }

  static printAll(msg) {
    msg.toString().split('\n').forEach(logPrint);
  }
}
