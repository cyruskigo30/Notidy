///define a superclass for all our cloud exceptions
class CloudStorageException implements Exception {
  const CloudStorageException();
}

///C in CRUD - create
class CouldNotCreateNoteException extends CloudStorageException {}

///R in CRUD - read
class CouldNotGetAllNotesException extends CloudStorageException {}

///U in CRUD - update
class CouldNotUpdateNoteException extends CloudStorageException {}

///D in CRUD - delete
class CouldNotDeleteNoteException extends CloudStorageException {}
