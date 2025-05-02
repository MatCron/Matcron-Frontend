import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:matcron/app/features/profile_settings/presentation/pages/account.dart';
import 'package:matcron/app/features/profile_settings/presentation/pages/help.dart';
import 'package:matcron/app/features/organisation/presentation/pages/organisations.dart';
import 'package:matcron/app/features/profile_settings/presentation/pages/notification.dart';
import 'package:matcron/app/features/profile_settings/presentation/pages/reports.dart';
import 'package:matcron/app/features/profile_settings/presentation/pages/security.dart';
import 'package:matcron/app/features/profile_settings/presentation/pages/settings.dart';
import 'package:matcron/app/features/profile_settings/presentation/pages/terms_condition.dart';
import 'package:matcron/app/features/profile_settings/presentation/pages/about_us.dart';
import 'package:matcron/app/features/organisation/presentation/bloc/remote_org_bloc.dart';
import 'package:matcron/app/features/organisation/presentation/bloc/remote_org_event.dart';
import 'package:matcron/app/injection_container.dart';
import 'package:matcron/config/languages.dart';
import 'package:matcron/core/resources/authorization.dart';
import 'package:matcron/core/resources/language_provider.dart';
import 'package:provider/provider.dart';
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
  late LanguageProvider languageProvider;

  @override
  void initState() {
    super.initState();
    languageProvider = Provider.of<LanguageProvider>(context, listen: false);

    _initializeUserType();
  }

  void _initializeUserType() async {
    int? type = await AuthorizationService().getUserType(); // Remove '!'
    setState(() {
      userType = type ?? 0; // Provide a default value (e.g., 0)
    });
  }

  void _changeLanguage(String languageCode) async {
    final languageProvider =
        Provider.of<LanguageProvider>(context, listen: false);
    await languageProvider
        .setLanguage(languageCode); // Update language globally
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
    final languageProvider = Provider.of<LanguageProvider>(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar:null,
      body: ListView(
        children: <Widget>[
          _buildProfileHeader(theme),
          _buildGroupedContainer(theme),
          _buildGroupedContainer1(theme),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: _createNavigationItem(
              icon: Icons.language,
              text:
                  '${languages[languageProvider.currentLanguage]!["Profile"]!["Language"]!} (${languageProvider.currentLanguage})', // Show current language
              theme: theme,
              onTap: () => _showLanguageSelectionDialog(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: _createNavigationItem(
              icon: Icons.info_outline,
              text: languages[languageProvider.currentLanguage]!["Profile"]![
                  "About"]!,
              destination: AboutUsPage(),
              theme: theme,
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
            child: ElevatedButton(
              onPressed: _logout,
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.cardColor, // Logout color
                padding: const EdgeInsets.all(15),
              ),
              child: Text(
                  languages[languageProvider.currentLanguage]!["Profile"]![
                      "Log Out"]!,
                  style: TextStyle(
                      fontSize: 16, color: theme.colorScheme.error)), // Logout text
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileHeader(ThemeData theme) {
     return Stack(
    children: [
      Container(
        width: double.infinity,
        color: theme.primaryColor,
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
           const SizedBox(height: 40),
          GestureDetector(
            onTap: _pickImage,
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                CircleAvatar(
                  backgroundColor: theme.colorScheme.onPrimary,
                  radius: 50,
                  backgroundImage:
                      _imageFile != null ? FileImage(_imageFile!) : null,
                  child: _imageFile == null
                      ?  Icon(Icons.person, size: 50.0, color: theme.colorScheme.shadow)
                      : null,
                ),
                Positioned(
                  bottom: 5,
                  right: 5,
                  child: Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.blueAccent),
                    padding: const EdgeInsets.all(5),
                    child:
                         Icon(Icons.edit, size: 20, color: theme.colorScheme.onPrimary),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Text('Jane Doe', style: theme.textTheme.titleLarge),
          Text('jane.doe@example.com',
              style: TextStyle(color: theme.colorScheme.onPrimary)),
        ],
      ),
      ),
   
  Positioned(
        top: 40,
        left: 16,
        child: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            decoration: BoxDecoration(
              color: theme.colorScheme.onSurface.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            padding: const EdgeInsets.all(8),
            child:  Icon(Icons.arrow_back, color: theme.colorScheme.onPrimary),
          ),
        ),
      ),
    ],
  );
}


  Widget _buildGroupedContainer(ThemeData theme) {
    return _buildContainer(theme, [
      _createNavigationItem(
          icon: Icons.help,
          text:
              languages[languageProvider.currentLanguage]!["Profile"]!["Help"]!,
          destination: HelpPage(),
          theme: theme),
      _createNavigationItem(
          icon: Icons.account_circle,
          text: languages[languageProvider.currentLanguage]!["Profile"]![
              "Account"]!,
          destination: AccountPage(),
          theme: theme),
      _createNavigationItem(
          icon: Icons.article,
          text: languages[languageProvider.currentLanguage]!["Profile"]![
              "Terms"]!,
          destination: TermsAndConditionsPage(),
          theme: theme),
      _createNavigationItem(
          icon: Icons.notifications,
          text: languages[languageProvider.currentLanguage]!["Profile"]![
              "Notifications"]!,
          destination: NotificationsPage(),
          theme: theme),
    ]);
  }

  Widget _buildGroupedContainer1(ThemeData theme) {
    return _buildContainer(theme, [
      if (userType == 1) _createOrganizationNavigationItem(theme),
      _createNavigationItem(
          icon: Icons.report,
          text: languages[languageProvider.currentLanguage]!["Profile"]![
              "Reports"]!,
          destination: ReportsPage(),
          theme: theme),
      _createNavigationItem(
          icon: Icons.security,
          text: languages[languageProvider.currentLanguage]!["Profile"]![
              "Security"]!,
          destination: SecurityPage(),
          theme: theme),
      _createNavigationItem(
          icon: Icons.settings,
          text: languages[languageProvider.currentLanguage]!["Profile"]![
              "Settings"]!,
          destination: SettingsPage(),
          theme: theme),
    ]);
  }

  Widget _buildContainer(ThemeData theme, List<Widget> children) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
            color: theme.cardColor, borderRadius: BorderRadius.circular(15.0)),
        child: Column(children: children),
      ),
    );
  }

  Widget _createNavigationItem(
      {required IconData icon,
      required String text,
      Widget? destination,
      required ThemeData theme,
      Function()? onTap}) {
    return ListTile(
      leading: Icon(icon, color: theme.colorScheme.onSurface),
      title: Text(text, style: TextStyle(color: theme.colorScheme.onSurface)),
      onTap: onTap ??
          (destination != null
              ? () => Navigator.push(
                  context, MaterialPageRoute(builder: (context) => destination))
              : null),
    );
  }

  Widget _createOrganizationNavigationItem(ThemeData theme) {
    return ListTile(
      leading: const Icon(Icons.business),
      title: Text(
          languages[languageProvider.currentLanguage]!["Profile"]![
              "Organization"]!,
          style: TextStyle(color: theme.colorScheme.onSurface)),
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

  void _showLanguageSelectionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Language'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: const Text('English'),
                onTap: () {
                  _changeLanguage('EN');
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Deutsch'),
                onTap: () {
                  _changeLanguage('DE');
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Español'),
                onTap: () {
                  _changeLanguage('ES');
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Italiano'),
                onTap: () {
                  _changeLanguage('IT');
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Nederlands'),
                onTap: () {
                  _changeLanguage('NL');
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Português'),
                onTap: () {
                  _changeLanguage('PT');
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Français'),
                onTap: () {
                  _changeLanguage('FR');
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('العربية'),
                onTap: () {
                  _changeLanguage('AR');
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
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
}
