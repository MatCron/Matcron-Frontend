import 'package:flutter/material.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  NotificationsPageState createState() => NotificationsPageState();
}

class NotificationsPageState extends State<NotificationsPage> with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
 appBar: AppBar(
  backgroundColor: Theme.of(context).primaryColor,
  elevation: 0,
  leading: Padding(
    padding: const EdgeInsets.only(left: 12.0),
    child: GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Container(
        decoration: BoxDecoration(
          color: theme.colorScheme.onSurface.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        padding: const EdgeInsets.all(8),
        child:  Icon(Icons.arrow_back, color: theme.colorScheme.surface),
      ),
    ),
  ),
  title:  Text(
    "Notification",
    style: TextStyle(
      color: theme.colorScheme.surface,
      fontWeight: FontWeight.bold,
    ),
  ),
),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildNotificationsList(),
          _buildNotificationsList(),
        ],
      ),
    );
  }

  Widget _buildNotificationsList() {
    final theme = Theme.of(context);
    List<Map<String, dynamic>> notifications = [
      {'title': 'Mattress in Room 205 needs washing', 'time': '4m ago', 'urgent': true},
      {'title': 'Mattress in Room 206 needs to be rotated', 'time': '13m ago', 'urgent': false},
      {'title': 'Mattress in Room 200 needs to be flipped', 'time': '20m ago', 'urgent': false},
      {'title': 'Mattress in Room 209 needs to be replaced', 'time': '54m ago', 'urgent': true},
      {'title': 'Mattress in Room 300 needs to be rotated', 'time': '1h ago', 'urgent': false},
    ];

    return ListView.builder(
      itemCount: notifications.length,
      itemBuilder: (context, index) {
        var notification = notifications[index];
        return ListTile(
          leading: Icon(
            notification['urgent'] ? Icons.error : Icons.notifications_none,
            color: theme.colorScheme.error,
          ),
          title: Text(notification['title']),
          subtitle: Text(notification['time']),
          trailing: const Icon(Icons.arrow_forward_ios),
        );
      },
    );
  }
}
