import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import '../screens/home_screen.dart';

Future<bool> requestPermissions() async {
  // Request required permissions
  Map<Permission, PermissionStatus> statuses = await [
    Permission.contacts,
    Permission.phone, // Covers phone state and call logs
  ].request();

  // Check if all permissions are granted
  if (statuses.values.every((status) => status.isGranted)) {
    return true;
  }

  // Handle permanently denied permissions
  for (var status in statuses.entries) {
    if (status.value.isPermanentlyDenied) {
      await openAppSettings();
      return false;
    }
  }

  return false;
}

void checkPermissions(BuildContext context) async {
  bool granted = await requestPermissions();
  if (granted) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()), // Replace with your home screen
    );
  } else {
    // Permissions denied; show a message
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("All permissions are required to proceed."),
        backgroundColor: Colors.red,
      ),
    );
  }
}
