import 'package:flutter/material.dart';
import '../models/ticket.dart';
import '../models/team_member.dart';
import '../models/kb_article.dart';
import '../data/dummy_data.dart';

class AppState extends ChangeNotifier {
  bool _isDarkMode = false;
  bool _isSidebarCollapsed = false;
  int _selectedMenuIndex = 0;
  List<Ticket> _tickets = [];
  List<TeamMember> _team = [];
  List<KbArticle> _articles = [];
  List<Map<String, dynamic>> _notifications = [];

  bool get isDarkMode => _isDarkMode;
  bool get isSidebarCollapsed => _isSidebarCollapsed;
  int get selectedMenuIndex => _selectedMenuIndex;
  List<Ticket> get tickets => _tickets;
  List<TeamMember> get team => _team;
  List<KbArticle> get articles => _articles;
  List<Map<String, dynamic>> get notifications => _notifications;

  AppState() {
    _tickets = List.from(DummyData.tickets);
    _team = List.from(DummyData.teamMembers);
    _articles = List.from(DummyData.kbArticles);
    _notifications = List.from(DummyData.notifications);
  }

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  void toggleSidebar() {
    _isSidebarCollapsed = !_isSidebarCollapsed;
    notifyListeners();
  }

  void selectMenuIndex(int index) {
    _selectedMenuIndex = index;
    notifyListeners();
  }

  void addTicket(Ticket ticket) {
    _tickets.insert(0, ticket);
    notifyListeners();
  }

  void updateTicketStatus(String ticketId, TicketStatus status) {
    final index = _tickets.indexWhere((t) => t.id == ticketId);
    if (index != -1) {
      _tickets[index] = _tickets[index].copyWith(
        status: status,
        activities: [
          Activity(
            author: "System Agent",
            message: "Status changed to ${status.name.toUpperCase()}",
            timestamp: DateTime.now(),
          ),
          ..._tickets[index].activities,
        ],
      );
      notifyListeners();
    }
  }

  void addComment(String ticketId, Comment comment) {
    final index = _tickets.indexWhere((t) => t.id == ticketId);
    if (index != -1) {
      _tickets[index].comments.insert(0, comment);
      _tickets[index].activities.insert(
        0,
        Activity(
          author: comment.author,
          message: "Added a comment: \"${comment.text}\"",
          timestamp: DateTime.now(),
        ),
      );
      notifyListeners();
    }
  }

  void markNotificationAsRead(int index) {
    if (index >= 0 && index < _notifications.length) {
      _notifications[index]['isRead'] = true;
      notifyListeners();
    }
  }

  void markAllNotificationsRead() {
    for (var n in _notifications) {
      n['isRead'] = true;
    }
    notifyListeners();
  }
}