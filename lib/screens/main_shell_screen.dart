import 'package:flutter/material.dart';
import '../widgets/responsive_builder.dart';
import '../widgets/sidebar_menu.dart';
import 'dashboard_screen.dart';
import 'ticket_list_screen.dart';
import 'create_ticket_screen.dart';
import 'analytics_screen.dart';
import 'team_screen.dart';
import 'notifications_screen.dart';
import 'kb_screen.dart';
import 'profile_screen.dart';
import 'settings_screen.dart';

class MainShellScreen extends StatefulWidget {
  const MainShellScreen({Key? key}) : super(key: key);

  @override
  State<MainShellScreen> createState() => _MainShellScreenState();
}

class _MainShellScreenState extends State<MainShellScreen> {
  int _currentIndex = 0;
  bool _isSidebarCollapsed = false;

  final List<Widget> _screens = [
    const DashboardScreen(),
    const TicketListScreen(),
    const CreateTicketScreen(),
    const AnalyticsScreen(),
    const TeamScreen(),
    const NotificationsScreen(),
    const KbScreen(),
    const ProfileScreen(),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveBuilder.isMobile(context);

    return Scaffold(
      bottomNavigationBar: isMobile
          ? BottomNavigationBar(
        currentIndex: _currentIndex > 4 ? 0 : _currentIndex,
        onTap: (index) {
          setState(() => _currentIndex = index);
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: "Dashboard"),
          BottomNavigationBarItem(icon: Icon(Icons.confirmation_number), label: "Tickets"),
          BottomNavigationBarItem(icon: Icon(Icons.add_box), label: "New"),
          BottomNavigationBarItem(icon: Icon(Icons.analytics), label: "Analytics"),
          BottomNavigationBarItem(icon: Icon(Icons.menu), label: "More"),
        ],
      )
          : null,
      body: Row(
        children: [
          if (!isMobile)
            SidebarMenu(
              selectedIndex: _currentIndex,
              isCollapsed: _isSidebarCollapsed,
              onItemSelected: (idx) {
                setState(() => _currentIndex = idx);
              },
              onCollapseToggle: () {
                setState(() => _isSidebarCollapsed = !_isSidebarCollapsed);
              },
            ),
          Expanded(
            child: IndexedStack(
              index: _currentIndex,
              children: _screens,
            ),
          ),
        ],
      ),
    );
  }
}