import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matcron/app/features/profile_settings/presentation/pages/terms_condition.dart';
import 'package:matcron/app/features/auth/domain/entities/user_db_entity.dart';
import 'package:matcron/app/features/auth/presentation/bloc/auth/remote/login/remote_login_bloc.dart';
import 'package:matcron/app/features/auth/presentation/bloc/auth/remote/register/remote_registration_bloc.dart';
import 'package:matcron/app/features/auth/presentation/bloc/auth/remote/register/remote_registration_event.dart';
import 'package:matcron/app/features/auth/presentation/bloc/auth/remote/remote_auth_state.dart';
import 'package:matcron/app/features/auth/presentation/pages/login.dart';
import 'package:matcron/app/injection_container.dart';
import 'package:matcron/core/constants/constants.dart';


class OutlinedTextField extends StatefulWidget {
  final TextEditingController controller;
  final String placeholder;
  final TextInputType inputType;
  final String? autofillHint;
  final bool isPassword;

  const OutlinedTextField({
    Key? key,
    required this.controller,
    required this.placeholder,
    required this.inputType,
    this.autofillHint,
    this.isPassword = false,
  }) : super(key: key);

  @override
  State<OutlinedTextField> createState() => _OutlinedTextFieldState();
}

class _OutlinedTextFieldState extends State<OutlinedTextField> {
  bool _obscureText = false;

  @override
  void initState() {
    super.initState();
    // Hide text if it's a password field
    _obscureText = widget.isPassword;
  }

