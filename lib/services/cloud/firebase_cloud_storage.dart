import 'package:cloud_firestore/cloud_firestore.dart';
import 'cloud_note.dart';
import 'cloud_storage_constants.dart';
import 'cloud_storage_exceptions.dart';

class FirebaseCloudStorage {
  ///getting the collection from firebase cloud
  ///you need to have created the collection in the cloud storage for this to work
  ///which is like  a stream we can read and write to (but refered to collection because you can only read from a stream)
  final notes = FirebaseFirestore.instance.collection('notes');

  ///a void function that updates the notes
  ///requires the id of the document(table) and the field that needs editing(noteContent)
  Future<void> deleteNote({required String documentId}) async {
    try {
      await notes.doc(documentId).delete();
    } catch (e) {
      ///throw an exception if delete was unsuccessful
      throw CouldNotDeleteNoteException();
    }
  }

  ///a void function that updates the notes
  ///requires the id of the document(table) and the field that needs editing(noteContent)
  Future<void> updateNote({
    required String documentId,
    required String noteContent,
  }) async {
    try {
      ///the doc represents the path ie notescollection/documentid(tableid)/fieldname
      await notes.doc(documentId).update({textFieldName: noteContent});
    } catch (e) {
      ///if for some reason you cant update the note, throw an exception
      throw CouldNotUpdateNoteException();
    }
  }

  ///A strem iterable that helps updates the notes list UI with the list of all notes
  ///should be of type of the custom cloud note already defined

  Stream<Iterable<CloudNote>> allNotes({required String userId}) =>

      ///snapshot allows you to subscribe to the data from cloud storage as it changes (live)
      notes.snapshots().map(
            ///get a map of all the documents in cloud storage
            (event) => event.docs

                /// present each document (note) using the cloud note class template
                .map((doc) => CloudNote.fromSnapshot(doc))

                ///but give only documents of the specified user based on their id
                ///which is arequirement of this stream in the first place
                .where((note) => note.ownerUserId == userId),
          );

  ///A fucntion that creates and returns a new note
  Future<CloudNote> createNewNote({required String userId}) async {
    ///add accepts objects with keys and values (documents ie fields and values)
    ///add the fields (documents)
    final document = await notes.add({
      ownerUserIdFieldName: userId,
      textFieldName: '',
    });

    ///get the snapshot of the actual document
    final fetchedNote = await document.get();
    return CloudNote(
      documentId: fetchedNote.id,
      ownerUserId: userId,
      noteContent: '',
    );
  }

  ///A function to get all notes of a specific user
  ///which requires an users Id and returns an iterable of type of the custom cloudNote
  Future<Iterable<CloudNote>> getNotes({required String userId}) async {
    ///do a search inside the notes collection to get all notes of  specific user
    try {
      return await notes
          .where(
            ownerUserIdFieldName,
            isEqualTo: userId,
          )
          .get()
          .then((value) => value.docs.map(

              ///return a cloudnote based on the custom created cloudNote class template
              (doc) => CloudNote.fromSnapshot(doc)));
    } catch (e) {
      ///if for some reason you cant get the notes throw an exception
      throw CouldNotGetAllNotesException();
    }
  }

  ///it's a bad idea to keep initializing (making new copies) of the Firebase cloud storage (init function) when we utilize it
  ///Instead, we can ensure the initialization of Firebase cloud storage happens only once (one instance) in the entire application using a singleton
  ///a singleton is a design pattern that allows you to ensure that a class has only one instance,
  ///while providing a global access point to this instance.
  ///This will prevent other classes from creating instances of our singleton class FirebaseCloudStorage
  ///This field will hold the single instance of your class.
  static final FirebaseCloudStorage _sharedNotes =
      FirebaseCloudStorage._sharedNotesInstance();

  ///A private constructor to hold the singleton instance:
  FirebaseCloudStorage._sharedNotesInstance();

  ///A factory constructor that gets called to get the singleton instance
  ///returns the single instance of the class Firebase cloud storage ,
  ///and will create the instance if it doesn't exist yet.
  factory FirebaseCloudStorage() => _sharedNotes;

  ///Grab all notes from cloud storage
}
