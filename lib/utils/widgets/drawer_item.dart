import 'package:flutter/material.dart';
import '../theme/colors.dart';

class BuildDrawerItem extends StatelessWidget {
  const BuildDrawerItem({
    required this.drawerIcon,
    required this.drawerTitle,
    required this.drawerAction,
    Key? key,
  }) : super(key: key);
  final IconData drawerIcon;
  final String drawerTitle;
  final VoidCallback drawerAction;

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: ListTile(
        selectedTileColor: kPrimaryColor,
        horizontalTitleGap: 0.0,
        dense: true,
        onTap: drawerAction,
        trailing: Icon(
          Icons.keyboard_arrow_right,
          color: Theme.of(context).iconTheme.color,
        ),
        leading: Icon(
          drawerIcon,
          color: Theme.of(context).iconTheme.color,
        ),
        title: Text(
          drawerTitle,
          // style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
    );
  }
}