  void _toggleObscureText() {
    setState(() => _obscureText = !_obscureText);
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      keyboardType: widget.inputType,
      autofillHints:
          widget.autofillHint != null ? [widget.autofillHint!] : null,
      obscureText: _obscureText,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        hintText: widget.placeholder,
        hintStyle: TextStyle(color: Colors.grey[600]),
        fillColor: Colors.white,
        filled: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        // Less-rounded corners (~8 px) for a rectangular outline
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.transparent, width: 0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.transparent, width: 0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.transparent, width: 0),
        ),
        // Show a suffix icon to toggle password if isPassword == true
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                  color: Colors.grey[600],
                ),
                onPressed: _toggleObscureText,
              )
            : null,
      ),
    );
  }
}

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // Controllers for each field
  final TextEditingController firstNameController       = TextEditingController();
  final TextEditingController lastNameController        = TextEditingController();
  final TextEditingController emailController           = TextEditingController();
  final TextEditingController orgCodeController         = TextEditingController();
  final TextEditingController passwordController        = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  bool agreeToTerms    = false;
  String selectedLanguage = 'English'; // Default language

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, // Let body extend behind the app bar
      appBar: AppBar(
        toolbarHeight: 40, 
        backgroundColor: Colors.transparent, 
        elevation: 0, 
        automaticallyImplyLeading: false, 
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.language),
            onSelected: (value) => setState(() => selectedLanguage = value),
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
      body: BlocBuilder<RemoteRegistrationBloc, RemoteAuthState>(
        builder: (context, state) {
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

          if (state is RemoteAuthInitial) {
            return Stack(
              children: [
                // Background image with overlay
                Container(
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
                ),
                Center(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: _buildRegistrationForm(state),
                    ),
                  ),
                ),
              ],
            );
          }

          if (state is RemoteRegistrationDone) {
            // Show a Snackbar after building completes
            SchedulerBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Registration successful!"),
                  duration: Duration(seconds: 2),
                ),
              );
              // Navigate to login
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => BlocProvider<RemoteLoginBloc>(
                    create: (context) => sl<RemoteLoginBloc>(),
                    child: const LoginPage(),
                  ),
                ),
              );
            });
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
      ),
    );
  }

  Widget _buildRegistrationForm(RemoteAuthInitial state) {
    // Potential error messages from validation
    String? firstNameError;
    String? lastNameError;
    String? emailError;
    String? orgCodeError;
    String? passwordError;
    String? confirmPasswordError;

    switch (state.errorType) {
      case 'NAME':
        firstNameError = lastNameError = state.errorMessage;
        break;
      case 'EMAIL':
        emailError = state.errorMessage;
        break;
      case 'PASSWORD':
        passwordError = state.errorMessage;
        break;
      case 'CONFIRMPASSWORD':
        confirmPasswordError = state.errorMessage;
        break;
      case 'ORGANIZATION':
        orgCodeError = state.errorMessage;
        break;
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Logo
        Container(
          height: 75,
          alignment: Alignment.center,
          child: Image.asset(
            'assets/images/MATCRON_Logo.png',
            fit: BoxFit.contain,
            height: 100,
          ),
        ),
        const SizedBox(height: 10),

        // Title
        const Text(
          "Welcome to Matcron!",
          style: TextStyle(
            fontSize: 30, 
            fontWeight: FontWeight.bold, 
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          "Let's create an account",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: matcronPrimaryColor,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),

        // First Name & Last Name in a row
        Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  OutlinedTextField(
                    controller: firstNameController,
                    placeholder: "First Name",
                    inputType: TextInputType.name,
                  ),
                  if (firstNameError != null)
                    Text(
                      firstNameError,
                      style: const TextStyle(color: Colors.red, fontSize: 12),
                    ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                children: [
                  OutlinedTextField(
                    controller: lastNameController,
                    placeholder: "Last Name",
                    inputType: TextInputType.name,
                  ),
                  if (lastNameError != null)
                    Text(
                      lastNameError,
                      style: const TextStyle(color: Colors.red, fontSize: 12),
                    ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),

        // Email
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            OutlinedTextField(
              controller: emailController,
              placeholder: "Enter email",
              inputType: TextInputType.emailAddress,
            ),
            if (emailError != null)
              Text(
                emailError,
                style: const TextStyle(color: Colors.red, fontSize: 12),
              ),
          ],
        ),
        const SizedBox(height: 20),

        // Organization Code
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            OutlinedTextField(
              controller: orgCodeController,
              placeholder: "Enter organization code",
              inputType: TextInputType.text,
            ),
            if (orgCodeError != null)
              Text(
                orgCodeError,
                style: const TextStyle(color: Colors.red, fontSize: 12),
              ),
          ],
        ),
        const SizedBox(height: 20),

        // Password field with eye icon
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            OutlinedTextField(
              controller: passwordController,
              placeholder: "Enter a strong password",
              inputType: TextInputType.visiblePassword,
              isPassword: true,
            ),
            if (passwordError != null)
              Text(
                passwordError,
                style: const TextStyle(color: Colors.red, fontSize: 12),
              ),
          ],
        ),
        const SizedBox(height: 20),

        // Confirm Password field with eye icon
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            OutlinedTextField(
              controller: confirmPasswordController,
              placeholder: "Confirm password",
              inputType: TextInputType.visiblePassword,
              isPassword: true,
            ),
            if (confirmPasswordError != null)
              Text(
                confirmPasswordError,
                style: const TextStyle(color: Colors.red, fontSize: 12),
              ),
          ],
        ),
        const SizedBox(height: 10),

        // Terms & Conditions
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Checkbox(
              value: agreeToTerms,
              onChanged: (value) {
                setState(() {
                  agreeToTerms = value ?? false;
                });
              },
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const TermsAndConditionsPage(),
      ),
    );
              },
              child: const Text(
                "Agree to Terms and Conditions",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontStyle: FontStyle.normal,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),

        // Sign Up button (Rectangular with minimal radius to match fields)
        ElevatedButton(
          onPressed: agreeToTerms ? () => _register(context) : null,
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8), // same ~8 as fields
            ),
            padding: const EdgeInsets.symmetric(vertical: 16),
            minimumSize: const Size(double.infinity, 50),
            backgroundColor: matcronPrimaryColor,
          ),
          child: const Text(
            "Sign Up",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
        const SizedBox(height: 10),

        // Already have an account? Log In
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Already have an account?",
              style: TextStyle(color: Colors.black, fontSize: 14),
            ),
            const SizedBox(width: 5),
            GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => BlocProvider<RemoteLoginBloc>(
                    create: (_) => sl<RemoteLoginBloc>(),
                    child: const LoginPage(),
                  ),
                ),
              ),
              child: Text(
                "Log In",
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
    );
  }

  void _register(BuildContext context) {
    context.read<RemoteRegistrationBloc>().add(
      RegisterUser(
        UserRegistrationEntity(
          firstName: firstNameController.text,
          lastName: lastNameController.text,
          email: emailController.text,
          password: passwordController.text,
          organisationCode: orgCodeController.text,
        ),
        confirmPasswordController.text,
      ),
    );
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    orgCodeController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}
