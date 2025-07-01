import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_error_goalkeeper/main_screen.dart';
import 'dart:ui';

void main() {
  PlatformDispatcher.instance.onError = (error, stack) {
    print('PlatformDispatcher.instance.onError at root');
    return true;
  };
  runZonedGuarded(() {
    FlutterError.onError = (FlutterErrorDetails details) {
      print('FlutterError.onError at root');
    };

    runApp(const MyApp());
  }, (error, stack) {
    // This is the error handler for the Zone. Catches synchronous and
    // asynchronous errors within the Zone that were not caught by try-catch.
    print('runZonedGuarded at root');
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Items',
      home: MainScreen(),
    );
  }
}
