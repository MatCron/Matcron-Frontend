import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matcron/app/features/auth/domain/entities/user_db_entity.dart';
import 'package:matcron/app/features/auth/presentation/bloc/auth/remote/login/remote_login_bloc.dart';
import 'package:matcron/app/features/auth/presentation/bloc/auth/remote/register/remote_registration_bloc.dart';
import 'package:matcron/app/features/auth/presentation/bloc/auth/remote/register/remote_registration_event.dart';
import 'package:matcron/app/features/auth/presentation/bloc/auth/remote/remote_auth_state.dart';
import 'package:matcron/app/features/auth/presentation/pages/login.dart';
import 'package:matcron/app/features/auth/presentation/widgets/rounded_text_field.dart';
import 'package:matcron/app/injection_container.dart';
import 'package:matcron/core/constants/constants.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController orgCodeController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool agreeToTerms = false;

  String selectedLanguage = 'English'; // Default language

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, // Allow body to extend behind the app bar
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
    );
  }

  Widget _buildBody(BuildContext context) {
    return BlocBuilder<RemoteRegistrationBloc, RemoteAuthState>(
      builder: (_, state) {
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
              // Background Image
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                        'assets/images/bed.jpg'), // Path to your image
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.35), // Reduce opacity
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
          // Show a Snackbar after the build phase completes
          SchedulerBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Registration successful!"),
                duration: const Duration(seconds: 2),
              ),
            );

            // Immediately navigate to the login screen
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
    );
  }

  Widget _buildRegistrationForm(RemoteAuthInitial state) {
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

        // Welcome Text
        const Text(
          "Welcome to Matcron!",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          "Let's create an account",
          style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: matcronPrimaryColor,
            ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),

        // First and Last Name Fields with Errors
        Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  RoundedTextField(
                    controller: firstNameController,
                    placeholder: "First Name",
                    inputType: TextInputType.name,
                    autofillHint: AutofillHints.givenName,
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
                  RoundedTextField(
                    controller: lastNameController,
                    placeholder: "Last Name",
                    inputType: TextInputType.name,
                    autofillHint: AutofillHints.familyName,
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

        // Email Field with Error
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
          ],
        ),
        const SizedBox(height: 20),

        // Organization Code Field with Error
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RoundedTextField(
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

        // Password Field with Error
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RoundedTextField(
              controller: passwordController,
              placeholder: "Enter a strong password",
              inputType: TextInputType.visiblePassword,
              autofillHint: AutofillHints.newPassword,
            ),
            if (passwordError != null)
              Text(
                passwordError,
                style: const TextStyle(color: Colors.red, fontSize: 12),
              ),
          ],
        ),
        const SizedBox(height: 20),

        // Confirm Password Field with Error
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RoundedTextField(
              controller: confirmPasswordController,
              placeholder: "Confirm password",
              inputType: TextInputType.visiblePassword,
              autofillHint: AutofillHints.newPassword,
            ),
            if (confirmPasswordError != null)
              Text(
                confirmPasswordError,
                style: const TextStyle(color: Colors.red, fontSize: 12),
              ),
          ],
        ),
        const SizedBox(height: 10),

        // Terms and Conditions Checkbox
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
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
                // Navigate to Terms and Conditions
              },
              child: const Text(
                "Agree to Terms and Conditions",
                style: TextStyle(
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),

        // Sign Up Button
        ElevatedButton(
          onPressed: agreeToTerms
              ? () {
                  register(context);
                }
              : null,
          style: ElevatedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
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

        // Sign In Link
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
                  builder: (context) => BlocProvider<RemoteLoginBloc>(
                    create: (context) => sl<RemoteLoginBloc>(),
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

  void register(BuildContext context) {
    context.read<RemoteRegistrationBloc>().add(
          RegisterUser(
              UserRegistrationEntity(
                firstName: firstNameController.text,
                lastName: lastNameController.text,
                email: emailController.text,
                password: passwordController.text,
                organisationCode: orgCodeController.text,
              ),
              confirmPasswordController.text),
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
