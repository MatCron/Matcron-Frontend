import 'package:flutter/material.dart';

import 'package:matcron/app/features/profile_settings/presentation/pages/account.dart';
import 'package:matcron/app/features/profile_settings/presentation/pages/help.dart';
import 'package:matcron/app/features/profile_settings/presentation/pages/history.dart';
import 'package:matcron/app/features/profile_settings/presentation/pages/notification.dart';
import 'package:matcron/app/features/profile_settings/presentation/pages/reports.dart';
import 'package:matcron/app/features/profile_settings/presentation/pages/security.dart';
import 'package:matcron/app/features/profile_settings/presentation/pages/settings.dart';
import 'package:matcron/app/features/profile_settings/presentation/pages/terms_condition.dart';
import 'package:matcron/app/features/profile_settings/presentation/pages/about_us.dart';

class ProfileSettings extends StatefulWidget {
  const ProfileSettings({super.key});

  @override
  ProfileSettingsState createState() => ProfileSettingsState();
}

class ProfileSettingsState extends State<ProfileSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 80, 194, 201),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            color: Color.fromARGB(255, 80, 194, 201), // Same background color
            padding: EdgeInsets.symmetric(vertical: 24), // Adjust padding as needed
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 50, // Adjust the size as needed
                  child: Icon(Icons.person, size: 50.0, color: Colors.grey),
                ),
                SizedBox(height: 16), // Spacing between avatar and text
                Text(
                  'Jane Doe',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'jane.doe@example.com',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          _buildGroupedContainer(),
          _buildGroupedContainer1(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: _createNavigationItem(icon: Icons.info_outline, text: 'About Us', destination: AboutUsPage()),
          ),
        ],
      ),
    );
  }

  Widget _buildGroupedContainer() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Column(
          children: [
            _createNavigationItem(icon: Icons.help, text: 'Help', destination: HelpPage()),
            _createNavigationItem(icon: Icons.account_circle, text: 'Account', destination: AccountPage()),
            _createNavigationItem(icon: Icons.article, text: 'Terms and Condition', destination: TermsAndConditionsPage()),
            _createNavigationItem(icon: Icons.notifications, text: 'Notifications', destination: NotificationsPage()),
          ],
        ),
      ),
    );
    }

     Widget _buildGroupedContainer1() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Column(
          children: [
            _createNavigationItem(icon: Icons.history, text: 'History', destination: HistoryPage()),
            _createNavigationItem(icon: Icons.report, text: 'Reports', destination: ReportsPage()),
            _createNavigationItem(icon: Icons.security, text: 'Security', destination: SecurityPage()),
            _createNavigationItem(icon: Icons.settings, text: 'Settings', destination: SettingsPage()),
          ],
        ),
      ),
    );
    }

  Widget _createNavigationItem({required IconData icon, required String text, required Widget destination}) {
    return ListTile(
      leading: Icon(icon),
      title: Text(text),
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => destination)),
    );
  }
}
