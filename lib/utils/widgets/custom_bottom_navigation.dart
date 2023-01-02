import 'package:flutter/material.dart';
import '../../screens/home/notes_dashboard_screen.dart';

class CustomBottomNavigation extends StatelessWidget {
  const CustomBottomNavigation({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedFontSize: 14,
      unselectedFontSize: 16,
      onTap: (value) {
        showModalBottomSheet(
            context: context,
            builder: (context) {
              return const NotesDashboardScreen();
            });
      },
      items: const [
        BottomNavigationBarItem(
          label: 'Home',
          icon: Icon(Icons.home),
        ),
        BottomNavigationBarItem(
          label: 'Favorites',
          icon: Icon(Icons.favorite),
        ),
        BottomNavigationBarItem(
          label: 'Add',
          icon: Icon(Icons.add_circle),
        ),
        BottomNavigationBarItem(
          label: 'Chat',
          icon: Icon(Icons.chat_bubble),
        ),
        BottomNavigationBarItem(
          label: 'Info',
          icon: Icon(Icons.info),
        ),
      ],
    );
  }
}
