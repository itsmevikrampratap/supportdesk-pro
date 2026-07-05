enum TicketPriority { low, medium, high, urgent }
enum TicketStatus { open, inProgress, resolved, closed }

class Ticket {
  final String id;
  final String subject;
  final String description;
  final String customerName;
  final String customerEmail;
  final String category;
  final TicketPriority priority;
  final TicketStatus status;
  final String assignedEngineer;
  final DateTime createdAt;
  final List<Comment> comments;
  final List<Activity> activities;
  final List<String> attachments;

  Ticket({
    required this.id,
    required this.subject,
    required this.description,
    required this.customerName,
    required this.customerEmail,
    required this.category,
    required this.priority,
    required this.status,
    required this.assignedEngineer,
    required this.createdAt,
    required this.comments,
    required this.activities,
    required this.attachments,
  });

  Ticket copyWith({
    String? subject,
    String? description,
    TicketPriority? priority,
    TicketStatus? status,
    String? assignedEngineer,
    List<Comment>? comments,
    List<Activity>? activities,
  }) {
    return Ticket(
      id: this.id,
      subject: subject ?? this.subject,
      description: description ?? this.description,
      customerName: this.customerName,
      customerEmail: this.customerEmail,
      category: this.category,
      priority: priority ?? this.priority,
      status: status ?? this.status,
      assignedEngineer: assignedEngineer ?? this.assignedEngineer,
      createdAt: this.createdAt,
      comments: comments ?? this.comments,
      activities: activities ?? this.activities,
      attachments: this.attachments,
    );
  }
}

class Comment {
  final String author;
  final String text;
  final DateTime timestamp;
  final bool isInternal;

  Comment({
    required this.author,
    required this.text,
    required this.timestamp,
    this.isInternal = false,
  });
}

class Activity {
  final String author;
  final String message;
  final DateTime timestamp;

  Activity({
    required this.author,
    required this.message,
    required this.timestamp,
  });
}