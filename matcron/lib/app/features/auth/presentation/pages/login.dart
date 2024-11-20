import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matcron/app/features/auth/presentation/bloc/auth/remote/login/remote_login_bloc.dart';
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

  @override
  void initState() {
    super.initState();

    // Add listeners to the controllers
    emailController.addListener(() {
      debugPrint("Email field changed: ${emailController.text}");
    });

    passwordController.addListener(() {
      debugPrint("Password field changed: ${passwordController.text}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RemoteLoginBloc>(
      create: (context) => sl(),
      child: Scaffold(
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
          return Center(
            child: SizedBox(
              width: 325,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 30),
                    const Text(
                      "Welcome Back!",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
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
                          fontSize: 20,
                        ),
                      ),
                    ),
                    const SizedBox(height: 35),

                    // Sign In Button
                    ElevatedButton(
                      onPressed: () {
                        // context.read<RemoteLoginBloc>().add(
                        //       Login(
                        //         UserLoginEntity(
                        //           email: emailController.text,
                        //           password: passwordController.text,
                        //         )
                        //       ),
                        //     );
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        minimumSize: const Size(double.infinity, 60),
                        backgroundColor: matcronPrimaryColor,
                      ),
                      child: const Text(
                        "Sign In",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                    const SizedBox(height: 20),

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
                            MaterialPageRoute(builder: (context) => const RegisterPage()),
                          ),
                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                              color: matcronPrimaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
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

  @override
  void dispose() {
    // Dispose controllers when the widget is removed
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}

