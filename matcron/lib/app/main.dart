import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matcron/app/features/auth/presentation/bloc/auth/remote/login/remote_login_bloc.dart';
import 'package:matcron/app/features/auth/presentation/pages/login.dart';
import 'package:matcron/app/features/dashboard/presentation/pages/dashboard.dart';
import 'package:matcron/app/features/organization/presentation/pages/organizations.dart';
import 'package:matcron/core/components/header/header.dart';
import 'package:matcron/core/components/splash_screen.dart';
import 'package:matcron/core/constants/constants.dart';
import 'dart:developer';
import 'dart:async';
import 'package:matcron/core/resources/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:matcron/app/injection_container.dart';
import 'package:matcron/config/theme/app_theme.dart';
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
      //home: const InitialScreens(),
      home: const SplashScreenWrapper(),
    );
  }
}

//Splash Screen
class SplashScreenWrapper extends StatefulWidget {
   const SplashScreenWrapper({super.key});

    @override
  State<SplashScreenWrapper> createState() => _SplashScreenWrapper();
}


class _SplashScreenWrapper extends State<SplashScreenWrapper> {
  @override
  void initState() {
    super.initState();

    // Delay for 3 seconds before navigating
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        // Check if the widget is still in the tree
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const InitialScreens(), // Navigate to InitialScreens
        ),
      );
      }
    });
  }
   @override
  Widget build(BuildContext context) {
    return const SplashScreen(); // Show the SplashScreen while waiting
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
        scaffoldBackgroundColor: HexColor("#E5E5E5"), // Set background color for the whole app
      ),
      home: BlocProvider<RemoteLoginBloc>(
        create: (_) => sl<RemoteLoginBloc>(), // Initialize the RemoteRegistrationBloc using your DI container
        child: const LoginPage(), // The RegisterPage is wrapped here with the bloc
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
      MattressPage(),
      SizedBox(),
      OrganizationPage(),
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
                title:
                    pageTitles[_selectedPageIndex]), // Pass the dynamic title
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
