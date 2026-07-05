import 'package:flutter/material.dart';
import '../data/dummy_data.dart';
import '../models/team_member.dart';

class TeamScreen extends StatelessWidget {
  const TeamScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Active Operations Engineers")),
      body: GridView.builder(
        padding: const EdgeInsets.all(24.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: MediaQuery.of(context).size.width < 700 ? 1 : (MediaQuery.of(context).size.width < 1200 ? 2 : 3),
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 1.4,
        ),
        itemCount: DummyData.teamMembers.length,
        itemBuilder: (context, index) {
          final member = DummyData.teamMembers[index];

          Color statusColor;
          switch (member.status) {
            case EngineerStatus.online:
              statusColor = Colors.green;
              break;
            case EngineerStatus.busy:
              statusColor = Colors.orange;
              break;
            case EngineerStatus.offline:
              statusColor = Colors.grey;
              break;
          }

          return Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(member.imageUrl),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(member.name, style: theme.textTheme.titleLarge),
                            Text(member.role, style: theme.textTheme.bodyMedium),
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(color: statusColor, shape: BoxShape.circle),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        member.status.name.toUpperCase(),
                        style: TextStyle(color: statusColor, fontWeight: FontWeight.bold, fontSize: 12),
                      ),
                      const Spacer(),
                      Text("${member.activeTicketsCount} active logs", style: theme.textTheme.bodyMedium),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: member.skills.map((skill) {
                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primaryContainer.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(skill, style: const TextStyle(fontSize: 11)),
                      );
                    }).toList(),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}