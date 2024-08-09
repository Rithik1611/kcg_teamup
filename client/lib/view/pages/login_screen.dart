import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kcg_teamup/model/repositories/auth_remote_repository.dart';
import 'package:kcg_teamup/view/pages/home_page.dart';
import 'package:kcg_teamup/view/widgets/my_button.dart';
import 'package:kcg_teamup/view/widgets/my_textfield.dart';
import 'package:kcg_teamup/viewmodel/bloc/auth_bloc.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  // text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // sign user in method

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: const Text("Login page"),
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
        titleTextStyle: TextStyle(color: Colors.white),
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthFailure) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error)));
          }
          if (state is AuthSuccess) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const HomePage(),
              ),
              (route) => false,
            );
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return SafeArea(
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 30),

                  // logo
                  const Icon(
                    Icons.lock,
                    size: 100,
                  ),

                  const SizedBox(height: 50),

                  // welcome back, you've been missed!
                  Text(
                    'Welcome back you\'ve been missed!',
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 16,
                    ),
                  ),

                  const SizedBox(height: 25),

                  // username textfield
                  MyTextField(

                    controller: emailController,
                    hintText: 'email',

                    obscureText: false,
                  ),

                  const SizedBox(height: 10),

                  // password textfield
                  MyTextField(
                    controller: passwordController,
                    hintText: 'Password',
                    obscureText: true,
                  ),

                  const SizedBox(height: 10),

                  const SizedBox(height: 25),

                  // sign in button
                  MyButton (
                    onTap: () async {
                      bool isSuccess = await AuthRemoteRepository().login(
                        email: emailController.text,
                        password: passwordController.text,


                      );

                      if (isSuccess) {
                        BlocProvider.of<AuthBloc>(context).add(
                          AuthLoginRequest(
                            password: passwordController.text.trim(),
                            email: emailController.text.trim(),
                          ),
                        );
                      } else {
                        // Show error message
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Login failed')),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
