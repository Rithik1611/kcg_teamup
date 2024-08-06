import 'package:flutter/material.dart';
import 'package:kcg_teamup/view/pages/add_category_page.dart';

class AddMainScreen extends StatelessWidget {
  const AddMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddCategoryPage(),
              ),
            );
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 380,
                height: 100,
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Colors.grey,
                    const Color.fromARGB(255, 206, 205, 205),
                    Colors.white
                  ], begin: Alignment.centerLeft, end: Alignment.centerRight),
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    "Admin Control",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
