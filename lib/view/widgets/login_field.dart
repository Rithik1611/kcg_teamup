import 'package:flutter/material.dart';
import 'package:kcg_teamup/model/pallete.dart';

class LoginField extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  const LoginField({
    Key? key,
    required this.hintText,
    required this.controller,
  }) : super(key: key);

  @override
  _LoginFieldState createState() => _LoginFieldState();
}

class _LoginFieldState extends State<LoginField> {
  Color _textColor = Colors.black;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxWidth: 400,
      ),
      child: Focus(
        onFocusChange: (hasFocus) {
          setState(() {
            _textColor =
                hasFocus ? const Color.fromARGB(255, 0, 0, 0) : Colors.black;
          });
        },
        child: TextFormField(
          controller: widget.controller,
          style: TextStyle(color: _textColor),
          decoration: InputDecoration(
            hintStyle: TextStyle(color: _textColor),
            contentPadding: const EdgeInsets.all(27),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Pallete.borderColor,
                width: 3,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Pallete.gradient3,
                width: 3,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            hintText: widget.hintText,
          ),
        ),
      ),
    );
  }
}
