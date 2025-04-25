import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hestia/presentation/widgets/main_layout_widget.dart';

class CookiesPage extends StatelessWidget {
  const CookiesPage({super.key});

  Future<Map<String, String>> _loadIntroduction(BuildContext context) async {
    final String jsonString = await DefaultAssetBundle.of(context).loadString('assets/cookies_info.json');
    final Map<String, dynamic> jsonData = json.decode(jsonString);
    return {
      'title': jsonData['introduction']['title'] as String,
      'content': jsonData['introduction']['content'] as String,
    };
  }

  Future<List<Map<String, String>>> _loadCookies(BuildContext context) async {
    final String jsonString = await DefaultAssetBundle.of(context).loadString('assets/cookies.json');
    final List<dynamic> jsonData = json.decode(jsonString);
    return jsonData.map((item) => {
          'name': item['name'] as String,
          'description': item['description'] as String,
          'lifetime': item['lifetime'] as String,
        }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return MainLayoutWidget(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<Map<String, String>>(
          future: _loadIntroduction(context),
          builder: (context, introSnapshot) {
            if (introSnapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (introSnapshot.hasError) {
              return const Center(child: Text('Failed to load introduction.'));
            } else if (!introSnapshot.hasData) {
              return const Center(child: Text('No introduction data available.'));
            }

            final introduction = introSnapshot.data!;
            return FutureBuilder<List<Map<String, String>>>(
              future: _loadCookies(context),
              builder: (context, cookiesSnapshot) {
                if (cookiesSnapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (cookiesSnapshot.hasError) {
                  return const Center(child: Text('Failed to load cookies.'));
                } else if (!cookiesSnapshot.hasData || cookiesSnapshot.data!.isEmpty) {
                  return const Center(child: Text('No cookies data available.'));
                }

                final cookies = cookiesSnapshot.data!;
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        introduction['title']!,
                        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        introduction['content']!,
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Sample Cookies',
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16),
                      CookiesTable(cookies: cookies), // Pass the loaded cookies here
                    ],
                  ),
                );
              },
            );
          },
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