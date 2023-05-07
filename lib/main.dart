import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _hasPermissions = false;
  @override
  void initState() {
    super.initState();
    _fetchPermissionStatus();
  }

  void _fetchPermissionStatus() {
    Permission.locationWhenInUse.status.then(
      (status) {
        if (mounted) {
          setState(() {
            _hasPermissions = (status == PermissionStatus.granted);
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Builder(
          builder: (context) {
            if (_hasPermissions) {
              return _buildCompass();
            } else {
              return _buildCompass();
            }
          },
        ),
      ),
    );
  }

  ///  compass widget
  Widget _buildCompass() {
    return StreamBuilder<CompassEvent>(
      stream: FlutterCompass.events,
      builder: (context, snapshot) {
        // error msg
        if (snapshot.hasError) {
          return Text('Error reading heading: ${snapshot.error}');
        }
        // loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        double? direction = snapshot.data!.heading;

        //if
        if (direction == null) {
          return const Center(
            child: Text('Device does not have sensorss'),
          );
        }

        // return compass
        return Center(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Transform.rotate(
              angle: direction * (math.pi / 180) * -1,
              child: Image.asset(
                'lib/images/compass.png',
                // color: Colors.black,
              ),
            ),
          ),
        );
      },
    );
  }

  ///  permission widget

  // Widget _buildPermissionSheet() {
  //   return Center(
  //     child: ElevatedButton(
  //       child: const Text('Reuest permission'),
  //       onPressed: () {
  //         Permission.locationWhenInUse.request().then(
  //           (value) {
  //             _fetchPermissionStatus();
  //           },
  //         );
  //       },
  //     ),
  //   );
  // }
}
