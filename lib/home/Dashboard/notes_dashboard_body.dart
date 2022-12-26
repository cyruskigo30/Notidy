import 'package:flutter/material.dart';
import 'quickactions/new_note_screen.dart';
import '../../services/auth/auth_service.dart';
import '../../widgets/circular_loading_indicator.dart';
import '../../services/crud/notes_service.dart';
import '../../widgets/menu_button.dart';
import '../../widgets/widget_seperator.dart';
import '../../widgets/ad_container.dart';
import '../../widgets/search_bar.dart';
import '../../utils/constants/constants.dart';

class DashboardBody extends StatefulWidget {
  const DashboardBody({Key? key}) : super(key: key);

  @override
  State<DashboardBody> createState() => _DashboardBodyState();
}

class _DashboardBodyState extends State<DashboardBody> {
  ///declare a private variable to hold the instance of notes service
  /// inorder to utilize it's functionalities
  late final NotesService _notesService;

  ///inorder to start creating notes and associate the local db user with firebase registered user
  /// fecth the firebase user's email address
  String get userEmail =>
      AuthService.initializeFirebaseAuth().currentUser!.authEmail!;

  @override

  ///The database must be open once we get into the dashboard
  ///which has been done in every start of the notes service function
  void initState() {
    ///Create an instance of notes service by calling a factory constructor (within a singleton)
    ///in the notes service that initializes the notes service just once
    _notesService = NotesService();
    super.initState();
  }

  ///close the local db upon exiting the dashboard
  @override
  void dispose() {
    _notesService.closeDb();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ///the future builder returns the content of the dashoard
    ///only when a user is created when the frirebase verified email is copied to the local db to create a user
    ///or an already copied user is retrieved from the local db
    return FutureBuilder(

        ///get or createa user to the local db with the email received from firebase
        future: _notesService.getOrCreateUser(emailAddress: userEmail),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {

            ///if the connection is successfully done return the stream builder
            case ConnectionState.done:

              /// a stream builder will use the stream created in notes services
              /// which is connected to the stream controller in the same file
              /// to update the UI immediately any changes are done in the notes
              return StreamBuilder(
                stream: _notesService.allNotesStream,
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {

                    /// When the connection state is waiting
                    /// the stream builder returns the dashboard
                    /// NB the difference between future builder and stream builder is that
                    /// future builder can have a start and an end which is the connection state of done
                    /// but a stream builder doesnt have an end but just continues on without being done
                    case ConnectionState.waiting:
                      return SafeArea(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          physics: const BouncingScrollPhysics(),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: kMediumWidth),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Welcome to Notidy",
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                                const WidgetSeperator(),
                                const SearchBar(),
                                const WidgetSeperator(),
                                const AdContainer(),
                                const WidgetSeperator(),
                                Text(
                                  "QUICK ACTIONS",
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                                const WidgetSeperator(),
                                GridView(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 4,
                                  ),
                                  children: [
                                    MenuButton(
                                      buttonColor: Colors.green,
                                      buttonText: 'New Note',
                                      imageUrl:
                                          'assets/svg/add-svgrepo-com.svg',
                                      onClick: () {
                                        Navigator.pushNamed(
                                            context, NewNoteScreen.routeName);
                                      },
                                    ),
                                    MenuButton(
                                      buttonColor: Colors.purple,
                                      buttonText: 'Shared',
                                      imageUrl:
                                          'assets/svg/touch-press-click-svgrepo-com.svg',
                                      onClick: () {
                                        // Navigator.pushNamed(context, MachineryScreen.routeName);
                                      },
                                    ),
                                    MenuButton(
                                      buttonColor: Colors.blue,
                                      buttonText: 'Categories',
                                      imageUrl:
                                          'assets/svg/sort-arrows-svgrepo-com.svg',
                                      onClick: () {
                                        // Navigator.pushNamed(context, RecipesScreen.routeName);
                                      },
                                    ),
                                    MenuButton(
                                      buttonColor: Colors.pink,
                                      buttonText: 'My Notes',
                                      imageUrl:
                                          'assets/svg/sort-arrows-svgrepo-com (1).svg',
                                      onClick: () {},
                                    ),
                                  ],
                                ),
                                Text(
                                  "RECENT NOTES",
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );

                    ///by default all other stream builder conection states should return a circular progress indicator
                    default:
                      return const CircularLoadingIndicator();
                  }
                },
              );

            ///for every other snapshot connection state, return a circular loading indicator
            default:
              return const CircularLoadingIndicator();
          }
        });
  }
}
