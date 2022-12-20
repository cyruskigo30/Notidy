///This is the point of contact with the sql database
///it'll find users, create users, find notes
///delete users, create notes basically every asction the app needs
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'crud_exceptions.dart';
import 'sql_commands.dart';

/// the notesService class performs all the db
/// fucntionalities using custom dart defined database
///  definitions and parameters below
/// The operations arent immidiate so it will be async
class NotesService {
  ///A local db  which can be null at the beginning
  Database? _localDb;

  ///Future function to open the database
  Future<void> openDb() async {
    ///test whether the local db is open
    /// if it is, throw an exception already open and the app functions can proceed
    if (_localDb != null) {
      ///exception
      throw DatabaseAlreadyOpenCrudException;
    }

    ///Try to open the docs path if the db is already open
    ///using path provider fucntion getApplicationSupportDirectory()
    try {
      final documentsPath = await getApplicationSupportDirectory();

      ///join the database path and custom defined  database name variable
      ///using join, a fucntionality of path depedency
      final databasePath = join(documentsPath.path, databaseName);

      ///Open databse with a sqlite inbuilt fucntion openDatabase()
      ///Await on it
      final appDatabase = await openDatabase(databasePath);

      ///Assign opened sqlite databse to local database
      _localDb = appDatabase;

      /// create users table by executing the sql command
      await appDatabase.execute(createUsersTable);

      /// create notes table by executing the sql command
      await appDatabase.execute(createNotesTable);

      /// By default, it may throw an exception `MissingPlatformDirectoryException` if the system is unable to
      /// provide the directory on a supported platform.
    } on MissingPlatformDirectoryException {
      /// if that exception occurs, we call our own custom exception
      throw UnableToGetDocumentsDirectoryCrudException();
    }
  }

  ///Future Fucntion to close the Database
  Future<void> closeDb() async {
    ///custome local Db instance
    final db = _localDb;

    /// Can't close a databse if it's not open
    /// throw exception if one tries to
    if (db == null) {
      throw DatabaseNotOpenCrudException();
    } else {
      ///ask sqlite to close the database
      await db.close();

      ///then reset the local database state
      _localDb = null;
    }
  }

  ///we need a database state checker
  ///All editing and database data manipulation depends on the state of the database (open or closed)
  ///We need a function that checks that state
  ///so that depending on that state we either get the database and start manipulation
  /// or receive an exception (This eliminates the need to use if statements everywhere)
  Database getDatabaseOrThrow() {
    final db = _localDb;

    ///if there is no database
    if (db == null) {
      ///throw exception
      throw DatabaseNotOpenCrudException();
    } else {
      ///otherwise return the available database
      return db;
    }
  }

  ///Function to delete users from the database
  Future<void> deleteUser({required String email}) async {
    ///get our database or throw database not open
    final db = getDatabaseOrThrow();

    ///this will delete  account based on email address
    ///because they are unique in the db
    final deletedUser = await db.delete(
      userTable,
      where: 'userEmail = ?',
      whereArgs: [email.toLowerCase()],
    );

    ///fi the deleted count isn't of value 1 throw a custom crud exception
    if (deletedUser != 1) {
      throw CouldNotDeleteUserCrudException();
    }
  }

  Future<DatabaseUser> createUser({required String email}) async {
    ///Ge the database or throw an exception
    final db = getDatabaseOrThrow();

    ///check if the user with that particular email exists in the db
    ///which returns an empty list if the user doesnt exist
    ///check users table, and limit results to one, where email is the one provided,
    ///and ensure it is in lowercase
    final dbUserCheckResults = await db.query(
      userTable,
      limit: 1,
      where: 'email = ?',
      whereArgs: [email.toLowerCase()],
    );

    ///if that email exists throw an exeption that email already exists
    ///which it cannot be used to create a new user
    if (dbUserCheckResults.isNotEmpty) {
      throw UserAlreadyExistsCrudException();
    }

    ///if the email doesnt exist and passes above criteria
    ///we insert the new email into the db
    ///ignore the id fields since it is auto increment
    ///add the email in lowercase to the useremailColumn
    /// inserts a map of values to specified table and returns the id of last inserted row
    final id = await db.insert(
      userTable,
      {userEmailColumn: email.toLowerCase()},
    );
    return DatabaseUser(
      userId: id,
      userEmail: email,
    );
  }

