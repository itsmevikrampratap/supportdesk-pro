import 'package:flutter/material.dart';
import '../data/dummy_data.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Alert Notifications Hub")),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: DummyData.notifications.length,
        itemBuilder: (context, idx) {
          final n = DummyData.notifications[idx];
          return Card(
            child: ListTile(
              leading: Icon(
                n['priority'] == 'high' ? Icons.warning : Icons.info,
                color: n['priority'] == 'high' ? Colors.red : Colors.blue,
              ),
              title: Text(n['title'] as String),
              subtitle: Text(n['body'] as String),
              trailing: Text(n['time'] as String),
            ),
          );
        },
      ),
    );
  }
}