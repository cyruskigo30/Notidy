import 'package:flutter/material.dart';
import '../../services/auth/auth_service.dart';
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

  ///To get the first part of the users email so that we can use it as a
  ///user name, we split the email upto the @ sign and from list returned by the dart inbuilt split fucntion,
  ///access the first item of the list of index 0

  @override
  Widget build(BuildContext context) {
    final String emailName =
        '${AuthService.initializeFirebaseAuth().currentUser?.authEmail?.split('@')[0]}';
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
                    emailName,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: kDarkTextColor,
                        ),
                  ),
                  const CloseButton(
                    color: kCardLightColor,
                  ),
                ],
              ),
            ),
            accountEmail: Text(
              ///get the email From Auth Service
              '${AuthService.initializeFirebaseAuth().currentUser?.authEmail}',
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
