import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matcron/app/features/auth/presentation/bloc/auth/remote/login/remote_login_bloc.dart';
import 'package:matcron/app/features/auth/presentation/pages/login.dart';
import 'package:matcron/app/features/dashboard/presentation/pages/dashboard.dart';
import 'package:matcron/app/features/mattress/presentation/bloc/remote_mattress_bloc.dart';
import 'package:matcron/app/features/mattress/presentation/bloc/remote_mattress_event.dart';
import 'package:matcron/app/features/organization/presentation/bloc/remote_org_bloc.dart';
import 'package:matcron/app/features/organization/presentation/bloc/remote_org_event.dart';
import 'package:matcron/app/features/organization/presentation/pages/organizations.dart';
import 'package:matcron/app/features/type/presentation/bloc/remote_type_bloc.dart';
import 'package:matcron/app/features/type/presentation/bloc/remote_type_event.dart';
import 'package:matcron/app/features/type/presentation/pages/type.dart';
import 'package:matcron/core/components/header/header.dart';
import 'package:matcron/core/components/transfer_out/transfer_confirm.dart';	
import 'package:matcron/core/components/splash_screen.dart';

import 'package:matcron/core/constants/constants.dart';
import 'dart:developer';
import 'dart:async';
import 'package:matcron/core/resources/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:matcron/app/injection_container.dart';
import 'package:matcron/config/theme/app_theme.dart';
import 'package:matcron/core/resources/authorization.dart';
import 'features/mattress/presentation/pages/mattress_page.dart';


Future<void> main() async {
  await initializeDependencies(); // Initialize all dependencies
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor:
            HexColor("#E5E5E5"), // Set background color for the whole app
      ),
      //This is set to register for now, will change to the starting screen  once done. Wee need to show page depending on if user is logged in or not

       //home: const MattressRecyclingInfoPage(),
       // home: const SplashScreenWrapper(),
       home: TransferDonePage(),
    );
  }
}

//Splash Screen
class SplashScreenWrapper extends StatefulWidget {
  const SplashScreenWrapper({super.key});

  @override
  State<SplashScreenWrapper> createState() => _SplashScreenWrapperState();
}

class _SplashScreenWrapperState extends State<SplashScreenWrapper> {
  final AuthorizationService _authService = AuthorizationService();

  @override
  void initState() {
    super.initState();
    _checkAuthToken(); // Check the token when the widget initializes
  }

  Future<void> _checkAuthToken() async {
    String? token = await _authService.getToken();

    // Check if the widget is still in the widget tree
    if (!mounted) return;

    if (token != null && token.isNotEmpty) {
      // Token exists: Navigate to MyHomePage
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MyHomePage()),
      );
    } else {
      // No token: Navigate to InitialScreens
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const InitialScreens()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const SplashScreen(); // Display the splash screen while checking
  }
}

//AUTH SCREENS
class InitialScreens extends StatelessWidget {
  const InitialScreens({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor:
            Colors.transparent, // Set background color for the whole app
      ),
      home: BlocProvider<RemoteLoginBloc>(
        create: (context) => sl<
            RemoteLoginBloc>(), // Initialize the RemoteRegistrationBloc using your DI container
        child:
            const LoginPage(), // The RegisterPage is wrapped here with the bloc
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _pageController = PageController(initialPage: 0);
  final NotchBottomBarController _controller =
      NotchBottomBarController(index: 0);

  int maxCount = 4;

  /// To track the selected page index
  int _selectedPageIndex = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /// List of NAVBAR PAGES ONLY
    final List<Widget> bottomBarPages = [
      DashboardPage(controller: _controller),
      BlocProvider(
        create: (context) => sl<RemoteMattressBloc>()..add(GetAllMattresses()),
        child: MattressPage(),
      ),
      BlocProvider(
        create: (context) => sl<RemoteTypeBloc>()..add(GetTypesTiles()),
        child: MattressTypePage(),
      ),
      BlocProvider(
        create: (context) => sl<RemoteOrganizationBloc>()..add(GetOrganizations()),
        child: OrganizationPage(),
      ),
    ];

    /// Page titles based on the index
    final List<String> pageTitles = [
      "Dashboard",
      "Mattress",
      "Types",
      "Organization",
    ];

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor:
            HexColor("#E5E5E5"), // Set background color for the whole app
      ),
      home: Scaffold(
        body: Column(
          children: [
            Header(
              title: pageTitles[_selectedPageIndex]
            ), // Pass the dynamic title
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: bottomBarPages,
                onPageChanged: (index) {
                  setState(() {
                    _selectedPageIndex =
                        index; // Update the selected page index
                  });
                },
              ),
            ),
          ],
        ),
        extendBody: true,
        bottomNavigationBar: bottomBarPages.length <= maxCount
            ? AnimatedNotchBottomBar(
                notchBottomBarController: _controller,
                color: matcronPrimaryColor,
                showLabel: true,
                textOverflow: TextOverflow.visible,
                maxLine: 1,
                shadowElevation: 5,
                kBottomRadius: 28.0,
                notchColor: const Color.fromARGB(228, 197, 197, 197),
                removeMargins: false,
                bottomBarWidth: 500,
                showShadow: false,
                durationInMilliSeconds: 300,
                itemLabelStyle: const TextStyle(fontSize: 10),
                elevation: 1,
                bottomBarItems: const [
                  BottomBarItem(
                    inActiveItem: Icon(Icons.home_filled,
                        color: Color.fromARGB(255, 248, 250, 248)),
                    activeItem: Icon(Icons.home_filled,
                        color: Color.fromRGBO(30, 167, 169, 1)),
                    itemLabel: 'Dashboard',
                  ),
                  BottomBarItem(
                    inActiveItem: Icon(Icons.star,
                        color: Color.fromARGB(255, 248, 250, 248)),
                    activeItem: Icon(Icons.star,
                        color: Color.fromRGBO(30, 167, 169, 1)),
                    itemLabel: 'Mattress',
                  ),
                  BottomBarItem(
                    inActiveItem: Icon(Icons.settings,
                        color: Color.fromARGB(255, 248, 250, 248)),
                    activeItem: Icon(Icons.settings,
                        color: Color.fromRGBO(30, 167, 169, 1)),
                    itemLabel: 'Type',
                  ),
                  BottomBarItem(
                    inActiveItem: Icon(Icons.person,
                        color: Color.fromARGB(255, 248, 250, 248)),
                    activeItem: Icon(Icons.person,
                        color: Color.fromRGBO(30, 167, 169, 1)),
                    itemLabel: 'Firm',
                  ),
                ],
                onTap: (index) {
                  log('current selected index $index');
                  _pageController.jumpToPage(index);
                },
                kIconSize: 24.0,
              )
            : null,
      ),
    );
  }
}
