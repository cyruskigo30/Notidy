import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import '../../services/cloud/firebase_cloud_storage.dart';
import '../../services/cloud/cloud_note.dart';
import '../../utils/dialogs/cannot_share_empty_note_dialog.dart';
import '../../utils/generics/get_arguements.dart';
import '../../utils/widgets/widget_seperator.dart';
import '../../utils/widgets/circular_loading_indicator.dart';
import '../../services/auth/auth_service.dart';
import '../../utils/constants/constants.dart';

class CreateUpdateNoteScreen extends StatefulWidget {
  const CreateUpdateNoteScreen({super.key});
  static String routeName = '/create_update_note_screen';
  @override
  State<CreateUpdateNoteScreen> createState() => _CreateUpdateNoteScreenState();
}

class _CreateUpdateNoteScreenState extends State<CreateUpdateNoteScreen> {
  ///On launching this page, automatically create an empty note in the cloud db
  ///this variable holds the new note inorder to prevent creation of a new note every time the UI rebuilds
  ///it must me nullable because when launched it contains nothing

  CloudNote? _targetedNote;

  ///A varibale to hold the note service
  late final FirebaseCloudStorage _notesService;

  ///A text editing controller to hold the note text as the user writes it
  /// it will sync with cloud db and when the user goes online, it syncs with firebase
  late final TextEditingController _textController;

  ///Initialize some crucial instances
  @override
  void initState() {
    ///create an instance of note service
    _notesService = FirebaseCloudStorage();

    ///create an instance of note content controller
    _textController = TextEditingController();
    super.initState();
  }

  ///A function to create or get an existing note and return it
  Future<CloudNote> createOrGetExistingNote(BuildContext context) async {
    ///if we were passed a note from the dashboard (a note is clicked from the list)
    ///we will open it in the same text widget that types a new note
    ///we need to get that optional note
    ///The get arguement is a custom created fucntion that allows us to pass some arguements
    ///from the note clicked
    final widgetNote = context.getArguement<CloudNote>();

    ///if the note exists (meaning the user tapped on the note)
    ///assign our targeted note to the selected existing note that needs an update
    if (widgetNote != null) {
      _targetedNote = widgetNote;

      ///This also means that the text field holding the text clicke should be repopulated with the text
      ///that requires editing and we can target it through the text editing controller adssigned to the text field
      _textController.text = widgetNote.noteContent;
      return widgetNote;
    }

    ///check if  this specific note exixts by checking the new note variable
    ///if available it,  return it
    final existingNote = _targetedNote;
    if (existingNote != null) {
      return existingNote;
    }

    ///If note doesnt exist call the new note method from the firebase cloud storage service
    /// to create the new note
    ///New note function from the notes services requires a user id
    ///Retrieve the current user from firebase
    ///The exclamation forces dart to acknowledge that the user exists at this point because as per logic,
    /// they couldn't have passed the dashboard without being a registred
    final currentUser = AuthService.initializeFirebaseAuth().currentUser!;

    /// get the current users ID from the received current user
    final currentUserId = currentUser.userId;

    ///create a new note and assign it to the user id just retrieved from the firebase db
    final newNote = await _notesService.createNewNote(userId: currentUserId);

    ///make the new note the targeted note by the page
    _targetedNote = newNote;

    ///by returning the new note since its a requirement of the create note function of firebase cloud storage service
    return newNote;
  }

  ///since a new note is automatically created when the user gets into the new note page
  ///This function deletes any newly created note that the user didnt proceed with providing the content
  ///and just decided to go back to dashboard or close the application
  void _deleteNoteWithEmptyContent() {
    ///A variable to hold the note created from the cloud db
    final potentialNote = _targetedNote;

    ///if the user didnt type anything (empty noteContentConroller)
    ///and the cloud db has a note created already since it was created when they clicked on new note,
    ///then delete the note from cloud db with the Id similar to the the one assigned to new note varibale
    ///when they got into the new note page
    if (_textController.text.isEmpty && potentialNote != null) {
      _notesService.deleteNote(documentId: potentialNote.documentId);
    }
  }

