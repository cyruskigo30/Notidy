import 'package:flutter/material.dart';
import 'package:notidy/widgets/widget_seperator.dart';
import '../../../widgets/circular_loading_indicator.dart';
import '../../../services/auth/auth_service.dart';
import '../../../services/crud/notes_service.dart';
import '../../../utils/constants/constants.dart';

class NewNoteBody extends StatefulWidget {
  const NewNoteBody({super.key});

  @override
  State<NewNoteBody> createState() => _NewNoteBodyState();
}

class _NewNoteBodyState extends State<NewNoteBody> {
  ///On launching this page, automatically create an empty note in the local db
  ///this variable holds the new note inorder to prevent creation of a new note every time the UI rebuilds
  ///it must me nullable because when launched it contains nothing
  DatabaseNotes? _newNote;

  ///A varibale to hold the note service
  late final NotesService _notesService;

  ///A text editing controller to hold the note text as the user writes it
  /// it will sync with local db and when the user goes online, it syncs with firebase
  late final TextEditingController _noteTextContentController;

  ///Initialize some crucial instances
  @override
  void initState() {
    ///create an instance of note service
    _notesService = NotesService();

    ///create an instance of note content controller
    _noteTextContentController = TextEditingController();
    super.initState();
  }

  ///A function to create a new note and return it
  Future<DatabaseNotes> creaateNewNote() async {
    ///First check if  this specific note exixts by checking the new note variable
    ///if available it,  return it
    final existingNote = _newNote;
    if (existingNote != null) {
      return existingNote;
    }

    ///If note doesnt exist call the notes service and request to create a new note and return the note back
    ///New note function from the notes services requires a note owner
    ///Retrieve the current user from firebase
    ///The exclamation forces dart to acknowledge that the user exists at this point because as per logic,
    /// they couldn't have passed the dashboard without being a registred
    final currentUser = AuthService.initializeFirebaseAuth().currentUser!;

    ///The exclamation forces dart to acknowledge that the userhas an email at this point,
    ///Retrieve the current users email from firebase
    final currentUsersEmail = currentUser.authEmail!;

    ///Get the local db noteOwner by providing their email address
    ///The noteOwer in local db is retrieved from localdb by the getUser function within the noteservice
    ///the getUser fucntion requires an email address of the note owner which we have retrieved from firebase and returns the note owner
    ///We are sure the noteowner exists in local db because they were copied from firebase to local db immediately the user got to the dashboard
    final localNoteOwner =
        await _notesService.getUser(email: currentUsersEmail);

    ///create a new note and assign it to the owner just retrieved from the local db
    return await _notesService.createNote(noteOwner: localNoteOwner);
  }

  ///since a new note is automatically created when the user gets into the new note page
  ///This function deletes any newly created note that the user didnt proceed with providing the content
  ///and just decided to go back to dashboard or close the application
  void _deleteNoteWithEmptyContent() {
    ///A variable to hold the note created from the local db
    final potentialNote = _newNote;

    ///if the user didnt type anything (empty noteContentConroller)
    ///and the local db has a note created already since it was created when they clicked on new note,
    ///then delete the note from local db with the Id similar to the the one assigned to new note varibale
    ///when they got into the new note page
    if (_noteTextContentController.text.isEmpty && potentialNote != null) {
      _notesService.deleteSingleNote(id: potentialNote.noteId);
    }
  }

  ///most current applications dont need a save button
  ///the app should track the user content changes and automatically update when they leave that screen
  ///meaning the app needs to automatically save a note as long as there is any content in it
  ///A fucntion that automatically saves a note when the content is not empty
  void _saveNoteContainingContent() async {
    ///A variable to hold the note created from the local db
    final acceptableNote = _newNote;

    ///text content that the user has typed
    final noteContent = _noteTextContentController.text;

    ///if the note exists in the local db meaning it was successfully created on launching new note
    ///and the user has typed something in the note textfield which is captured by the noteContentController
    ///then update the already created empty note in the local db with the typed content
    if (acceptableNote != null && noteContent.isNotEmpty) {
      await _notesService.updateNote(
          note: acceptableNote, noteTextContent: noteContent);
    }
  }

  ///the update of the local db will happen as the user is typing the note (simultanously)
  ///and not as they leave the new note screen
  /// to achieve this we need a text controller listener which is basically a fucntion
  /// that takes the curents notecontentcontrollers text and update the note in the local db
  /// its an async fucntion called only when the text in the  _noteTextContentController changes
  void _noteTextContentControllerListener() async {
    ///the current note to add content into
    final currentNote = _newNote;

    ///if it is null, do nothing (this means the user has opened the note but isn't typing)
    if (currentNote == null) {
      return;
    }

    ///the current text in the _noteTextContentController
    final currentNoteContent = _noteTextContentController.text;

    /// when the user starts typing,
    /// take the current note from db and
    /// add currentNotecontent into the local db of that specific note
    await _notesService.updateNote(
        note: currentNote, noteTextContent: currentNoteContent);
  }

  ///the _noteTextContentControllerListener keeps on being added and removed dependng
  ///on whether the user is typing or not added when they are typing, removed when they stop
  ///to achieve this, This fucntion  that setsup the _noteTextContentControllerListener is required
  void _setupNoteTextContentControllerListener() {
    ///remove the listener when the note owner is not typing which we know because the  _noteTextContentController doesnt register any changes in the note
    _noteTextContentController
        .removeListener(_noteTextContentControllerListener);

    ///return the listener when the  note owner is typing which we know because the  _noteTextContentController registers new changes
    _noteTextContentController.addListener(_noteTextContentControllerListener);
  }

  ///When leaving the page automatically perform the following
  @override
  void dispose() {
    ///delete the note if it has no content
    _deleteNoteWithEmptyContent();

    /// Save the note if it has some content
    _saveNoteContainingContent();

    ///Dispose the text controller
    _noteTextContentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(kMediumWidth),
      child: SafeArea(
          child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Type below to create your",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const WidgetSeperator(),
            Text(
              "New Note",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const WidgetSeperator(),
            FutureBuilder(
              /// call a database note function that creates a note and returns it
              future: creaateNewNote(),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {

                  ///when the new note is created, we return
                  case ConnectionState.done:

                    ///snapshot data is of type database note
                    ///we use it to get our notes from the snapshot as follows
                    _newNote = snapshot.data as DatabaseNotes?;

                    ///then we need to strt listening to user text changes on the notetextcontentcontroller
                    ///we use the setup notetextcontentcontroller to start and stop the listening as needed
                    _setupNoteTextContentControllerListener();

                    ///return a textfield for user to enter their note text content
                    return TextField(
                      controller: _noteTextContentController,
                      decoration: const InputDecoration(
                        labelText: 'Create new note',
                        hintText: 'Type your note here',
                        prefixIcon: Icon(Icons.pending_actions_outlined),
                      ),

                      ///allow for multiline text input
                      keyboardType: TextInputType.multiline,

                      ///to create a textfiled with multtiline that expands we type we use assign null to max lines parameter
                      maxLines: null,
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
    );
  }
}
