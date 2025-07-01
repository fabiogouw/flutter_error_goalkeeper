import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ErrorGoalkeeper extends StatefulWidget {
  const ErrorGoalkeeper({super.key, required this.child, required this.scope});

  final Widget child;
  final String scope;

  @override
  State<StatefulWidget> createState() {
    return _ErrorGoalkeeperState();
  }
}

class _ErrorGoalkeeperState extends State<ErrorGoalkeeper> {
  Zone? _zone;

  @override
  void initState() {
    super.initState();
    _zone = Zone.current.fork(
      zoneValues: { 'myKey': 'test' },
      specification: ZoneSpecification(
        handleUncaughtError: (Zone self, ZoneDelegate parent, Zone zone,
            Object error, StackTrace stackTrace) {
          // Custom error handling for this zone
          print('ZONE Caught error in custom zone: $error');
          //parent.handleUncaughtError(
          //    zone, error, stackTrace); // Delegate to parent or handle it
        },
        print: (Zone self, ZoneDelegate parent, Zone zone, String message) {
          // Custom print behavior for this zone
          print('ZONE PRINT: $message');
          parent.print(zone, message);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _zone != null
        ? _zone!.run(() {
            return widget.child;
          })
        : Container();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
