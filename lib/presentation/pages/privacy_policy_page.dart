import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hestia/presentation/widgets/main_layout_widget.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  Future<List<Map<String, String>>> _loadPrivacyPolicy(BuildContext context) async {
    final String jsonString = await DefaultAssetBundle.of(context).loadString('assets/privacy_policy.json');
    final List<dynamic> jsonData = json.decode(jsonString);
    return jsonData.map((item) => {
          'question': item['question'] as String,
          'answer': item['answer'] as String,
        }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return MainLayoutWidget(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Fixed left-side content
            SizedBox(
              width: 300, // Fixed width for the left section
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Frequently Asked Questions',
                    style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16), // Spacing between the two sections
            // Scrollable right-side content
            Expanded(
              child: FutureBuilder<List<Map<String, String>>>(
                future: _loadPrivacyPolicy(context),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return const Center(child: Text('Failed to load privacy policy.'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No privacy policy data available.'));
                  }

                  final List<Map<String, String>> privacyPolicy = snapshot.data!;
                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: privacyPolicy.map((item) {
                        return ExpansionTile(
                          title: Text(item['question']!),
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(item['answer']!),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}