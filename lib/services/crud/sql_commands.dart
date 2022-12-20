///Create a users table
///tripple quote marks allow insertion of sql commands
///create the users table if it doesn't exist
const createUsersTable = '''
CREATE TABLE IF NOT EXISTS "users" (
	"user_id"	INTEGER NOT NULL,
	"user_email"	TEXT NOT NULL UNIQUE,
	PRIMARY KEY("user_id" AUTOINCREMENT)
);

''';

///create notes table
///sql command
const createNotesTable = '''

CREATE TABLE  IF NOT EXISTS "notes" (
	"note_id"	INTEGER NOT NULL,
	"note_content"	TEXT,
	"is_synced_with_server"	INTEGER NOT NULL DEFAULT 0,
	"users_id"	INTEGER NOT NULL,
	FOREIGN KEY("users_id") REFERENCES "users"("user_id"),
	PRIMARY KEY("note_id" AUTOINCREMENT)
);

''';
