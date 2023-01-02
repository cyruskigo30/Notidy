import 'package:flutter/material.dart';
import '../../services/crud/notes_service.dart';
import '../../utils/dialogs/delete_dialog.dart';

/// A function in notes view that we can use as callback which when it's called
/// tells the notes view of which note has been clicked inorder to perform various actions on that
/// specific note like delete and update It accepts nothing but returns a note
typedef NoteCallBack = void Function(DatabaseNote note);

///this file isonly interested in  the list of notes to display
class NotesListView extends StatelessWidget {
  const NotesListView({
    super.key,
    required this.notes,
    required this.onDelete,
    required this.onClick,
  });
  final List<DatabaseNote> notes;

  ///declare custom delete note callback fucntion
  ///since the note call back function returns a note
  final NoteCallBack onDelete;

  ///when the user taps on the note we use the note call back to get the tapped note
  final NoteCallBack onClick;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: notes.length,
      itemBuilder: (context, index) {
        final currentNote = notes[index];
        return ListTile(
          ///on tapping the list tile, return the note clicked

          onTap: () {
            onClick(currentNote);
          },
          title: Text(
            currentNote.noteContent,
            style: Theme.of(context).textTheme.bodyLarge,
            maxLines: 1,
            softWrap: true,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: IconButton(
            /// call the delete dialog and returns a true or false
            onPressed: () async {
              final shouldDelete = await showDeleteDialog(context);

              ///if the dialog returns true, call/ execute the delete function
              if (shouldDelete) {
                onDelete(currentNote);
              }
            },
            icon: const Icon(
              Icons.delete,
            ),
          ),
        );
      },
    );
  }
}
