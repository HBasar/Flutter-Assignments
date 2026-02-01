import 'package:flutter/material.dart';

void main() {
  runApp(const Addcontact());
}

class Addcontact extends StatelessWidget {
  const Addcontact({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ContactListScreen(),
    );
  }
}

class ContactListScreen extends StatelessWidget {
  ContactListScreen({super.key});

  final List<Map<String, String>> contacts = [
    {'name': 'Jawad', 'number': '01877-777777'},
    {'name': 'Ferdous', 'number': '01673-777777'},
    {'name': 'Hasan', 'number': '01745-777777'},
    {'name': 'Hasan', 'number': '01745-777777'},
    {'name': 'Hasan', 'number': '01745-777777'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact List', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextFormField(
                  initialValue: "Hasan",
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                    hintText: "Name",
                  ),
                ),
                const SizedBox(height: 10),


                TextFormField(
                  initialValue: "01745-777777",
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                    hintText: "Number",
                  ),
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 10),


                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueGrey,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    child: const Text('Add'),
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: contacts.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  elevation: 1,
                  color: Colors.grey[50],
                  child: ListTile(
                    leading: const Icon(Icons.person, size: 40, color: Colors.brown),
                    title: Text(
                      contacts[index]['name']!,
                      style: const TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                      ),
                    ),
                    subtitle: Text(
                      contacts[index]['number']!,
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                    trailing: const Icon(Icons.phone, color: Colors.blue),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}