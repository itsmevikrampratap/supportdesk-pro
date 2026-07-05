import 'package:flutter/material.dart';
import '../data/dummy_data.dart';
import '../widgets/status_chip.dart';
import '../widgets/priority_badge.dart';
import 'ticket_details_screen.dart';

class TicketListScreen extends StatefulWidget {
  const TicketListScreen({Key? key}) : super(key: key);

  @override
  State<TicketListScreen> createState() => _TicketListScreenState();
}

class _TicketListScreenState extends State<TicketListScreen> {
  String _searchQuery = "";
  String _selectedCategory = "All";

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final filteredTickets = DummyData.tickets.where((ticket) {
      final matchesSearch = ticket.subject.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          ticket.id.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          ticket.customerName.toLowerCase().contains(_searchQuery.toLowerCase());
      final matchesCat = _selectedCategory == "All" || ticket.category == _selectedCategory;
      return matchesSearch && matchesCat;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Service Tickets Queue"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    onChanged: (val) => setState(() => _searchQuery = val),
                    decoration: const InputDecoration(
                      hintText: "Search ticket ID, customer name or issue description...",
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                DropdownButton<String>(
                  value: _selectedCategory,
                  onChanged: (val) => setState(() => _selectedCategory = val ?? "All"),
                  items: ["All", "Integration", "Authentication", "Billing", "Mobile App", "Infrastructure"]
                      .map((cat) => DropdownMenuItem(value: cat, child: Text(cat)))
                      .toList(),
                )
              ],
            ),
          ),
          Expanded(
            child: filteredTickets.isEmpty
                ? const Center(child: Text("No tickets match search specifications."))
                : ListView.builder(
              itemCount: filteredTickets.length,
              itemBuilder: (context, idx) {
                final t = filteredTickets[idx];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => TicketDetailsScreen(ticket: t)),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(t.id, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                              StatusChip(status: t.status),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(t.subject, style: theme.textTheme.titleLarge?.copyWith(fontSize: 16)),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Client: ${t.customerName}", style: theme.textTheme.bodyMedium),
                              PriorityBadge(priority: t.priority),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Assignee: ${t.assignedEngineer}", style: theme.textTheme.bodyMedium),
                              Text(
                                "${t.createdAt.day}/${t.createdAt.month}/${t.createdAt.year}",
                                style: theme.textTheme.bodyMedium?.copyWith(fontSize: 12),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
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