import 'package:flutter/material.dart';
import 'package:hestia/widgets/main_layout_widget.dart';

class CookiesPage extends StatelessWidget {
  const CookiesPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Example list of cookies
    final cookies = [
      {'name': 'Session Cookie', 'description': 'Used to maintain user sessions.', 'lifetime': 'Until browser is closed'},
      {'name': 'Authentication Cookie', 'description': 'Stores user authentication details.', 'lifetime': '1 hour'},
      {'name': 'Preference Cookie', 'description': 'Saves user preferences like theme or language.', 'lifetime': '1 year'},
    ];

    return MainLayoutWidget(
      title: 'Cookies Page',
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Sample Cookies',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            CookiesTable(cookies: cookies), // Pass the list of cookies here
          ],
        ),
      ),
    );
  }
}

class CookiesTable extends StatelessWidget {
  final List<Map<String, String>> cookies;

  const CookiesTable({super.key, required this.cookies});

  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder.all(),
      columnWidths: const {
        0: FlexColumnWidth(2),
        1: FlexColumnWidth(3),
        2: FlexColumnWidth(2),
      },
      children: [
        // Header row
        const TableRow(
          decoration: BoxDecoration(color: Colors.grey),
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Cookie Name',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Description',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Lifetime',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        // Data rows
        ...cookies.map((cookie) {
          return TableRow(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(cookie['name'] ?? ''),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(cookie['description'] ?? ''),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(cookie['lifetime'] ?? ''),
              ),
            ],
          );
        }).toList(),
      ],
    );
  }
}