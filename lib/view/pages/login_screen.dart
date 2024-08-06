import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kcg_teamup/view/pages/home_screen.dart';
import 'package:kcg_teamup/view/widgets/gradient_button.dart';
import 'package:kcg_teamup/view/widgets/login_field.dart';
import 'package:kcg_teamup/viewmodel/bloc/auth_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                builder: (context) => const HomeScreen(),
              ),
              (route) => false,
            );
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),
                  const Text(
                    "Sign In",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 40),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: LoginField(
                        hintText: "email", controller: emailController),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: LoginField(
                        hintText: "password", controller: passwordController),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.11,
                  ),
                  GradientButton(
                    onpressed: () {
                      BlocProvider.of<AuthBloc>(context).add(AuthLoginRequest(
                          email: emailController.text.trim(),
                          password: passwordController.text.trim()));
                    },
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
