import 'package:flutter/material.dart';
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
    return BlocProvider<RemoteRegistrationBloc>(
      create: (context) => sl<RemoteRegistrationBloc>(),
      child: Scaffold(
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
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return BlocBuilder<RemoteRegistrationBloc, RemoteAuthState>(
      builder: (_, state) {
        if (state is RemoteAuthLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is RemoteAuthInitial) {
          return Stack(
            children: [
              // Background Image
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/bed.jpg'), // Path to your image
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.09), // Reduce opacity
                      BlendMode.darken,
                    ),
                  ),
                ),
              ),
              // Form Content with Blur Effect
        //       Center(
        //         child: SizedBox(
        //           width: 325,
        //           child: SingleChildScrollView(
        //             child: ClipRRect(
        //               borderRadius: BorderRadius.circular(20), // Rounded edges
        //               child: BackdropFilter(
        //                 filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10), // Blur effect
        //                 child: Container(
        //                   color: Colors.white.withOpacity(0.6), // Semi-transparent white background
        //                   padding: const EdgeInsets.all(16),
        //                   child: _buildRegistrationForm(),
        //                 ),
        //               ),
        //             ),
        //           ),
        //         ),
        //       ),
        //     ],
        //   );
        // }
            Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: _buildRegistrationForm(),
                  ),
                ),
              ),
            ],
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

  Widget _buildRegistrationForm() {
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
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          "Let's create an account",
          style: TextStyle(fontSize: 28, fontWeight:FontWeight.bold, color: matcronPrimaryColor),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),

        // First and Last Name Fields
        Row(
          children: [
            Expanded(
              child: RoundedTextField(
                controller: firstNameController,
                placeholder: "First Name",
                inputType: TextInputType.name,
                autofillHint: AutofillHints.givenName,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: RoundedTextField(
                controller: lastNameController,
                placeholder: "Last Name",
                inputType: TextInputType.name,
                autofillHint: AutofillHints.familyName,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),

        // Other Fields
        RoundedTextField(
          controller: emailController,
          placeholder: "Enter email",
          inputType: TextInputType.emailAddress,
          autofillHint: AutofillHints.email,
        ),
        const SizedBox(height: 20),
        RoundedTextField(
          controller: orgCodeController,
          placeholder: "Enter organization code",
          inputType: TextInputType.text,
        ),
        const SizedBox(height: 20),
        RoundedTextField(
          controller: passwordController,
          placeholder: "Enter a strong password",
          inputType: TextInputType.visiblePassword,
          autofillHint: AutofillHints.newPassword,
        ),
        const SizedBox(height: 20),
        RoundedTextField(
          controller: confirmPasswordController,
          placeholder: "Confirm password",
          inputType: TextInputType.visiblePassword,
          autofillHint: AutofillHints.newPassword,
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
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8)),
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
                "Sign In",
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
