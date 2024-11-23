import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matcron/app/features/auth/domain/entities/user_db_entity.dart';
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
  // TextEditingControllers for form fields
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController orgCodeController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  

  // Checkbox state
  bool agreeToTerms = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RemoteRegistrationBloc>(
      create: (context) => sl<RemoteRegistrationBloc>(),
      child: Scaffold(
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
          return Center(
            child: SizedBox(
              width: 325,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 30),
                    const Text(
                      "Welcome to Matcron!",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Let's create an account",
                      style: TextStyle(fontSize: 24, color: matcronPrimaryColor),
                    ),
                    const SizedBox(height: 30),

                    // First Name and Last Name
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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

                    const SizedBox(height: 30),
                    // Organization Code
                    RoundedTextField(
                      controller: emailController,
                      placeholder: "Enter email",
                      inputType: TextInputType.emailAddress,
                      autofillHint: AutofillHints.email,
                    ),
                    const SizedBox(height: 30),

                    // Organization Code
                    RoundedTextField(
                      controller: orgCodeController,
                      placeholder: "Enter organization code",
                      inputType: TextInputType.text,
                    ),
                    const SizedBox(height: 30),

                    // Password
                    RoundedTextField(
                      controller: passwordController,
                      placeholder: "Enter a strong password",
                      inputType: TextInputType.visiblePassword,
                      autofillHint: AutofillHints.newPassword,
                    ),
                    const SizedBox(height: 30),

                    // Confirm Password
                    RoundedTextField(
                      controller: confirmPasswordController,
                      placeholder: "Confirm password",
                      inputType: TextInputType.visiblePassword,
                      autofillHint: AutofillHints.newPassword,
                    ),
                    const SizedBox(height: 20),

                    // Checkbox for terms and conditions
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
                              
                              // // Trigger Sign Up
                              // context.read<RemoteRegistrationBloc>().add(
                              //   RegisterUser(UserRegistrationEntity(
                              //       firstName: firstNameController.text, 
                              //       lastName: lastNameController.text, 
                              //       email: emailController.text, 
                              //       password: passwordController.text, 
                              //       organisationCode: orgCodeController.text
                              //       )
                              //   )
                              // );
                            }
                          : null, // Disable button if terms are not agreed
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        minimumSize: const Size(double.infinity, 60),
                        backgroundColor: matcronPrimaryColor,
                      ),
                      child: const Text(
                        "Sign Up",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Sign In link
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Already have an account?",
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                        const SizedBox(width: 5),
                        GestureDetector(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const LoginPage()),
                          ),
                          child: Text(
                            "Sign In",
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

  bool isValidCredentials() {
    //STRING
    if (firstNameController.text.isEmpty) {
      return false;
    }


    if (lastNameController.text.isEmpty) {
      return false;
    }

    if (orgCodeController.text.isEmpty) {

    }

    if (passwordController.text.isEmpty) {
      return false;
    }

    if (confirmPasswordController.text.isEmpty) {
      
    }

    return true;
  }

  void register(BuildContext context) {
    context.read<RemoteRegistrationBloc>().add(
      RegisterUser(
        UserRegistrationEntity(
          firstName: firstNameController.text, 
          lastName: lastNameController.text, 
          email: firstNameController.text, 
          password: passwordController.text, 
          organisationCode: orgCodeController.text
        )
      )
    );
  }

  @override
  void dispose() {
    // Dispose controllers when the widget is removed
    firstNameController.dispose();
    lastNameController.dispose();
    orgCodeController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}
