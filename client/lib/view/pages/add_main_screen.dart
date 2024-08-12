import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart'; // Import GetWidget
import 'package:kcg_teamup/view/pages/add_category_page.dart';
import 'package:kcg_teamup/view/pages/add_team_page.dart';
import 'package:kcg_teamup/view/pages/upload.dart';

class AddMainScreen extends StatefulWidget {
  const AddMainScreen({super.key});

  @override
  State<AddMainScreen> createState() => _AddMainScreenState();
}

class _AddMainScreenState extends State<AddMainScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 18,
          ),
          InkWell(
            child: Container(
              height: 100,
              child: GFButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddCategoryPage(),
                  ),
                ),
                text: "Admin Control", textStyle: TextStyle(fontSize: 24),
                icon: Icon(Icons.admin_panel_settings,
                    color: Colors.white), // Optional icon
                color: GFColors.INFO,
                textColor: Colors.white,
                shape: GFButtonShape.standard,
                size: GFSize.LARGE,
                blockButton: true,
              ),
            ),
            onTap: () {},
          ),
          const SizedBox(
            height: 15,
          ),
          InkWell(
            child: Container(
              height: 100,
              child: GFButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddTeamPage(),
                  ),
                ),
                text: "Create a Team", textStyle: TextStyle(fontSize: 24),
                icon:
                    Icon(Icons.group_add, color: Colors.white), // Optional icon
                color: GFColors.WARNING,
                textColor: Colors.white,
                shape: GFButtonShape.standard,
                size: GFSize.LARGE,
                blockButton: true,
              ),
            ),
            onTap: () {},
          ),
          const SizedBox(
            height: 15,
          ),
          InkWell(
            child: Container(
              height: 100,
              child: GFButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AchievementsPage(),
                  ),
                ),
                text: "Upload", textStyle: TextStyle(fontSize: 24),
                icon: Icon(Icons.file_upload_sharp,
                    color: Colors.white), // Optional icon
                color: GFColors.SUCCESS,
                textColor: Colors.white,
                shape: GFButtonShape.standard,
                size: GFSize.LARGE,
                blockButton: true,
              ),
            ),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
