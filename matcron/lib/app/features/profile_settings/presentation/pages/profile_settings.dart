import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:matcron/app/features/profile_settings/presentation/pages/account.dart';
import 'package:matcron/app/features/profile_settings/presentation/pages/help.dart';
import 'package:matcron/app/features/organization/presentation/pages/organizations.dart';
import 'package:matcron/app/features/profile_settings/presentation/pages/notification.dart';
import 'package:matcron/app/features/profile_settings/presentation/pages/reports.dart';
import 'package:matcron/app/features/profile_settings/presentation/pages/security.dart';
import 'package:matcron/app/features/profile_settings/presentation/pages/settings.dart';
import 'package:matcron/app/features/profile_settings/presentation/pages/terms_condition.dart';
import 'package:matcron/app/features/profile_settings/presentation/pages/about_us.dart';
import 'package:matcron/app/features/organization/presentation/bloc/remote_org_bloc.dart';
import 'package:matcron/app/features/organization/presentation/bloc/remote_org_event.dart';
import 'package:matcron/app/injection_container.dart';
import 'package:matcron/core/resources/authorization.dart'; 
import 'package:matcron/main.dart';

class ProfileSettings extends StatefulWidget {
  const ProfileSettings({super.key});

  @override
  ProfileSettingsState createState() => ProfileSettingsState();
}

class ProfileSettingsState extends State<ProfileSettings> {
  int userType = 0;
  File? _imageFile;
   final AuthorizationService _authService = AuthorizationService();

  @override
  void initState() {
    super.initState();
    _initializeUserType();
  }

  void _initializeUserType() async {
    int type = (await AuthorizationService().getUserType())!;
    setState(() {
      userType = type;
    });
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  void _logout() async {
    _authService.deleteToken(); // Delete token
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const InitialScreens()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        backgroundColor: theme.appBarTheme.backgroundColor,
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: const Center(
            child: Text("<", style: TextStyle(fontSize: 35)),
          ),
        ),
      ),
      body: ListView(
        children: <Widget>[
          _buildProfileHeader(theme),
          _buildGroupedContainer(theme),
          _buildGroupedContainer1(theme),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: _createNavigationItem(
              icon: Icons.info_outline,
              text: 'About Us',
              destination: AboutUsPage(),
              theme: theme,
            ),
          ),
             Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
            child: ElevatedButton(
              onPressed: _logout,
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.cardColor, // Logout color
                                padding: const EdgeInsets.all(15),
              ),
              child:  Text("Log Out", style: TextStyle(fontSize: 16, color: theme.colorScheme.primary)),
            ),
          ),
    
        ],
      ),
    );
  }

  Widget _buildProfileHeader(ThemeData theme) {
    return Container(
      color: theme.primaryColor,
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: _pickImage,
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 50,
                  backgroundImage: _imageFile != null ? FileImage(_imageFile!) : null,
                  child: _imageFile == null
                      ? const Icon(Icons.person, size: 50.0, color: Colors.grey)
                      : null,
                ),
                Positioned(
                  bottom: 5,
                  right: 5,
                  child: Container(
                    decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.blueAccent),
                    padding: const EdgeInsets.all(5),
                    child: const Icon(Icons.edit, size: 20, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Text('Jane Doe', style: theme.textTheme.titleLarge),
          Text('jane.doe@example.com', style: TextStyle(color: theme.colorScheme.onPrimary)),
        ],
      ),
    );
  }

  Widget _buildGroupedContainer(ThemeData theme) {
    return _buildContainer(theme, [
      _createNavigationItem(icon: Icons.help, text: 'Help', destination: HelpPage(), theme: theme),
      _createNavigationItem(icon: Icons.account_circle, text: 'Account', destination: AccountPage(), theme: theme),
      _createNavigationItem(icon: Icons.article, text: 'Terms and Condition', destination: TermsAndConditionsPage(), theme: theme),
      _createNavigationItem(icon: Icons.notifications, text: 'Notifications', destination: NotificationsPage(), theme: theme),
    ]);
  }

  Widget _buildGroupedContainer1(ThemeData theme) {
    return _buildContainer(theme, [
      if (userType == 1) _createOrganizationNavigationItem(theme),
      _createNavigationItem(icon: Icons.report, text: 'Reports', destination: ReportsPage(), theme: theme),
      _createNavigationItem(icon: Icons.security, text: 'Security', destination: SecurityPage(), theme: theme),
      _createNavigationItem(icon: Icons.settings, text: 'Settings', destination: SettingsPage(), theme: theme),
    ]);
  }

  Widget _buildContainer(ThemeData theme, List<Widget> children) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(color: theme.cardColor, borderRadius: BorderRadius.circular(15.0)),
        child: Column(children: children),
      ),
    );
  }

  Widget _createNavigationItem({required IconData icon, required String text, required Widget destination, required ThemeData theme}) {
    return ListTile(
      leading: Icon(icon, color: theme.colorScheme.onSurface),
      title: Text(text, style: TextStyle(color: theme.colorScheme.onSurface)),
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => destination)),
    );
  }

  Widget _createOrganizationNavigationItem(ThemeData theme) {
    return ListTile(
      leading: const Icon(Icons.business),
      title: Text('Organization', style: TextStyle(color: theme.colorScheme.onSurface)),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (context) => sl<RemoteOrganizationBloc>()..add(GetOrganizations()),
              child: const OrganizationPage(),
            ),
          ),
        );
      },
    );
  }
}


