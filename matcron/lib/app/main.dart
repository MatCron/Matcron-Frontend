// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matcron/app/features/auth/presentation/bloc/auth/remote/login/remote_login_bloc.dart';
import 'package:matcron/app/features/auth/presentation/bloc/auth/remote/register/remote_registration_bloc.dart';
import 'package:matcron/app/features/auth/presentation/pages/login.dart';
import 'package:matcron/app/features/auth/presentation/pages/register.dart';
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
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MattressPage()),
                );
              },
              child: const Text("Go to Mattress Page"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BlocProvider<RemoteRegistrationBloc>(
                      create: (_) => sl<RemoteRegistrationBloc>(),
                      child: const RegisterPage(),
                    ),
                  ),
                );
              },
              child: const Text("Go to Register Page"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BlocProvider<RemoteLoginBloc>(
                      create: (_) => sl<RemoteLoginBloc>(),
                      child: const LoginPage(),
                    ),
                  ),
                );
              },
              child: const Text("Go to Login Page"),
            ),
          ],
        ),
      ),
    );
  }
}
