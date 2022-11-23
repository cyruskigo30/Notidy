import 'dart:developer' as app show log;

import 'package:flutter/material.dart';
import '../../widgets/custom_bottom_navigation.dart';
import 'notes_dashboard_body.dart';
import 'customer_drawer.dart';

class NotesDashboardScreen extends StatefulWidget {
  const NotesDashboardScreen({Key? key}) : super(key: key);
  static String routeName = '/notes_dashboard';

  @override
  State<NotesDashboardScreen> createState() => _NotesDashboardScreenState();
}

///enums to be used in th epopup menu
enum DashboardAction {
  signout,
  settings,
  add,
}

class _NotesDashboardScreenState extends State<NotesDashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Notidy',
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search_outlined,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.notifications_outlined,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.light_mode_outlined,
            ),
          ),
          PopupMenuButton<DashboardAction>(
            onSelected: (value) {
              app.log('$value');
            },
            itemBuilder: (context) {
              return [
                PopupMenuItem<DashboardAction>(
                  value: DashboardAction.add,
                  child: ListTile(
                    trailing: const Icon(Icons.keyboard_arrow_right_outlined),
                    leading: const Icon(Icons.add),
                    title: Text(
                      'New',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ),
                PopupMenuItem<DashboardAction>(
                  value: DashboardAction.settings,
                  child: ListTile(
                    trailing: const Icon(Icons.keyboard_arrow_right_outlined),
                    leading: const Icon(Icons.settings_outlined),
                    title: Text(
                      'Settings',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ),
                PopupMenuItem<DashboardAction>(
                  value: DashboardAction.signout,
                  child: ListTile(
                    trailing: const Icon(Icons.keyboard_arrow_right_outlined),
                    leading: const Icon(Icons.power_settings_new_rounded),
                    title: Text(
                      'Signout',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ),
              ];
            },
          ),
        ],
      ),
      body: const MainBody(),
      drawer: const DrawerPage(),
      bottomNavigationBar: const CustomBottomNavigation(),
    );
  }
}
