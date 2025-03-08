// import 'package:flutter/material.dart';

// import 'package:matcron/app/features/profile_settings/presentation/pages/account.dart';
// import 'package:matcron/app/features/profile_settings/presentation/pages/help.dart';
// import 'package:matcron/app/features/organization/presentation/pages/organizations.dart';
// import 'package:matcron/app/features/profile_settings/presentation/pages/notification.dart';
// import 'package:matcron/app/features/profile_settings/presentation/pages/reports.dart';
// import 'package:matcron/app/features/profile_settings/presentation/pages/security.dart';
// import 'package:matcron/app/features/profile_settings/presentation/pages/settings.dart';
// import 'package:matcron/app/features/profile_settings/presentation/pages/terms_condition.dart';
// import 'package:matcron/app/features/profile_settings/presentation/pages/about_us.dart';
// import 'package:matcron/app/features/organization/presentation/bloc/remote_org_bloc.dart';
// import 'package:matcron/app/features/organization/presentation/bloc/remote_org_event.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:matcron/app/injection_container.dart';
// import 'package:matcron/core/resources/authorization.dart'; // Add this import for sl

// class ProfileSettings extends StatefulWidget {
//   const ProfileSettings({super.key});

//   @override
//   ProfileSettingsState createState() => ProfileSettingsState();
// }

// class ProfileSettingsState extends State<ProfileSettings> {
//   int userType = 0;

//   @override
//   void initState() {
//     super.initState();
//     _initializeUserType(); // Call an async function separately
//   }

//   void _initializeUserType() async {
//   int type = (await AuthorizationService().getUserType())!;
//   setState(() {
//     userType = type;
//   }); 
// }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: const Color.fromARGB(255, 80, 194, 201),
//         leading: InkWell(
//           onTap: () => Navigator.pop(context),
//           child: const Center(
//             child: Text(
//               "<",
//               style: TextStyle(
//                 fontSize: 35,
//                 color: Colors.white,
//               ),
//             ),
//           ),
//         ),
//       ),
//       body: ListView(
//         children: <Widget>[
//           Container(
//             color: const Color.fromARGB(255, 80, 194, 201),
//             padding: const EdgeInsets.symmetric(vertical: 24),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: const [
//                 CircleAvatar(
//                   backgroundColor: Colors.white,
//                   radius: 50,
//                   child: Icon(Icons.person, size: 50.0, color: Colors.grey),
//                 ),
//                 SizedBox(height: 16),
//                 Text(
//                   'Jane Doe',
//                   style: TextStyle(
//                     fontSize: 24.0,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                   ),
//                 ),
//                 Text(
//                   'jane.doe@example.com',
//                   style: TextStyle(
//                     fontSize: 16.0,
//                     color: Colors.white,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           _buildGroupedContainer(),
//           _buildGroupedContainer1(),
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: 8.0),
//             child: _createNavigationItem(
//               icon: Icons.info_outline,
//               text: 'About Us',
//               destination: AboutUsPage(),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildGroupedContainer() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: Container(
//         decoration: BoxDecoration(
//           color: Colors.grey.shade200,
//           borderRadius: BorderRadius.circular(15.0),
//         ),
//         child: Column(
//           children: [
//             _createNavigationItem(
//                 icon: Icons.help, text: 'Help', destination: HelpPage()),
//             _createNavigationItem(
//                 icon: Icons.account_circle,
//                 text: 'Account',
//                 destination: AccountPage()),
//             _createNavigationItem(
//                 icon: Icons.article,
//                 text: 'Terms and Condition',
//                 destination: TermsAndConditionsPage()),
//             _createNavigationItem(
//                 icon: Icons.notifications,
//                 text: 'Notifications',
//                 destination: NotificationsPage()),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildGroupedContainer1() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: Container(
//         decoration: BoxDecoration(
//           color: Colors.grey.shade200,
//           borderRadius: BorderRadius.circular(15.0),
//         ),
//         child: Column(
//           children: [
//             if (userType == 1)
//             _createOrganizationNavigationItem(),
//             _createNavigationItem(
//                 icon: Icons.report,
//                 text: 'Reports',
//                 destination: ReportsPage()),
//             _createNavigationItem(
//                 icon: Icons.security,
//                 text: 'Security',
//                 destination: SecurityPage()),
//             _createNavigationItem(
//                 icon: Icons.settings,
//                 text: 'Settings',
//                 destination: SettingsPage()),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _createNavigationItem({
//     required IconData icon,
//     required String text,
//     required Widget destination,
//   }) {
//     return ListTile(
//       leading: Icon(icon),
//       title: Text(text),
//       onTap: () => Navigator.push(
//           context, MaterialPageRoute(builder: (context) => destination)),
//     );
//   }

//   Widget _createOrganizationNavigationItem() {
//     return ListTile(
//       leading: const Icon(Icons.business), // Organization Icon
//       title: const Text('Organization'),
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => BlocProvider(
//               create: (context) =>
//                   sl<RemoteOrganizationBloc>()..add(GetOrganizations()),
//               child: const OrganizationPage(),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }





import 'package:flutter/material.dart';
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
import 'package:flutter_bloc/flutter_bloc.dart';
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 80, 194, 201),
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
            color:const Color.fromARGB(255, 80, 194, 201) ,
            padding: const EdgeInsets.symmetric(vertical: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
                   _buildGroupedContainer(),
          _buildGroupedContainer1(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: _createNavigationItem(
              icon: Icons.info_outline,
              text: 'About Us',
              destination: AboutUsPage(),
            ),
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
            _createNavigationItem(
                icon: Icons.help, text: 'Help', destination: HelpPage()),
            _createNavigationItem(
                icon: Icons.account_circle,
                text: 'Account',
                destination: AccountPage()),
            _createNavigationItem(
                icon: Icons.article,
                text: 'Terms and Condition',
                destination: TermsAndConditionsPage()),
            _createNavigationItem(
                icon: Icons.notifications,
                text: 'Notifications',
                destination: NotificationsPage()),
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
            if (userType == 1)
            _createOrganizationNavigationItem(),
            _createNavigationItem(
                icon: Icons.report,
                text: 'Reports',
                destination: ReportsPage()),
            _createNavigationItem(
                icon: Icons.security,
                text: 'Security',
                destination: SecurityPage()),
            _createNavigationItem(
                icon: Icons.settings,
                text: 'Settings',
                destination: SettingsPage()),
          ],
        ),
      ),
    );
  }

  Widget _createNavigationItem({
    required IconData icon,
    required String text,
    required Widget destination,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(text),
      onTap: () => Navigator.push(
          context, MaterialPageRoute(builder: (context) => destination)),
    );
  }

  Widget _createOrganizationNavigationItem() {
    return ListTile(
      leading: const Icon(Icons.business), // Organization Icon
      title: const Text('Organization'),
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