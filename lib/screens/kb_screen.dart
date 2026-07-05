import 'package:flutter/material.dart';
import '../data/dummy_data.dart';

class KbScreen extends StatelessWidget {
  const KbScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Knowledge Base Library")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: "Search documented engineering solutions...",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
            const SizedBox(height: 24),
            Text("Hot Resources", style: theme.textTheme.titleLarge),
            const SizedBox(height: 12),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: DummyData.kbArticles.length,
              itemBuilder: (context, index) {
                final article = DummyData.kbArticles[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ExpansionTile(
                    title: Text(article.title),
                    subtitle: Text(article.category, style: TextStyle(color: theme.colorScheme.primary, fontSize: 12)),
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(article.summary, style: const TextStyle(fontStyle: FontStyle.italic)),
                            const SizedBox(height: 12),
                            Text(article.content),
                            const SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Views: ${article.views}"),
                                Text("Helpful Score: ${article.helpfulCount}"),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}