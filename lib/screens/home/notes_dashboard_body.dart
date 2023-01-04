import 'package:flutter/material.dart';
import 'package:notidy/screens/home/all_notes_view.dart';
import '../../services/cloud/cloud_note.dart';
import '../../services/cloud/firebase_cloud_storage.dart';
import 'create_update_note_view.dart';
import 'notes_list_view.dart';
import '../../../utils/theme/colors.dart';
import '../../../services/auth/auth_service.dart';
import '../../utils/widgets/circular_loading_indicator.dart';
import '../../utils/widgets/menu_button.dart';
import '../../utils/widgets/widget_seperator.dart';
import '../../utils/widgets/ad_container.dart';
import '../../utils/widgets/search_bar.dart';
import '../../../utils/constants/constants.dart';

class DashboardBody extends StatefulWidget {
  const DashboardBody({Key? key}) : super(key: key);

  @override
  State<DashboardBody> createState() => _DashboardBodyState();
}

class _DashboardBodyState extends State<DashboardBody> {
  ///declare a private variable to hold the instance of notes service
  /// inorder to utilize it's functionalities
  late final FirebaseCloudStorage _notesService;

  ///inorder to start creating notes and associate the cloud db user with firebase registered user
  /// fecth the firebase user's email address
  String get currentUserId =>
      AuthService.initializeFirebaseAuth().currentUser!.userId;

  ///To get the first part of the users email so that we can use it as a
  ///user name, we split the email upto the @ sign and from list returned by the dart inbuilt split fucntion,
  ///access the first item of the list of index 0
  String emailName =
      '${AuthService.initializeFirebaseAuth().currentUser?.authEmail.split('@')[0]}';

  @override

  ///The database must be open once we get into the dashboard
  ///which has been done in every start of the notes service function
  void initState() {
    ///Create an instance of notes service by calling a factory constructor (within a singleton)
    ///in the notes service that initializes the notes service just once
    _notesService = FirebaseCloudStorage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ///the future builder returns the content of the dashoard
    ///only when a user is created when the frirebase verified email is copied to the cloud db to create a user
    ///or an already copied user is retrieved from the cloud db
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kMediumWidth),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        "Hello, ",
                        style: Theme.of(context).textTheme.titleSmall,
                      ),

                      ///the first part of the email address that forms the username
                      Text(
                        " $emailName",
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall
                            ?.copyWith(color: kPrimaryColor),
                      ),
                    ],
                  ),
                  Text(
                    "Welcome to Notidy",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
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
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                ),
                children: [
                  MenuButton(
                    buttonColor: Colors.green,
                    buttonText: 'New Note',
                    imageUrl: 'assets/svg/new-file-svgrepo-com.svg',
                    onClick: () {
                      Navigator.pushNamed(
                        context,
                        CreateUpdateNoteScreen.routeName,
                      );
                    },
                  ),
                  MenuButton(
                    buttonColor: Colors.purple,
                    buttonText: 'Share Note',
                    imageUrl: 'assets/svg/share-o-svgrepo-com.svg',
                    onClick: () {
                      Navigator.pushNamed(
                        context,
                        CreateUpdateNoteScreen.routeName,
                      );
                    },
                  ),
                  MenuButton(
                    buttonColor: Colors.blue,
                    buttonText: 'Categories',
                    imageUrl: 'assets/svg/folder-add-svgrepo-com.svg',
                    onClick: () {
                      // Navigator.pushNamed(context, RecipesScreen.routeName);
                    },
                  ),
                  MenuButton(
                    buttonColor: Colors.pink,
                    buttonText: 'My Notes',
                    imageUrl: 'assets/svg/documents-svgrepo-com.svg',
                    onClick: () {
                      Navigator.pushNamed(
                        context,
                        AllNotesView.routeName,
                      );
                    },
                  ),
                ],
              ),
              Text(
                "RECENT NOTES",
                style: Theme.of(context).textTheme.bodyText1,
              ),
              const WidgetSeperator(),
              StreamBuilder(
                stream: _notesService.allNotes(userId: currentUserId),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {

                    /// When the connection state is waiting
                    case ConnectionState.waiting:

                    /// the stream builder has no notes to show
                    /// NB the difference between future builder and stream builder is that
                    /// future builder can have a start and an end which is the connection state of done
                    /// but a stream builder doesnt have an end but just continues on without being done

                    case ConnectionState.active:

                      ///if the snapshot has data (there is data in the database)
                      if (snapshot.hasData) {
                        ///get all the notes from the db
                        final allNotes = snapshot.data as Iterable<CloudNote>;
                        return NotesListView(
                          ///assign notes to all the notes received
                          notes: allNotes,

                          ///get the note the user wants to delete
                          onDelete: ((note) async {
                            ///call the delete note service to delete the note with the clicked id
                            await _notesService.deleteNote(
                                documentId: note.documentId);
                          }),

                          ///on clicking the note list tile,
                          /// go to the create or edit note and open the currentnote as received from the note list view
                          /// and the create update note screen will open it in the text editing controller
                          /// use arguements so that the text editing controller can have that exact note ready for editing
                          onClick: (note) {
                            Navigator.of(context).pushNamed(
                              CreateUpdateNoteScreen.routeName,
                              arguments: note,
                            );
                          },
                        );

                        ///if snapshot has no data ie there are no notes in the db
                      } else {
                        return const CircularLoadingIndicator();
                      }

                    ///by default all other stream builder conection states should return a circular progress indicator
                    default:
                      return const CircularLoadingIndicator();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
