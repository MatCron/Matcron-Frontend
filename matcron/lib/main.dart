import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matcron/app/features/auth/presentation/bloc/auth/remote/login/remote_login_bloc.dart';
import 'package:matcron/app/features/auth/presentation/pages/login.dart';
import 'package:matcron/app/features/dashboard/presentation/pages/dashboard.dart';
import 'package:matcron/app/features/mattress/domain/entities/mattress.dart';
import 'package:matcron/app/features/group/presentation/pages/group_page.dart';
import 'package:matcron/app/features/mattress/presentation/bloc/remote_mattress_bloc.dart';
import 'package:matcron/app/features/mattress/presentation/bloc/remote_mattress_event.dart';
import 'package:matcron/app/features/organization/presentation/bloc/remote_org_bloc.dart';
import 'package:matcron/app/features/organization/presentation/bloc/remote_org_event.dart';
import 'package:matcron/app/features/type/presentation/bloc/remote_type_bloc.dart';
import 'package:matcron/app/features/type/presentation/bloc/remote_type_event.dart';
import 'package:matcron/app/features/type/presentation/pages/type.dart';
import 'package:matcron/config/languages.dart';
import 'package:matcron/core/components/header/header.dart';
import 'package:matcron/core/components/splash_screen.dart';
import 'dart:async';
import 'package:matcron/core/resources/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:matcron/app/injection_container.dart';
import 'package:matcron/config/theme/app_theme.dart';
import 'package:matcron/config/theme/theme_cubit.dart';
import 'package:matcron/core/resources/authorization.dart';
import 'package:matcron/core/resources/language_provider.dart';
import 'app/features/mattress/presentation/pages/mattress_page.dart';
import 'package:provider/provider.dart'; // Add this import for MultiProvider


void main() async {
  await initializeDependencies();
  runApp(
    MultiProvider(
      providers: [
        // Add your ThemeCubit provider here
        BlocProvider(
          create: (context) => ThemeCubit(),
        ),
        // Add the LanguageProvider here
        ChangeNotifierProvider(
          create: (context) => LanguageProvider()..loadLanguage(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, themeMode) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: lightTheme(),
          darkTheme: darkTheme(),
          themeMode: themeMode,
          home: const SplashScreenWrapper(),
        );
      },
    );
  }
}

// Splash Screen
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
    Future.delayed(const Duration(seconds: 5), _checkAuthToken);
  }

  Future<void> _checkAuthToken() async {
    String? token = await _authService.getToken();
    bool? tokenExpired = await _authService.isTokenExpired();

    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => token != null && token.isNotEmpty && !tokenExpired
            ? const MyHomePage()
            : const InitialScreens(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const SplashScreen();
  }
}

// Authentication Screens
class InitialScreens extends StatelessWidget {
  const InitialScreens({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RemoteLoginBloc>(
      create: (context) => sl<RemoteLoginBloc>(),
      child: const LoginPage(),
    );
  }
}

// Main Home Page with Bottom Navigation
class MyHomePage extends StatefulWidget {
  final MattressEntity? searchedEntity;
  final int startPageIndex;

  const MyHomePage({super.key, this.searchedEntity, this.startPageIndex = 0});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _pageController = PageController();
  final NotchBottomBarController _controller = NotchBottomBarController(index: 0);
  int _selectedPageIndex = 0;
  String? language;
  late LanguageProvider languageProvider;

  @override
  void initState() {
    super.initState();
    languageProvider = Provider.of<LanguageProvider>(context, listen: false);
    _initializeLanguage();
    _selectedPageIndex = widget.startPageIndex;
    _controller.index = _selectedPageIndex;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _pageController.jumpToPage(_selectedPageIndex);
    });
    
  }

  Future<void> _initializeLanguage() async {
    String? lang = await AuthorizationService().getLanguage();
    setState(() {
      language = lang ?? "EN"; // Default to "EN" if null
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final List<Widget> bottomBarPages = [
      DashboardPage(controller: _controller),
      BlocProvider(create: (context) => sl<RemoteMattressBloc>()..add(GetAllMattresses()), child: MattressPage(widget.searchedEntity)),
      BlocProvider(create: (context) => sl<RemoteTypeBloc>()..add(GetTypesTiles()), child: MattressTypePage()),
      BlocProvider(create: (context) => sl<RemoteOrganizationBloc>()..add(GetOrganizations()), child: GroupPage()),
    ];

    return Scaffold(
      body: Column(
        children: [
          Consumer<LanguageProvider>(
            builder: (context, languageProvider, child) {
              return Header(
                title: [
                  languages[languageProvider.currentLanguage]!["Header"]!["Dashboard"]!,
                  languages[languageProvider.currentLanguage]!["Header"]!["Mattress"]!,
                  languages[languageProvider.currentLanguage]!["Header"]!["Types"]!,
                  languages[languageProvider.currentLanguage]!["Header"]!["Group"]!,
                ][_selectedPageIndex],
              );
            },
          ),
          Expanded(
            child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: bottomBarPages,
              onPageChanged: (index) {
                setState(() => _selectedPageIndex = index);
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: AnimatedNotchBottomBar(
  notchBottomBarController: _controller,
  showLabel: true,
  kIconSize: 24.0, // Added required icon size
  kBottomRadius: 28.0, // Added required bottom radius
  bottomBarItems:   [
    BottomBarItem(
      inActiveItem: Icon(Icons.dashboard, color: theme.colorScheme.onSurface),
      activeItem: Icon(Icons.dashboard, color: theme.colorScheme.primary), // Use theme color
      itemLabel: 'Dashboard',
    ),
    BottomBarItem(
      inActiveItem: Icon(Icons.bed, color: theme.colorScheme.onSurface),
      activeItem: Icon(Icons.bed, color: theme.colorScheme.primary), // Use theme color
      itemLabel: 'Mattress',
    ),
    BottomBarItem(
      inActiveItem: Icon(Icons.category, color: theme.colorScheme.onSurface),
      activeItem: Icon(Icons.category, color: theme.colorScheme.primary), // Use theme color
      itemLabel: 'Type',
    ),
    BottomBarItem(
      inActiveItem: Icon(Icons.groups, color: theme.colorScheme.onSurface),
      activeItem: Icon(Icons.groups, color: theme.colorScheme.primary), // Use theme color
      itemLabel: 'Group',
    ),
  ],
  onTap: (index) {
    _pageController.jumpToPage(index);
  },
),
    );
  }
}
