import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

// import 'dart:math' as math;
// import 'package:compassapp/neu_circle.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_compass/flutter_compass.dart';
// import 'package:permission_handler/permission_handler.dart';

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
    Permission.locationWhenInUse.status.then((status) {
      if (mounted) {
        setState(() {
          _hasPermissions = (status == PermissionStatus.granted);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: null
          // Builder(builder: (context) {
          //   if (_hasPermissions) {
          //     return _buildCompass;
          //   } else {
          //     return _buildPermissionSheet();
          //   }
          // },
          // ),
          ),
    );
  }

  ///  compass widget
  Widget _buildCompass() {
    return const Center(
      child: Text('Compass here'),
    );
  }

  ///  permission widget

  Widget _buildPermissionSheet() {
    return Center(
      child: ElevatedButton(
        child: const Text('Reuest permission'),
        onPressed: () {
          Permission.locationWhenInUse.request().then((value) {
            _fetchPermissionStatus();
          });
        },
      ),
    );
  }
}
