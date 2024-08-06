import 'package:flutter/material.dart';
import 'package:kcg_teamup/view/pages/login_screen.dart';
import 'package:kcg_teamup/viewmodel/bloc/auth_bloc.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LoginPage(),
      ),
    );
  }
}
