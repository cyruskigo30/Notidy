///This is the point of contact with the sql database
///it'll find users, create users, find notes
///delete users, create notes basically every asction the app needs
import 'package:flutter/foundation.dart';
// import 'package:sqflite/sqflite.dart';
// import 'package:path_provider/path_provider.dart'
//     show getApplicationDocumentsDirectory;
// import 'package:path/path.dart' show join;

/// the notesService class performs all the db 
/// fucntionalities using custom dart defined database
///  definitions and parameters below
class NotesService {
  
}
///lets create dart classes to represent the database tables
///create a user class for the users table
@immutable
class DatabaseUser {
  final int userId;
  final String userEmail;
  const DatabaseUser({
    required this.userId,
    required this.userEmail,
  });

  ///When we connect to the database we are going to read the table rows
  ///This means that every user in that table will be represented by the below row object
  DatabaseUser.fromRow(Map<String, Object?> map)
      : userId = map[userIdColumn] as int,
        userEmail = map[userEmailColumn] as String;

  ///If we need to print out these users to the console we use to string method
  @override
  String toString() => 'Person, ID =$userId, email = $userEmail';

  ///implement equality cheker for the bd user class
  ///we neeed to know whether two people retrieved from db are equal to each other or not
  ///covariant allows change of behoiur for input parameter so that they do not conform to signature of the parameter in superclass
  @override
  bool operator ==(covariant DatabaseUser other) => userId == other.userId;

  ///When you use the == operator to compare two objects in Dart,
  ///the hashCode method is automatically called on both objects to
  ///determine whether they are equal. If the hashCode values of the two objects are equal,
  ///then the objects are considered to be equal. If the hashCode values are different,
  ///then the objects are considered to be not equal.
  @override
  int get hashCode => userId.hashCode;
}

///Let's craete a class representation of the notes database
class DatabaseNotes {
  final int noteId;
  final int usersId;
  final String noteContent;
  final bool isSyncedWithServer;

  DatabaseNotes({
    required this.noteId,
    required this.usersId,
    required this.noteContent,
    required this.isSyncedWithServer,
  });

  ///When we connect to the database we are going to read the table rows
  ///This means that every note in that table will be represented by the below row object
  DatabaseNotes.fromRow(Map<String, Object?> map)
      : noteId = map[noteIdColumn] as int,
        usersId = map[usersIdColumn] as int,
        noteContent = map[noteContentColumn] as String,

        ///since  isSyncedWithServer is an integer,
        ///we have to convert it to boolean in dart when we receive it
        ///we use ternary operator that if the received integer from the column is 1 then we make it true
        ///else we make it false (zero was the default value in db which means it starts off as false)
        isSyncedWithServer =
            (map[isSyncedWithServerColumn] as int) == 1 ? true : false;

  ///If we need to print out these notes to the console we use to string method
  @override
  String toString() =>
      'Note, ID =$noteId, userId = $usersId, isSyncedWithServer = $isSyncedWithServer, NoteContent = $noteContent ';

  ///implement equality cheker for the bd user class
  ///we neeed to know whether two people retrieved from db are equal to each other or not
  ///covariant allows change of behoiur for input parameter so that they do not conform to signature of the parameter in superclass
  @override
  bool operator ==(covariant DatabaseNotes other) => noteId == other.noteId;

  ///When you use the == operator to compare two objects in Dart,
  ///the hashCode method is automatically called on both objects to
  ///determine whether they are equal. If the hashCode values of the two objects are equal,
  ///then the objects are considered to be equal. If the hashCode values are different,
  ///then the objects are considered to be not equal.
  @override
  int get hashCode => noteId.hashCode;
}

/// declare the name of the columns int the users table as named in the database fields
const userIdColumn = "user_id";
const userEmailColumn = "user_email";

/// declare the name of the columns int the notes table  as named in the database fields
const noteIdColumn = "note_id";
const usersIdColumn = "users_id";
const noteContentColumn = "note_content";
const isSyncedWithServerColumn = "is_synced_with_server";

///Declare other imprtant database variables
///The database
const dbName = 'notidy.db';

///declare notes table
const notesTable = 'notes';

///Delcare users table
const userTable = 'users';
