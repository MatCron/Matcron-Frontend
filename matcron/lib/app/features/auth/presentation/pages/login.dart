import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matcron/app/features/auth/domain/entities/user_db_entity.dart';
import 'package:matcron/app/features/auth/presentation/bloc/auth/remote/login/remote_login_bloc.dart';
import 'package:matcron/app/features/auth/presentation/bloc/auth/remote/login/remote_login_event.dart';
//import 'package:matcron/app/features/auth/presentation/bloc/auth/remote/register/remote_registration_bloc.dart';
import 'package:matcron/app/features/auth/presentation/bloc/auth/remote/remote_auth_state.dart';
import 'package:matcron/config/languages.dart';
import 'package:matcron/core/resources/authorization.dart';
import 'package:matcron/core/resources/language_provider.dart';
//import 'package:matcron/app/features/auth/presentation/pages/register.dart';
//import 'package:matcron/app/injection_container.dart';
//import 'package:matcron/app/features/auth/presentation/pages/register.dart';
//import 'package:matcron/app/injection_container.dart';
import 'package:matcron/main.dart';
import 'package:matcron/core/constants/constants.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class RoundedTextField extends StatefulWidget {
  final TextEditingController controller;
  final String placeholder;
  final TextInputType inputType;
  final String? autofillHint;
  final bool isPassword;

  const RoundedTextField({
    super.key,
    required this.controller,
    required this.placeholder,
    required this.inputType,
    this.autofillHint,
    this.isPassword = false,
  });

  @override
  State<RoundedTextField> createState() => _RoundedTextFieldState();
}

class _RoundedTextFieldState extends State<RoundedTextField> {
  bool _obscureText = true;

  void _toggleObscureText() {
    setState(() => _obscureText = !_obscureText);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextField(
      controller: widget.controller,
      keyboardType: widget.inputType,
      autofillHints:
          widget.autofillHint != null ? [widget.autofillHint!] : null,
      obscureText: widget.isPassword ? _obscureText : false,
      style: TextStyle(color: theme.colorScheme.onSurface),
      decoration: InputDecoration(
        fillColor: theme.colorScheme.surface,
        filled: true,
        hintText: widget.placeholder,
        hintStyle: TextStyle(color: theme.colorScheme.shadow),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
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
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                  color: theme.colorScheme.shadow,
                ),
                onPressed: _toggleObscureText,
              )
            : null,
      ),
    );
  }
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String selectedLanguage = 'EN';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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
            onSelected: (value) async {
              // Pass the correct language code to setLanguage
              String languageCode = value == 'English'
                  ? 'EN'
                  : value == 'German'
                      ? 'DE'
                      : 'ES';

              final languageProvider = Provider.of<LanguageProvider>(context, listen: false);
              await languageProvider.setLanguage(languageCode);
                // Update language globally
              setState(() {
                selectedLanguage = languageCode;
              });

              

              AuthorizationService().setLanguage(languageCode);
            },
            itemBuilder: (BuildContext context) {
              return ['English', 'German', 'Spanish'].map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice, style: theme.textTheme.bodyMedium),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: _buildBody(context, theme),
    );
  }

  Widget _buildBody(BuildContext context, ThemeData theme) {
    return BlocBuilder<RemoteLoginBloc, RemoteAuthState>(
      builder: (_, state) {
        // Loading spinner
        if (state is RemoteAuthLoading) {
          return Scaffold(
            backgroundColor: theme.colorScheme.surface,
            body: Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(theme.colorScheme.primary),
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
                  theme.colorScheme.onSurface.withOpacity(0.35),
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
                      Text(
                        languages[selectedLanguage]!["Login"]!["WelcomeToMatcron!"]!,
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.surface,
                        ),
                      ),
                      const SizedBox(height: 30),

                      // Email Field
                      RoundedTextField(
                        controller: emailController,
                        placeholder: languages[selectedLanguage]!["Login"]!["EnterEmail"]!,
                        inputType: TextInputType.emailAddress,
                        autofillHint: AutofillHints.email,
                      ),
                      if (emailError != null)
                        Text(
                          emailError,
                          style: TextStyle(
                              color: theme.colorScheme.error, fontSize: 12),
                        ),
                      const SizedBox(height: 30),

                      // Password Field
                      RoundedTextField(
                        controller: passwordController,
                        placeholder: languages[selectedLanguage]!["Login"]!["EnterPassword"]!,
                        inputType: TextInputType.visiblePassword,
                        isPassword: true,
                      ),
                      if (passwordError != null)
                        Text(
                          passwordError,
                          style: TextStyle(
                              color: theme.colorScheme.error, fontSize: 12),
                        ),
                      const SizedBox(height: 15),

                      Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () {},
                          child: Text(
                            languages[selectedLanguage]!["Login"]!["ForgotPassword"]!,
                            style: TextStyle(
                              color: theme.colorScheme.surface,
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
                        child: Text(
                          languages[selectedLanguage]!["Login"]!["LogIn"]!,
                          style: TextStyle(
                              color: theme.colorScheme.surface, fontSize: 25),
                        ),
                      ),
                      const SizedBox(height: 18),
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
                content: Text(
                    "${languages[selectedLanguage]!["Login"]!["WelcomeBack"]!}, ${state.user?.firstName} ${state.user?.lastName}!"),
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
              style: TextStyle(color: theme.colorScheme.error),
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
