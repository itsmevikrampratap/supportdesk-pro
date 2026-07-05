import 'package:flutter/material.dart';
import '../models/ticket.dart';

class StatusChip extends StatelessWidget {
  final TicketStatus status;

  const StatusChip({Key? key, required this.status}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color color;
    String label;

    switch (status) {
      case TicketStatus.open:
        color = Colors.blue;
        label = "Open";
        break;
      case TicketStatus.inProgress:
        color = Colors.purple;
        label = "In Progress";
        break;
      case TicketStatus.resolved:
        color = Colors.green;
        label = "Resolved";
        break;
      case TicketStatus.closed:
        color = Colors.grey;
        label = "Closed";
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.3), width: 1),
      ),
      child: Text(
        label,
        style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.w600),
      ),
    );
  }
}