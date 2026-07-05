import 'package:flutter/material.dart';

class SidebarMenu extends StatelessWidget {
  final int selectedIndex;
  final bool isCollapsed;
  final ValueChanged<int> onItemSelected;
  final VoidCallback onCollapseToggle;

  const SidebarMenu({
    Key? key,
    required this.selectedIndex,
    required this.isCollapsed,
    required this.onItemSelected,
    required this.onCollapseToggle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    final menuItems = [
      {'title': 'Dashboard', 'icon': Icons.dashboard_outlined, 'selected_icon': Icons.dashboard},
      {'title': 'Tickets', 'icon': Icons.confirmation_number_outlined, 'selected_icon': Icons.confirmation_number},
      {'title': 'Create Ticket', 'icon': Icons.add_circle_outline, 'selected_icon': Icons.add_circle},
      {'title': 'Analytics', 'icon': Icons.analytics_outlined, 'selected_icon': Icons.analytics},
      {'title': 'Team', 'icon': Icons.people_outline, 'selected_icon': Icons.people},
      {'title': 'Notifications', 'icon': Icons.notifications_none, 'selected_icon': Icons.notifications},
      {'title': 'Knowledge Base', 'icon': Icons.menu_book_outlined, 'selected_icon': Icons.menu_book},
      {'title': 'Profile', 'icon': Icons.person_outline, 'selected_icon': Icons.person},
      {'title': 'Settings', 'icon': Icons.settings_outlined, 'selected_icon': Icons.settings},
    ];

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: isCollapsed ? 76 : 260,
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        border: Border(right: BorderSide(color: theme.dividerColor, width: 0.8)),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                Icon(Icons.support_agent, color: theme.colorScheme.primary, size: 32),
                if (!isCollapsed) ...[
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'SupportDesk',
                      style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, color: theme.colorScheme.primary),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ]
              ],
            ),
          ),
          Divider(height: 1, color: theme.dividerColor),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              itemCount: menuItems.length,
              itemBuilder: (context, idx) {
                final item = menuItems[idx];
                final isSelected = selectedIndex == idx;
                final icon = isSelected ? item['selected_icon'] as IconData : item['icon'] as IconData;

                return InkWell(
                  onTap: () => onItemSelected(idx),
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    height: 48,
                    margin: const EdgeInsets.symmetric(vertical: 2),
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: isSelected ? theme.colorScheme.primary.withOpacity(0.08) : Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Icon(icon, color: isSelected ? theme.colorScheme.primary : theme.colorScheme.onSurface.withOpacity(0.7)),
                        if (!isCollapsed) ...[
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              item['title'] as String,
                              style: textTheme.bodyMedium?.copyWith(
                                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                                color: isSelected ? theme.colorScheme.primary : theme.colorScheme.onSurface,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Divider(height: 1, color: theme.dividerColor),
          IconButton(
            padding: const EdgeInsets.all(16),
            icon: Icon(isCollapsed ? Icons.chevron_right : Icons.chevron_left),
            onPressed: onCollapseToggle,
          ),
        ],
      ),
    );
  }
}