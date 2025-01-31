import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matcron/app/features/auth/domain/entities/user_db_entity.dart';
import 'package:matcron/app/features/auth/presentation/bloc/auth/remote/login/remote_login_bloc.dart';
import 'package:matcron/app/features/auth/presentation/bloc/auth/remote/login/remote_login_event.dart';
import 'package:matcron/app/features/auth/presentation/bloc/auth/remote/register/remote_registration_bloc.dart';
import 'package:matcron/app/features/auth/presentation/bloc/auth/remote/remote_auth_state.dart';
import 'package:matcron/app/features/auth/presentation/pages/register.dart';
import 'package:matcron/app/features/auth/presentation/widgets/rounded_text_field.dart';
import 'package:matcron/app/injection_container.dart';
import 'package:matcron/app/main.dart';
import 'package:matcron/core/constants/constants.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class RoundedTextField extends StatelessWidget {
  final TextEditingController controller;
  final String placeholder;
  final TextInputType inputType;
  final String? autofillHint;

  const RoundedTextField({
    Key? key,
    required this.controller,
    required this.placeholder,
    required this.inputType,
    this.autofillHint,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: inputType,
      autofillHints: autofillHint != null ? [autofillHint!] : null,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        hintText: placeholder,
        hintStyle: TextStyle(color: Colors.grey[600]),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.transparent),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.transparent),
        ),
      ),
    );
  }
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController    = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String selectedLanguage = 'English'; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, 
      appBar: AppBar(
        toolbarHeight: 40,
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.language),
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
    );
  }

  Widget _buildBody(BuildContext context) {
    return BlocBuilder<RemoteLoginBloc, RemoteAuthState>(
      builder: (_, state) {
        // Loading spinner
        if (state is RemoteAuthLoading) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(matcronPrimaryColor),
              ),
            ),
          );
        }

        // Initial or no error state
        if (state is RemoteAuthInitial) {
          String? emailError;
          String? passwordError;

          switch (state.errorType) {
            case 'EMAIL':
              emailError = state.errorMessage;
              break;
            case 'PASSWORD':
              passwordError = state.errorMessage;
              break;
          }

          return Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: const AssetImage('assets/images/bed.jpg'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.35),
                  BlendMode.darken,
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
                      // Logo
                      SizedBox(
                        height: 80,
                        child: Image.asset(
                          'assets/images/MATCRON_Logo.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                      const SizedBox(height: 30),

                      // Title
                      const Text(
                        "Welcome to Matcron!",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
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
                      if (emailError != null)
                        Text(
                          emailError,
                          style: const TextStyle(color: Colors.red, fontSize: 12),
                        ),
                      const SizedBox(height: 30),

                      // Password Field
                      RoundedTextField(
                        controller: passwordController,
                        placeholder: "Enter password",
                        inputType: TextInputType.visiblePassword,
                        autofillHint: AutofillHints.password,
                      ),
                      if (passwordError != null)
                        Text(
                          passwordError,
                          style: const TextStyle(color: Colors.red, fontSize: 12),
                        ),
                      const SizedBox(height: 15),

             
                      Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () {
                          
                          },
                          child: const Text(
                            "Forgot Password?",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),

                      // Log In Button
                      ElevatedButton(
                        onPressed: () => login(context),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          minimumSize: const Size(double.infinity, 50),
                          backgroundColor: matcronPrimaryColor,
                        ),
                        child: const Text(
                          "Log In",
                          style: TextStyle(color: Colors.white, fontSize: 25),
                        ),
                      ),
                      const SizedBox(height: 18),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Divider(
                              color: Colors.white,
                              thickness: 1,
                              endIndent: 10,
                            ),
                          ),
                          const Text(
                            'or',
                            style: TextStyle(
                              color: Colors.white70,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              color: Colors.white,
                              thickness: 1,
                              indent: 10,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // Sign Up (Outlined) Button
                      OutlinedButton(
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
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.white, width: 2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          minimumSize: const Size(double.infinity, 50),
                        ),
                        child: const Text(
                          "Sign Up",
                          style: TextStyle(color: Colors.white, fontSize: 25),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }

        // On login success
        if (state is RemoteAuthDone) {
          SchedulerBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Welcome Back, ${state.user?.firstName} ${state.user?.lastName}!"),
                duration: const Duration(seconds: 2),
              ),
            );
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const MyHomePage(),
              ),
              (Route<dynamic> route) => false,
            );
          });
        }

        // If there's an exception
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
    context.read<RemoteLoginBloc>().add(
      Login(
        UserLoginEntity(
          email: emailController.text,
          password: passwordController.text,
        ),
      ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