  ///Fucntion to return a user given their email address
  Future<DatabaseUser> getUser({required String email}) async {
    ///check if databse exists
    final db = getDatabaseOrThrow();

    ///check if the user with that particular email exists in the db
    ///which returns an empty list if the user doesnt exist
    ///check users table, and limit results to one, where email is the one provided,
    ///and ensure it is in lowercase
    final dbUserCheckResults = await db.query(
      userTable,
      limit: 1,
      where: 'email = ?',
      whereArgs: [email.toLowerCase()],
    );

    ///if there is no such user in the db
    ///return exception that could not find that user
    if (dbUserCheckResults.isEmpty) {
      throw CouldNotFindThatUserCrudException();
    } else {
      ///return the first row of the databse search results
      ///essentially results will be one row as set in the limit
      return DatabaseUser.fromRow(dbUserCheckResults.first);
    }
  }

  ///create notes function
  ///returns a databse of notes
  ///it requires the note owner
  Future<DatabaseNotes> createNote({required DatabaseUser noteOwner}) async {
    final db = getDatabaseOrThrow();

    ///ensure the user who is creating the note actually exists
    ///we can easily use the getUser fucntion for this
    final dbUser = await getUser(email: noteOwner.userEmail);

    ///ensure the note owner exists in the database with the correct id
    ///if they don't throw an exception
    if (dbUser != noteOwner) {
      throw CouldNotFindThatUserCrudException();
    }

    ///if we found thenote owner with the right id in the db
    ///proceed to create a note]
    const noteText = '';

    ///insert the notes into the database using a map of the db assigned values
    final noteId = await db.insert(
      notesTable,
      {
        usersIdColumn: noteOwner.userId,
        noteContentColumn: noteText,
        isSyncedWithServerColumn: 1,
      },
    );

    ///return a database note
    final createdNote = DatabaseNotes(
      noteId: noteId,
      usersId: noteOwner.userId,
      noteContent: noteText,
      isSyncedWithServer: true,
    );

    ///the return the note
    return createdNote;
  }

  ///Function to delete a note from the db
  ///requires the noteId but doesnt return anything
  Future<void> deleteNote({required int id}) async {
    final db = getDatabaseOrThrow();

    ///if the given note id exists then we delete it
    final deletedNote = await db.delete(
      notesTable,
      where: 'id =?',
      whereArgs: [id],
    );

    ///if we didn't delete anything because that note doesn't exist
    ///throw an exception
    if (deletedNote == 0) {
      throw CouldNotDeleteNoteCrudException();
    }
  }

  ///Function to delete all notes
  Future<int> deleteAllNotes() async {
    final db = getDatabaseOrThrow();

    ///delete alll notes in the table
    ///returns number of rows affected
    return await db.delete(notesTable);
  }

  ///Function to fetch a specific note
  Future<DatabaseNotes> getSpecificNote({required int id}) async {
    final db = getDatabaseOrThrow();

    ///query the db to return a list of notes with a limit of one
    final openedNote = await db.query(
      notesTable,
      limit: 1,
      where: 'id = ?',
      whereArgs: [id],
    );

    ///if the list generated doesn't have any notes to open
    if (openedNote.isEmpty) {
      throw CouldNotFindNoteCrudException();
    } else {
      ///if a note was found
      ///return instance of the db
      return DatabaseNotes.fromRow(openedNote.first);
    }
  }

  ///Get all Notes for a specific user
  Future<Iterable> getAllNotes() async {
    final db = getDatabaseOrThrow();

    ///query the db to return a list of notes with a limit of one
    final allNotes = await db.query(
      notesTable,
    );
    return allNotes.map((noteRow) => DatabaseNotes.fromRow(noteRow));
  }

  ///Fucntion to update notes
  Future<DatabaseNotes> updateNote({
    required DatabaseNotes note,
    required String noteText,
  }) async {
    final db = getDatabaseOrThrow();
    //ensure the note exists before update
    await getSpecificNote(id: note.noteId);

    final updatedRow = await db.update(notesTable, {
      noteContentColumn: noteText,
      isSyncedWithServerColumn: 0,
    });

    ///if no rows are updated
    if (updatedRow == 0) {
      throw CouldNotUpdateNoteCrudException();
    } else {
      ///return updated note id
      return await getSpecificNote(id: note.noteId);
    }
  }
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
const databaseName = 'notidy.db';

///declare notes table
const notesTable = 'notes';

///Delcare users table
const userTable = 'users';
