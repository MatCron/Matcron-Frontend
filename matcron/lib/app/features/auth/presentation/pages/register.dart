import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matcron/app/features/auth/presentation/bloc/auth/remote/register/remote_registration_bloc.dart';
import 'package:matcron/app/features/auth/presentation/bloc/auth/remote/remote_auth_state.dart';
import 'package:matcron/app/features/auth/presentation/pages/login.dart';
import 'package:matcron/app/features/auth/presentation/widgets/rounded_text_field.dart';
import 'package:matcron/app/injection_container.dart';
import 'package:matcron/core/constants/constants.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RemoteRegistrationBloc>(
      create: (context) => sl(),
      child: Scaffold(
        body: _buildBody(context),
      ),
    );
  }

  

  _buildBody(context) {
    return BlocBuilder<RemoteRegistrationBloc, RemoteAuthState>(
      builder: (_, state) {
        // If state loading, display the same page but make the button greyed out
        if (state is RemoteAuthLoading) {
          return const Center(child: Text("Loading"));
        }
        // If state is initial, show Registration Page, will handle client side errors
        if (state is RemoteAuthInitial) {
          return Center(
            child: SizedBox(
              width: 325,
              child: SingleChildScrollView( // To handle overflow on smaller screens
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                    // Row for First Name and Last Name
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: RoundedTextField(
                            placeholder: "First Name",
                            inputType: TextInputType.name,
                          ),
                        ),
                        SizedBox(width: 10), // space between the two fields
                        Expanded(
                          child: RoundedTextField(
                            placeholder: "Last Name",
                            inputType: TextInputType.name,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    const RoundedTextField(
                      placeholder: "Enter organization code",
                      inputType: TextInputType.text,
                    ),
                    const SizedBox(height: 30),
                    // Password field
                    const RoundedTextField(
                      placeholder: "Enter a strong password",
                      inputType: TextInputType.visiblePassword,
                    ),
                    const SizedBox(height: 30),
                    // Confirm password field
                    const RoundedTextField(
                      placeholder: "Confirm password",
                      inputType: TextInputType.visiblePassword,
                    ),
                    const SizedBox(height: 20),
                    // Checkbox for terms and conditions
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Checkbox(value: false, onChanged: (value) {  }),
                        GestureDetector(
                          onTap: () {
                            // Navigate to the Terms and Conditions page or show a dialog
                            
                          },
                          child: Text(
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
                    // Sign Up button
                    ElevatedButton(
                      onPressed: () {
                        // Handle Sign Up action
                      },
                      
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
                        padding: EdgeInsets.symmetric(vertical: 16),
                        minimumSize: Size(double.infinity, 60),
                        backgroundColor: matcronPrimaryColor
                      ),
                      child: const Text("Sign Up", style: TextStyle(color: Colors.white, fontSize: 20),),
                    ),
                    const SizedBox(height: 20),
                    // Sign In link
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                          Text(
                            "Already have an account?",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16
                            ),
                          ),
                          SizedBox(width: 5),
                          GestureDetector(
                            onTap:() => Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage())),

                            child: Text(
                              "Sign In", 
                              style: TextStyle(
                                color: matcronPrimaryColor, 
                                fontWeight: FontWeight.bold,
                                fontSize: 16
                              )
                            ),
                          )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        }
        // If state is done, navigate page and handle session storage, do not allow the user to return to this page.
        if (state is RemoteAuthDone) {
          // Handle the state transition (e.g., navigate)
        }

        // Display SnackBar
        if (state is RemoteAuthException) {
          // Handle the error state
        }

        return const SizedBox();
      },
    );
  }
}