  ///most current applications dont need a save button
  ///the app should track the user content changes and automatically update when they leave that screen
  ///meaning the app needs to automatically save a note as long as there is any content in it
  ///A fucntion that automatically saves a note when the content is not empty
  void _saveNoteContainingContent() async {
    ///A variable to hold the note created from the cloud db
    final acceptableNote = _targetedNote;

    ///text content that the user has typed
    final noteTextContent = _textController.text;

    ///if the note exists in the cloud db meaning it was successfully created on launching new note
    ///and the user has typed something in the note textfield which is captured by the noteContentController
    ///then update the already created empty note in the cloud db with the typed content
    if (acceptableNote != null && noteTextContent.isNotEmpty) {
      await _notesService.updateNote(
        documentId: acceptableNote.documentId,
        noteContent: noteTextContent,
      );
    }
  }

  ///the update of the cloud db will happen as the user is typing the note (simultanously)
  ///and not as they leave the new note screen
  /// to achieve this we need a text controller listener which is basically a fucntion
  /// that takes the curent notecontentcontrollers text and update the note in the cloud db
  /// its an async fucntion called only when the text in the  _noteTextContentController changes
  void _noteTextContentControllerListener() async {
    ///the current note to add content into
    final currentNote = _targetedNote;

    ///if it is null, do nothing (this means the user has opened the note but isn't typing)
    if (currentNote == null) {
      return;
    }

    ///the current text in the _noteTextContentController
    final currentNoteContent = _textController.text;

    /// when the user starts typing,
    /// take the current note from db and
    /// add currentNotecontent into the cloud db of that specific note
    await _notesService.updateNote(
      documentId: currentNote.documentId,
      noteContent: currentNoteContent,
    );
  }

  ///the _noteTextContentControllerListener keeps on being added and removed dependng
  ///on whether the user is typing or not added when they are typing, removed when they stop
  ///to achieve this, This fucntion  that setsup the _noteTextContentControllerListener is required
  void _setupNoteTextContentControllerListener() {
    ///remove the listener when the note owner is not typing which we know because the  _noteTextContentController doesnt register any changes in the note
    _textController.removeListener(_noteTextContentControllerListener);

    ///return the listener when the  note owner is typing which we know because the  _noteTextContentController registers new changes
    _textController.addListener(_noteTextContentControllerListener);
  }

  ///When leaving the page automatically perform the following
  @override
  void dispose() {
    ///delete the note if it has no content
    _deleteNoteWithEmptyContent();

    /// Save the note if it has some content
    _saveNoteContainingContent();

    ///Dispose the text controller
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'New Note',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        actions: [
          IconButton(
            onPressed: () async {
              final currentText = _textController.text;

              ///if there was no note opened or the new note textfield is empty
              ///show the cannot share empty note dialog
              if (_targetedNote == null || currentText.isEmpty) {
                await showCannotShareEmptyNote(context);
              } else {
                ///if there is a typed note or a note was opened
                Share.share(currentText);
              }
            },
            icon: const Icon(Icons.share_outlined),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(kMediumWidth),
        child: SafeArea(
            child: SizedBox(
          height: height,
          width: width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Type below to create your",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const WidgetSeperator(),
              Text(
                "New note is automatically saved",
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const WidgetSeperator(),
              FutureBuilder(
                /// call a database note function that creates a note and returns it
                future: createOrGetExistingNote(context),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {

                    ///when the new note is created, we return
                    case ConnectionState.done:

                      ///then we need to strt listening to user text changes on the notetextcontentcontroller
                      ///we use the setup notetextcontentcontroller to start and stop the listening as needed
                      _setupNoteTextContentControllerListener();

                      ///return a textfield for user to enter their note text content
                      return TextField(
                        controller: _textController,

                        ///allow for multiline text input
                        keyboardType: TextInputType.multiline,

                        ///to create a textfiled with multtiline that expands we type we use assign null to max lines parameter
                        maxLines: null,
                        decoration: const InputDecoration(
                          labelText: 'Create / Update Note',
                          hintText: 'Type your note here',
                          prefixIcon: Icon(Icons.pending_actions_outlined),
                        ),
                      );

                    ///otherwise we have the loading circle
                    default:
                      return const CircularLoadingIndicator();
                  }
                },
              )
            ],
          ),
        )),
      ),
    );
  }
}
