import 'package:flutter/material.dart';

import '../widgets/app_info_dialog.dart';
import '../widgets/setting_item.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          SettingItem(
            icon: Icons.person,
            title: 'Profile',
            subtitle: 'Manage your profile',
            onTap: () {
              Navigator.pushNamed(context, '/profile');
            },
          ),
          SettingItem(
            icon: Icons.history,
            title: 'History',
            subtitle: 'Manage your product history',
            onTap: () {
              Navigator.pushNamed(context, '/history');
            },
          ),
          SettingItem(
            icon: Icons.info,
            title: 'About',
            subtitle: "Application information",
            onTap: () {
              AppInfoDialog.show(context);
            },
          ),
        ],
      ),
    );
  }
}
