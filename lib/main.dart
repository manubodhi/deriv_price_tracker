import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'app/app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  Future<void> reportError(dynamic error, dynamic stackTrace) async {
    // Print the exception to the console.

    if (kDebugMode) {
      // Print the full stacktrace in debug mode.
      // logError(error, stacktrace: stackTrace);
      print('[ERROR] Caught error: $error');
      print(stackTrace);
      return;
    } else {
      // Send the Exception and Stacktrace to crashlytics in Production mode.
      // FirebaseCrashlytics.instance.recordError(error, stackTrace);
    }
  }

  runZonedGuarded(() {
    runApp(const App());
  }, reportError);
}
