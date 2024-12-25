import 'package:flutter/material.dart';
import 'package:surefy_fy/utils/permissions_helper.dart';

class PermissionsScreen extends StatelessWidget {
  const PermissionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/access_contact.png', // Replace with your image path
              height: 200,
            ),
            const SizedBox(height: 20),
            const Text(
              "Access Your Call Logs",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            const Text(
              "We need access to your contacts and call logs to help you connect and manage your communication seamlessly.",
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                checkPermissions(context);
              },
              child: const Text("Allow Access"),
            ),
            const SizedBox(height: 20),
            const Text(
              "All permissions are required to proceed.",
              style: TextStyle(color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
