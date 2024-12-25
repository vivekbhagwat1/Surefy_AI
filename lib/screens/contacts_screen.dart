import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:collection/collection.dart';

class ContactsScreen extends StatefulWidget {
  @override
  _ContactsScreenState createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  List<Contact> contacts = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchContacts();
  }

  Future<void> fetchContacts() async {
  if (await FlutterContacts.requestPermission()) {
    try {
      List<Contact> fetchedContacts =
          await FlutterContacts.getContacts(withProperties: true);

      print("Fetched contacts: ${fetchedContacts.length}");

      setState(() {
        contacts = fetchedContacts.where((c) => c.phones.isNotEmpty).toList();
        print("Contacts with phone numbers: ${contacts.length}");
        isLoading = false;
      });
    } catch (e) {
      print("Error fetching contacts: $e");
      setState(() {
        isLoading = false;
      });
    }
  } else {
    print("Permission denied by user");
    setState(() {
      isLoading = false;
    });

    // Show an explanation to the user
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Contacts permission is required to fetch contacts.'),
      ),
    );
  }
}


  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (contacts.isEmpty) {
      return const Scaffold(
        body: Center(child: Text("No contacts available")),
      );
    }

    // Group contacts alphabetically by their first letter
    Map<String, List<Contact>> groupedContacts =
        groupBy(contacts, (Contact c) => c.displayName.isNotEmpty
            ? c.displayName[0].toUpperCase()
            : '#'); // Fallback for no display name

    return Scaffold(
      appBar: AppBar(
        title: const Text("Contacts"),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.notifications)),
        ],
      ),
      body: ListView(
        children: groupedContacts.entries.map((entry) {
          String letter = entry.key;
          List<Contact> group = entry.value;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  letter,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              ...group.map((contact) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.blueAccent,
                    child: Text(contact.displayName.isNotEmpty
                        ? contact.displayName[0].toUpperCase()
                        : '#'), // Fallback for no display name
                  ),
                  title: Text(contact.displayName.isNotEmpty
                      ? contact.displayName
                      : 'Unnamed Contact'),
                  subtitle: Text(contact.phones.isNotEmpty
                      ? contact.phones.first.number
                      : "No number available"),
                );
              }).toList(),
            ],
          );
        }).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add desired FAB action
        },
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1, // Set to the Contacts tab
        onTap: (index) {
          // Navigate to the selected tab
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.call), label: 'Calls'),
          BottomNavigationBarItem(icon: Icon(Icons.contacts), label: 'Contacts'),
          BottomNavigationBarItem(icon: Icon(Icons.dialpad), label: 'Dialpad'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
