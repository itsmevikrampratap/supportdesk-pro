import 'package:flutter/material.dart';
import '../models/ticket.dart';

class PriorityBadge extends StatelessWidget {
  final TicketPriority priority;

  const PriorityBadge({Key? key, required this.priority}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color color;
    String label;

    switch (priority) {
      case TicketPriority.low:
        color = Colors.green;
        label = "Low";
        break;
      case TicketPriority.medium:
        color = Colors.orange;
        label = "Medium";
        break;
      case TicketPriority.high:
        color = Colors.deepOrange;
        label = "High";
        break;
      case TicketPriority.urgent:
        color = Colors.red;
        label = "Urgent";
        break;
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}