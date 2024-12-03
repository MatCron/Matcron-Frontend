import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matcron/app/features/auth/domain/entities/user_db_entity.dart';
import 'package:matcron/app/features/auth/presentation/bloc/auth/remote/login/remote_login_bloc.dart';
import 'package:matcron/app/features/auth/presentation/bloc/auth/remote/login/remote_login_event.dart';
import 'package:matcron/app/features/auth/presentation/bloc/auth/remote/register/remote_registration_bloc.dart';
import 'package:matcron/app/features/auth/presentation/bloc/auth/remote/remote_auth_state.dart';
import 'package:matcron/app/features/auth/presentation/pages/register.dart';
import 'package:matcron/app/features/auth/presentation/widgets/rounded_text_field.dart';
import 'package:matcron/app/injection_container.dart';
import 'package:matcron/core/constants/constants.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // TextEditingControllers for email and password fields
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String selectedLanguage = 'English'; // Default language

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RemoteLoginBloc>(
      create: (context) => sl(),
      child: Scaffold(
        extendBodyBehindAppBar: true, // Extend the body behind the app bar
        appBar: AppBar(
          toolbarHeight: 40, // Minimal height
          backgroundColor: Colors.transparent, // Transparent background
          elevation: 0, // No shadow
          automaticallyImplyLeading: false, // No back button
          actions: [
            PopupMenuButton<String>(
              icon: const Icon(Icons.language), // Language icon
              onSelected: (value) {
                setState(() {
                  selectedLanguage = value;
                });
              },
              itemBuilder: (BuildContext context) {
                return ['English', 'German', 'Spanish'].map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              },
            ),
          ],
        ),
        body: _buildBody(context),
      ),
    );
  }
Widget _buildBody(BuildContext context) {
  return BlocBuilder<RemoteLoginBloc, RemoteAuthState>(
    builder: (_, state) {
      if (state is RemoteAuthLoading) {
        return const Center(child: CircularProgressIndicator());
      }

      if (state is RemoteAuthInitial) {
        return Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/bed.jpg'), // Path to your image
              fit: BoxFit.cover, // Cover the entire screen
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0), BlendMode.darken
              ),
            ),
          ),
          child: Center(
            child: SizedBox(
              width: 325,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 75,
                      alignment: Alignment.center,
                      child: Image.asset(
                        'assets/images/MATCRON_Logo.png',
                        fit: BoxFit.contain,
                        height: 100,
                      ),
                    ),
                    const SizedBox(height: 30),
                    const Text(
                      "Welcome Back!",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 30),

                    // Email Field
                    RoundedTextField(
                      controller: emailController,
                      placeholder: "Enter email",
                      inputType: TextInputType.emailAddress,
                      autofillHint: AutofillHints.email,
                    ),
                    const SizedBox(height: 30),

                    // Password Field
                    RoundedTextField(
                      controller: passwordController,
                      placeholder: "Enter password",
                      inputType: TextInputType.visiblePassword,
                      autofillHint: AutofillHints.password,
                    ),
                    const SizedBox(height: 15),

                    // Forgot Password
                    GestureDetector(
                      onTap: () {
                        // Navigate to Forgot Password screen
                      },
                      child: Text(
                        "Forgot Password?",
                        style: TextStyle(
                          color: matcronPrimaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 28,
                        ),
                      ),
                    ),
                    const SizedBox(height: 35),

                    // Sign In Button
                    ElevatedButton(
                      onPressed: () {
                        login(context);
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        minimumSize: const Size(double.infinity, 50),
                        backgroundColor: matcronPrimaryColor,
                      ),
                      child: const Text(
                        "Sign In",
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ),
                    ),
                    const SizedBox(height: 25),

                    // Sign Up Link
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don't have an account?",
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                        const SizedBox(width: 5),
                        GestureDetector(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  BlocProvider<RemoteRegistrationBloc>(
                                create: (context) =>
                                    sl<RemoteRegistrationBloc>(),
                                child: const RegisterPage(),
                              ),
                            ),
                          ),
                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                              color: matcronPrimaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 23,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }

      if (state is RemoteAuthException) {
        return Center(
          child: Text(
            "Error: ${state.exception}",
            style: const TextStyle(color: Colors.red),
          ),
        );
      }

      return const SizedBox();
    },
  );
}




  void login(BuildContext context) {
    context.read<RemoteLoginBloc>().add(Login(UserLoginEntity(
          email: emailController.text,
          password: passwordController.text,
        )));
  }

  @override
  void dispose() {
    // Dispose controllers when the widget is removed
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
