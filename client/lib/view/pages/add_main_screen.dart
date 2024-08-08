import 'package:flutter/material.dart';
import 'package:kcg_teamup/view/pages/add_category_page.dart';
import 'package:kcg_teamup/view/pages/add_team_page.dart';

class AddMainScreen extends StatefulWidget {
  const AddMainScreen({super.key});

  @override
  State<AddMainScreen> createState() => _AddMainScreenState();
}

class _AddMainScreenState extends State<AddMainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            InkWell(
              child: Gradient_Button(name: "Admin Control"),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddCategoryPage(),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            InkWell(
              child: Gradient_Button(
                name: "Create a Team",
              ),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddTeamPage(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Gradient_Button extends StatelessWidget {
  final String name;
  const Gradient_Button({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 380,
      height: 100,
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [
          Colors.grey,
          Color.fromARGB(255, 206, 205, 205),
          Colors.white
        ], begin: Alignment.centerLeft, end: Alignment.centerRight),
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          name.toString(),
          textAlign: TextAlign.left,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
