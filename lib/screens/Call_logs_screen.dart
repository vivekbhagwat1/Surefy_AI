import 'package:flutter/material.dart';
import 'package:call_log/call_log.dart';
import 'contacts_screen.dart';
import 'dialpad_screen.dart';
import 'messages_screen.dart';
import 'profile_screen.dart';
import 'reachout_screen.dart'; // Import Contact List Screen

class CallLogScreen extends StatefulWidget {
  @override
  _CallLogScreenState createState() => _CallLogScreenState();
}

class _CallLogScreenState extends State<CallLogScreen> {
  Iterable<CallLogEntry>? callLogs;
  Iterable<CallLogEntry>? filteredLogs;
  

  @override
  void initState() {
    super.initState();
    _fetchCallLogs();
  }

  Future<void> _fetchCallLogs() async {
    final Iterable<CallLogEntry> fetchedLogs = await CallLog.get();
    setState(() {
      callLogs = fetchedLogs;
      filteredLogs = fetchedLogs; // Initially show all call logs
    });
  }

  // Handle BottomNavigationBar taps
  int _currentIndex = 0;

  void _onBottomNavTapped(int index) {
    setState(() {
      _currentIndex = index;
    });

    switch (index) {
      case 0:
        // Stay on Call Log Screen
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => DialpadScreen()), // Navigate to Dialpad Screen
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => ReachoutScreen()), // Navigate to Reachouts screen
        );
        break;
      case 3:
    
        break;
    }
  }

  void _searchCallLogs(String query) {
    final filteredList = callLogs!.where((call) {
      final name = call.name?.toLowerCase() ?? "";
      final number = call.number?.toLowerCase() ?? "";
      final searchQuery = query.toLowerCase();
      return name.contains(searchQuery) || number.contains(searchQuery);
    }).toList();

    setState(() {
      filteredLogs = filteredList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset('assets/images/logo.png', height: 30), // Replace with your logo
            SizedBox(width: 10),
            Text('SUREFY.AI'),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
  context: context,
  delegate: CallLogSearchDelegate(callLogs),
);

            },
          ),
          IconButton(icon: Icon(Icons.notifications), onPressed: () {}),
        ],
      ),
      body: Column(
        children: [
          // Tabs for Calls, Contacts, Messages, and Favorites
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text("Calls", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => ContactsScreen()),
                    );
                  },
                  child: Text("Contacts", style: TextStyle(fontSize: 18)),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => MessagesScreen()),
                    );
                  },
                  child: Text("Messages", style: TextStyle(fontSize: 18)),
                ),
                Text("Favorites", style: TextStyle(fontSize: 18)),
              ],
            ),
          ),
          Divider(),
          // Call Logs List
          Expanded(
            child: filteredLogs == null
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: filteredLogs!.length,
                    itemBuilder: (context, index) {
                      final call = filteredLogs!.elementAt(index);
                      return ListTile(
  leading: CircleAvatar(
    child: Icon(
      call.callType == CallType.incoming
          ? Icons.call_received
          : call.callType == CallType.outgoing
              ? Icons.call_made
              : Icons.call_missed,
      color: Colors.white,
    ),
    backgroundColor: call.callType == CallType.missed
        ? Colors.red
        : Theme.of(context).primaryColor,
  ),
  title: Text(call.name ?? call.number ?? "Unknown"),
  subtitle: Text(
      "${call.callType.toString().split('.').last} • ${call.number ?? "Unknown"}",
  ),
  trailing: IconButton(
    icon: Icon(Icons.info_outline),
    onPressed: () {
      final currentCall = filteredLogs!.elementAt(index);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProfileScreen(
            name: currentCall.name ?? "Unknown",
            number: currentCall.number ?? "Unknown",
            callHistory: [
              {
                "type": currentCall.callType.toString(),
                "time": currentCall.timestamp?.toString() ?? "N/A",
              },
            ],
          ),
        ),
      );
    },
  ),
);

                    },
                  ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.contacts), label: "Connects"),
          BottomNavigationBarItem(icon: Icon(Icons.dialpad), label: "Dialpad"),
          BottomNavigationBarItem(icon: Icon(Icons.record_voice_over), label: "Reachouts"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
        currentIndex: _currentIndex,
        onTap: _onBottomNavTapped,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
      ),
    );
  }
}

class CallLogSearchDelegate extends SearchDelegate {
  final Iterable<CallLogEntry>? callLogs;

  CallLogSearchDelegate(this.callLogs);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
          showSuggestions(context); // Show suggestions when cleared
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final filteredList = callLogs?.where((call) {
      final name = call.name?.toLowerCase() ?? "";
      final number = call.number?.toLowerCase() ?? "";
      final searchQuery = query.toLowerCase();
      return name.contains(searchQuery) || number.contains(searchQuery);
    }).toList();

    if (filteredList == null || filteredList.isEmpty) {
      return Center(
        child: Text('No results found'),
      );
    }

    return ListView.builder(
      itemCount: filteredList.length,
      itemBuilder: (context, index) {
        final call = filteredList[index];
        return ListTile(
          leading: CircleAvatar(
            child: Icon(
              call.callType == CallType.incoming
                  ? Icons.call_received
                  : call.callType == CallType.outgoing
                      ? Icons.call_made
                      : Icons.call_missed,
              color: Colors.white,
            ),
            backgroundColor: call.callType == CallType.missed
                ? Colors.red
                : Theme.of(context).primaryColor,
          ),
          title: Text(call.name ?? call.number ?? "Unknown"),
          subtitle: Text(
            "${call.callType.toString().split('.').last} • ${call.formattedNumber}",
          ),
          trailing: Icon(Icons.info_outline),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return buildResults(context); // Show filtered results as suggestions
  }
}
