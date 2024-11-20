import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matcron/app/features/auth/presentation/bloc/auth/remote/login/remote_login_bloc.dart';
import 'package:matcron/app/features/auth/presentation/bloc/auth/remote/remote_auth_state.dart';
import 'package:matcron/app/features/auth/presentation/pages/register.dart';
import 'package:matcron/app/features/auth/presentation/widgets/rounded_text_field.dart';
import 'package:matcron/app/injection_container.dart';
import 'package:matcron/core/constants/constants.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RemoteLoginBloc>(
      create: (context) => sl(),
      child: Scaffold(
        body: _buildBody(context),
      ),
    );
  }

  _buildBody(context) {
    return BlocBuilder<RemoteLoginBloc, RemoteAuthState>(
      builder: (_, state) {
        if (state is RemoteAuthLoading) {
          return const Center(child: Text("Loading"));
          
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
                     const RoundedTextField(
                      placeholder: "Enter email",
                      inputType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 30),
                    // Password field
                    const RoundedTextField(
                      placeholder: "Enter password",
                      inputType: TextInputType.visiblePassword,
                    ),
                    const SizedBox(height: 15),
                    GestureDetector(
                      onTap: () {
                        // Navigate to Sign In page
                      },
                      child: Text(
                        "Forgot Password?",
                        style: TextStyle(color: matcronPrimaryColor, fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                    const SizedBox(height: 35),
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
                      child: const Text("Sign In", style: TextStyle(color: Colors.white, fontSize: 20),),
                    ),
                    const SizedBox(height: 20),
                    // Sign In link
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                          Text(
                            "Don't have an account?",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16
                            ),
                          ),
                          SizedBox(width: 5),
                          GestureDetector(
                            onTap:() => Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterPage())),

                            child: Text(
                              "Sign Up", 
                              style: TextStyle(
                                color: matcronPrimaryColor, 
                                fontWeight: FontWeight.bold,
                                fontSize: 16
                              )
                            ),
                          )
                      ],
                    ),
                  ]
                )
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
      }
    );
  }
}