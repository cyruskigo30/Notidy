import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../auth/screens/splash/splash_screen.dart';
import 'notes_dashboard_screen.dart';
import '../../utils/constants/constants.dart';
import '../../utils/theme/colors.dart';
import '../../widgets/add_divider.dart';
import '../../widgets/circle_image.dart';
import '../../widgets/drawer_item.dart';

class DrawerPage extends StatelessWidget {
  const DrawerPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              color: kPrimaryColor,
              backgroundBlendMode: BlendMode.darken,
              // image: const DecorationImage(
              //   image: ExactAssetImage('assets/images/app/bg3.png'),
              //   fit: BoxFit.cover,
              // ),
            ),
            accountName: Container(
              margin: const EdgeInsets.only(top: kLargeHeight),
              padding: const EdgeInsets.only(top: kLargeHeight),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Cyrus Kigo',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        // color: kLightBlueColor,
                        ),
                  ),
                  const CloseButton(
                    color: kCardLightColor,
                  ),
                ],
              ),
            ),
            accountEmail: Text(
              // 'cyruskigo30@gmail.com',
              '${FirebaseAuth.instance.currentUser?.email}',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(color: kCardLightColor),
            ),
            currentAccountPicture: const CircleImage(
              circleRadius: 38,
              imageProvider: AssetImage(
                'assets/images/profile_photo.jpg',
              ),
            ),
          ),
          const AddDivider(),
          BuildDrawerItem(
            drawerIcon: Icons.person_rounded,
            drawerTitle: 'Account Profile',
            drawerAction: () {
              showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return const NotesDashboardScreen();
                  });
            },
          ),
          BuildDrawerItem(
            drawerIcon: Icons.favorite,
            drawerTitle: 'Favorites',
            drawerAction: () {},
          ),
          BuildDrawerItem(
            drawerIcon: Icons.star,
            drawerTitle: 'Feedback',
            drawerAction: () {},
          ),
          BuildDrawerItem(
            drawerIcon: Icons.business_center,
            drawerTitle: 'Business',
            drawerAction: () {
              // Navigator.pushNamed(context, BusinessDashboard.routeName);
            },
          ),
          BuildDrawerItem(
            drawerIcon: Icons.info_rounded,
            drawerTitle: 'Info',
            drawerAction: () {},
          ),
          BuildDrawerItem(
            drawerIcon: Icons.settings,
            drawerTitle: 'Settings',
            drawerAction: () {},
          ),
          const AddDivider(),
          GestureDetector(
            onTap: () {},
            child: Column(
              children: [
                Image.asset(
                  'assets/icons/drawer/upgrade.png',
                  height: 90,
                ),
                Text(
                  'Upgarde Your Plan',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: kSuccessColor,
                      ),
                ),
                Text(
                  'GO PREMIUM',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: kPrimaryColor,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
