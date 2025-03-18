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
        
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child:  Center(
            child: Text(
              "<",
              style: TextStyle(
                fontSize: 26,
                color: theme.colorScheme.surface,
              ),
            ),
          ),
        ),
        title:  Text(
          'Notifications',
          style: TextStyle(color: theme.colorScheme.surface),
        ),
        iconTheme:  IconThemeData(
          color: theme.colorScheme.surface,
        ),
        backgroundColor: theme.colorScheme.primary,
        // Removed the "X" button entirely from actions
        bottom: TabBar(
          controller: _tabController,
          tabs:  [
            Tab(text: 'Unread'),
            Tab(text: 'Archive'),
          ],
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
