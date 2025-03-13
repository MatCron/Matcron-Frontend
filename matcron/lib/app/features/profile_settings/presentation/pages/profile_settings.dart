import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
import 'dart:io';
// import 'dart:convert';
import 'package:image_picker/image_picker.dart';

class ProfileSettings extends StatefulWidget {
  const ProfileSettings({super.key});

  @override
  ProfileSettingsState createState() => ProfileSettingsState();
}

class ProfileSettingsState extends State<ProfileSettings> {
  int userType = 0;
  File? _imageFile;
  // String? _base64Image;

  @override
  void initState() {
    super.initState();
    _initializeUserType(); // Call an async function separately
  }

  void _initializeUserType() async {
    int type = (await AuthorizationService().getUserType())!;
    setState(() {
      userType = type;
    });
  }

  // Function to pick an image
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
     // List<int> imageBytes = await imageFile.readAsBytes();
      //    String base64String = base64Encode(imageBytes); 
    

      setState(() {
        _imageFile = imageFile;
      //  _base64Image = base64String;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        backgroundColor: theme.appBarTheme.backgroundColor,
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: const Center(
            child: Text(
              "<",
              style: TextStyle(fontSize: 35),
            ),
          ),
        ),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            color: theme.primaryColor,
            padding: const EdgeInsets.symmetric(vertical: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 50,
                  child: Icon(Icons.person, size: 50.0, color: Colors.grey),
                ),
                const SizedBox(height: 16),
                Text(
                  'Jane Doe',
                  style: theme.textTheme.titleLarge, // Text from the theme
                ),
                Text(
                  'jane.doe@example.com',
                  style: TextStyle(color: theme.colorScheme.onPrimary), // Use onPrimary for white text
                ),
              ],
            ),
          ),
          _buildGroupedContainer(theme),
          _buildGroupedContainer1(theme),
           GestureDetector(
                  onTap: _pickImage, // Pick image on tap
                  child: Stack(
          alignment: Alignment.bottomRight,
                  children: [ CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 50,
                    backgroundImage:
                        _imageFile != null ? FileImage(_imageFile!) : null,
                    child: _imageFile == null
                        ? const Icon(Icons.person, size: 50.0, color: Colors.grey)
                        : null,
                  ),
                
                Positioned(
              bottom: 5,
              right: 5,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blueAccent, // Edit icon background
                ),
                padding: const EdgeInsets.all(5),
                child: const Icon(
                  Icons.edit, // Pencil icon
                  size: 20,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
                const SizedBox(height: 16),
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
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: _createNavigationItem(
              icon: Icons.info_outline,
              text: 'About Us',
              destination: AboutUsPage(),
              theme: theme,
            ),
          ),
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
        decoration: BoxDecoration(
          color: theme.cardColor, // Background color of containers
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Column(children: children),
      ),
    );
  }

  Widget _createNavigationItem({required IconData icon, required String text, required Widget destination, required ThemeData theme}) {
    return ListTile(
      leading: Icon(icon, color: theme.colorScheme.onSurface), // Icon color using theme
      title: Text(text, style: TextStyle(color: theme.colorScheme.onSurface)), // Text color using theme
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => destination)),
    );
  }

  Widget _createOrganizationNavigationItem(ThemeData theme) {
    return ListTile(
      leading: const Icon(Icons.business), // Organization Icon
      title: Text('Organization', style: TextStyle(color: theme.colorScheme.onSurface)),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (context) =>
                  sl<RemoteOrganizationBloc>()..add(GetOrganizations()),
              child: const OrganizationPage(),
            ),
          ),
        );
      },
    );
  }
}