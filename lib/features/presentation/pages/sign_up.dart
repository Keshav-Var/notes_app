import 'package:flutter/material.dart';
import 'package:notes_app/features/bussiness/entities/user_entity.dart';
import 'package:notes_app/features/presentation/provider/authentication_provider.dart';
import 'package:notes_app/features/presentation/provider/user_provider.dart';
import 'package:notes_app/features/presentation/widgets/input_text_field.dart';
import 'package:notes_app/features/presentation/widgets/snake_bar.dart';
import 'package:provider/provider.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();
  String error = "";
  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: globalKey,
      body: Consumer<UserProvider>(
        builder: (context, userProvider, _) {
          if (userProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          // Show error message if there is one
          if (userProvider.errorMsg != null) {
            error = userProvider.errorMsg!;
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                snackBar(error),
              );
            });
            userProvider.reset();
          }

          // Navigate to home if sign up is successful
          if (userProvider.errorMsg == null &&
              userProvider.isLoading == false) {
            Provider.of<AuthenticationProvider>(context, listen: false)
                .signedIn();
          }

          return _bodyWidget();
        },
      ),
    );
  }

  Widget _bodyWidget() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(
              height: 100,
            ),
            const Image(
              image: AssetImage("assets/images/notebook.png"),
              height: 150,
            ),
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(
                    height: 30,
                  ),
                  InputTextField(
                    hintText: "Enter username",
                    controller: _usernameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your username';
                      } else if (!RegExp(r'^[^@]+').hasMatch(value)) {
                        return 'Please enter a valid username';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  InputTextField(
                    hintText: "Enter your email",
                    controller: _emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                          .hasMatch(value)) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  InputTextField(
                    hintText: "Enter your password",
                    controller: _passwordController,
                    isPassword: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  InputTextField(
                    hintText: "Enter confirm password",
                    controller: _confirmPassword,
                    isPassword: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter confirm password';
                      } else if (value != _passwordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () {
                submitSignUp();
              },
              child: Container(
                height: 45,
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width / 2,
                decoration: BoxDecoration(
                  color: Colors.deepOrange.withValues(alpha: .8),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: const Text(
                  "Sign up",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            GestureDetector(
              onTap: () =>
                  Provider.of<UserProvider>(context, listen: false).toggle(),
              child: Container(
                height: 45,
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width / 2,
                decoration: BoxDecoration(
                  color: Colors.grey.withValues(alpha: .8),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: const Text(
                  "Login",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void submitSignUp() {
    if (_formKey.currentState!.validate()) {
      Provider.of<UserProvider>(context, listen: false).submitSignUp(
        user: UserEntity(
          email: _emailController.text,
          name: _usernameController.text,
          password: _passwordController.text,
        ),
      );
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(snackBar("Please check your input."));
    }
  }
}
