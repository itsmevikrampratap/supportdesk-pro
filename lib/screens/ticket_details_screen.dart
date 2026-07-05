import 'package:flutter/material.dart';
import '../models/ticket.dart';
import '../widgets/status_chip.dart';
import '../widgets/priority_badge.dart';

class TicketDetailsScreen extends StatefulWidget {
  final Ticket ticket; // Corrected field declaration

  const TicketDetailsScreen({Key? key, required this.ticket}) : super(key: key);

  @override
  State<TicketDetailsScreen> createState() => _TicketDetailsScreenState();
}

class _TicketDetailsScreenState extends State<TicketDetailsScreen> {
  final _commentController = TextEditingController();
  late Ticket _localTicket;

  @override
  void initState() {
    super.initState();
    _localTicket = widget.ticket;
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  void _addComment() {
    if (_commentController.text.isNotEmpty) {
      setState(() {
        _localTicket.comments.insert(
          0,
          Comment(
            author: "System Agent Admin",
            text: _commentController.text,
            timestamp: DateTime.now(),
          ),
        );
        _commentController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Incident: ${_localTicket.id}"),
        actions: [
          PopupMenuButton<TicketStatus>(
            onSelected: (status) {
              setState(() {
                _localTicket = _localTicket.copyWith(status: status);
              });
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: TicketStatus.open, child: Text("Set Open")),
              const PopupMenuItem(value: TicketStatus.inProgress, child: Text("Set In Progress")),
              const PopupMenuItem(value: TicketStatus.resolved, child: Text("Set Resolved")),
              const PopupMenuItem(value: TicketStatus.closed, child: Text("Set Closed")),
            ],
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Text("Update Status"),
                  Icon(Icons.arrow_drop_down),
                ],
              ),
            ),
          )
        ],
      ),
      body: Row(
        children: [
          Expanded(
            flex: 6,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      StatusChip(status: _localTicket.status),
                      const SizedBox(width: 12),
                      PriorityBadge(priority: _localTicket.priority),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(_localTicket.subject, style: theme.textTheme.headlineMedium),
                  const SizedBox(height: 24),
                  const Text("Issue Explanation Details", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 8),
                  Text(_localTicket.description, style: theme.textTheme.bodyLarge),
                  const SizedBox(height: 32),
                  const Divider(),
                  const SizedBox(height: 16),
                  const Text("Updates Feed", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _commentController,
                          decoration: const InputDecoration(
                            hintText: "Add informational comment or instruction...",
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      ElevatedButton(
                        onPressed: _addComment,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: theme.colorScheme.primary,
                          foregroundColor: theme.colorScheme.onPrimary,
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                        ),
                        child: const Text("Post"),
                      )
                    ],
                  ),
                  const SizedBox(height: 24),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _localTicket.comments.length,
                    itemBuilder: (context, index) {
                      final c = _localTicket.comments[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(c.author, style: const TextStyle(fontWeight: FontWeight.bold)),
                                  Text(
                                    "${c.timestamp.hour}:${c.timestamp.minute}",
                                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                                  )
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(c.text),
                            ],
                          ),
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
          ),
          if (MediaQuery.of(context).size.width > 900)
            Expanded(
              flex: 3,
              child: Container(
                decoration: BoxDecoration(
                  border: Border(left: BorderSide(color: theme.dividerColor)),
                ),
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Client Context Profile", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                    const SizedBox(height: 16),
                    ListTile(
                      leading: const CircleAvatar(child: Icon(Icons.business)),
                      title: Text(_localTicket.customerName),
                      subtitle: Text(_localTicket.customerEmail),
                    ),
                    const Divider(height: 32),
                    const Text("Assignment Details", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                    const SizedBox(height: 16),
                    ListTile(
                      leading: const CircleAvatar(child: Icon(Icons.person_pin)),
                      title: Text(_localTicket.assignedEngineer),
                      subtitle: const Text("Platform Representative Engineer"),
                    ),
                    const Divider(height: 32),
                    const Text("Associated System Logs", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                    const SizedBox(height: 12),
                    for (var attachment in _localTicket.attachments)
                      Card(
                        child: ListTile(
                          leading: const Icon(Icons.attachment_outlined),
                          title: Text(attachment),
                        ),
                      )
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}