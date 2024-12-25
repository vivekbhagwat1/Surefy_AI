import 'package:flutter/material.dart';

class ReachoutScreen extends StatelessWidget {
  final List<Map<String, String>> actions = [
    {'name': 'Send Email', 'icon': 'email'},
    {'name': 'Schedule Call', 'icon': 'schedule'},
    {'name': 'Text Message', 'icon': 'sms'},
    {'name': 'Create Reminder', 'icon': 'reminder'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reachout'),
      ),
      body: ListView.builder(
        itemCount: actions.length,
        itemBuilder: (context, index) {
          final action = actions[index];
          return ListTile(
            leading: Icon(_getIcon(action['icon']!)),
            title: Text(action['name']!),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('${action['name']} clicked')),
              );
              // Add navigation or actions as needed
            },
          );
        },
      ),
    );
  }

  IconData _getIcon(String iconName) {
    switch (iconName) {
      case 'email':
        return Icons.email;
      case 'schedule':
        return Icons.schedule;
      case 'sms':
        return Icons.sms;
      case 'reminder':
        return Icons.notifications;
      default:
        return Icons.help_outline;
    }
  }
}
