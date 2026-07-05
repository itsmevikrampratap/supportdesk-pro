import 'package:flutter/material.dart';
import '../widgets/metric_card.dart';
import '../widgets/custom_charts.dart';
import '../data/dummy_data.dart';
import '../widgets/status_chip.dart';
import '../widgets/priority_badge.dart';
import 'ticket_details_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard Portal"),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {},
          ),
          const SizedBox(width: 12),
          const CircleAvatar(
            backgroundImage: NetworkImage("https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=150"),
            radius: 18,
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Welcome Back, Agent", style: textTheme.headlineMedium),
                    Text("Operational performance stats for today.", style: textTheme.bodyMedium),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24),
            LayoutBuilder(
              builder: (context, constraints) {
                int crossAxisCount = constraints.maxWidth < 600 ? 1 : (constraints.maxWidth < 1200 ? 2 : 4);
                return GridView.count(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  childAspectRatio: 1.6,
                  children: [
                    MetricCard(
                      title: "Total Service Tickets",
                      value: "154",
                      icon: Icons.confirmation_number_outlined,
                      color: theme.colorScheme.primary,
                      trend: "+12%",
                      isTrendPositive: true,
                    ),
                    const MetricCard(
                      title: "Open Incidents",
                      value: "28",
                      icon: Icons.hourglass_empty,
                      color: Colors.blue,
                      trend: "-4%",
                      isTrendPositive: false,
                    ),
                    const MetricCard(
                      title: "Resolved Today",
                      value: "41",
                      icon: Icons.check_circle_outline,
                      color: Colors.green,
                      trend: "+18%",
                      isTrendPositive: true,
                    ),
                    const MetricCard(
                      title: "Critical & Urgent Logs",
                      value: "6",
                      icon: Icons.error_outline,
                      color: Colors.red,
                      trend: "0%",
                      isTrendPositive: true,
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 24),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Expanded(flex: 3, child: TicketTrendChart()),
                const SizedBox(width: 16),
                if (MediaQuery.of(context).size.width > 900)
                  const Expanded(flex: 2, child: ResolutionDistributionChart()),
              ],
            ),
            const SizedBox(height: 24),
            Text("Recent Activity Tickets", style: textTheme.titleLarge),
            const SizedBox(height: 12),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 3,
              itemBuilder: (context, idx) {
                final ticket = DummyData.tickets[idx];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    title: Row(
                      children: [
                        Text(ticket.id, style: const TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(width: 12),
                        Expanded(child: Text(ticket.subject, overflow: TextOverflow.ellipsis)),
                      ],
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              ticket.customerName,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                          const SizedBox(width: 12),
                          PriorityBadge(priority: ticket.priority),
                          const SizedBox(width: 12),
                          StatusChip(status: ticket.status),
                        ],
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => TicketDetailsScreen(ticket: ticket),
                        ),
                      );
                    },
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