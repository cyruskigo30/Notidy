import 'package:flutter/material.dart';
import '../../widgets/custom_bottom_navigation.dart';
import 'notes_dashboard_body.dart';
import 'customer_drawer.dart';

class NotesDashboardScreen extends StatelessWidget {
  const NotesDashboardScreen({Key? key}) : super(key: key);
  static String routeName = '/notes_dashboard';
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
              Icons.add_location_alt_outlined,
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
              Icons.tune_outlined,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.light_mode_outlined,
            ),
          ),
        ],
      ),
      body: const MainBody(),
      drawer: const DrawerPage(),
      bottomNavigationBar: const CustomBottomNavigation(),
    );
  }
}
