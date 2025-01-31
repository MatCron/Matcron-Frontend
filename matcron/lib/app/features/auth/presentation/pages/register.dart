import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Import your real references as needed:
import 'package:matcron/app/features/auth/domain/entities/user_db_entity.dart';
import 'package:matcron/app/features/auth/presentation/bloc/auth/remote/login/remote_login_bloc.dart';
import 'package:matcron/app/features/auth/presentation/bloc/auth/remote/register/remote_registration_bloc.dart';
import 'package:matcron/app/features/auth/presentation/bloc/auth/remote/register/remote_registration_event.dart';
import 'package:matcron/app/features/auth/presentation/bloc/auth/remote/remote_auth_state.dart';
import 'package:matcron/app/features/auth/presentation/pages/login.dart';
import 'package:matcron/app/injection_container.dart';
import 'package:matcron/core/constants/constants.dart';

/// A custom text field with a uniform, rounded border.
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
        hintText: placeholder,
        hintStyle: TextStyle(color: Colors.grey[600]),
        fillColor: Colors.white,
        filled: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30), // Rounded corners
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Colors.transparent),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Colors.transparent),
        ),
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
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController  = TextEditingController();
  final TextEditingController emailController     = TextEditingController();
  final TextEditingController orgCodeController   = TextEditingController();
  final TextEditingController passwordController  = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  bool agreeToTerms    = false;
  String selectedLanguage = 'English'; // Default language

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, // Let the body extend behind the app bar
      appBar: AppBar(
        toolbarHeight: 40,
        backgroundColor: Colors.transparent,
        elevation: 0, // No shadow
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
            // If registration is successful, show a snackbar and navigate
            SchedulerBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Registration successful!"),
                  duration: Duration(seconds: 2),
                ),
              );
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

        const Text(
          "Welcome to Matcron!",
          style: TextStyle(
            fontSize: 20, 
            fontWeight: FontWeight.bold, 
            color: Colors.white,
          ),
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

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
        const SizedBox(height: 20),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
        const SizedBox(height: 20),

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
          onPressed: agreeToTerms ? () => _register(context) : null,
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
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
