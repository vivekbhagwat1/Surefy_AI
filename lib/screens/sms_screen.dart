import 'package:flutter/material.dart';
import 'package:telephony/telephony.dart';

class SmsScreen extends StatefulWidget {
  @override
  _SmsScreenState createState() => _SmsScreenState();
}

class _SmsScreenState extends State<SmsScreen> {
  final Telephony telephony = Telephony.instance;
  List<SmsMessage> messages = [];

  @override
  void initState() {
    super.initState();
    _fetchSms();
  }

  void _fetchSms() async {
    List<SmsMessage> smsList = await telephony.getInboxSms();
    setState(() => messages = smsList);
  }

  @override
  Widget build(BuildContext context) {
    return messages.isEmpty
        ? Center(child: CircularProgressIndicator())
        : ListView.builder(
            itemCount: messages.length,
            itemBuilder: (context, index) {
              final sms = messages[index];
              return ListTile(
                title: Text(sms.address ?? "Unknown"),
                subtitle: Text(sms.body ?? "No Content"),
              );
            },
          );
  }
}
