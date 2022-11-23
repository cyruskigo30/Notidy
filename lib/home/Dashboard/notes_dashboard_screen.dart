import 'package:flutter/material.dart';
import 'package:notidy/utils/constants/constants.dart';
import 'package:notidy/utils/theme/colors.dart';
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
  Signout,
  Settings,
  New,
  DisplayMode,
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
          PopupMenuButton<DashboardAction>(
            onSelected: (value) {},
            itemBuilder: (context) {
              return [
                PopupMenuItem<DashboardAction>(
                  value: DashboardAction.New,
                  child: ListTile(
                    tileColor: Theme.of(context).cardColor,
                    selectedTileColor: kPrimaryColor,
                    trailing: const Icon(Icons.keyboard_arrow_right_outlined),
                    leading: const Icon(Icons.add),
                    title: Text(
                      'New',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    // subtitle: Text(
                    //   'Create a new note',
                    //   style: Theme.of(context).textTheme.bodySmall,
                    // ),
                  ),
                ),
                const PopupMenuItem<DashboardAction>(
                  value: DashboardAction.DisplayMode,
                  child: ListTile(
                    leading: Icon(Icons.light_mode_outlined),
                    title: Text('Display'),
                  ),
                ),
                const PopupMenuItem<DashboardAction>(
                  value: DashboardAction.Settings,
                  child: ListTile(
                    leading: Icon(Icons.settings_outlined),
                    title: Text('Settings'),
                  ),
                ),
                const PopupMenuItem<DashboardAction>(
                  value: DashboardAction.Signout,
                  child: ListTile(
                    leading: Icon(Icons.power_settings_new_rounded),
                    title: Text('Signout'),
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
