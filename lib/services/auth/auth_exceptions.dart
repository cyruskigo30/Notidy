///Showing all auth error exceptions
///Sign in exceptions
class UserNotFoundAuthException implements Exception {}

class WrongPasswordAuthException implements Exception {}

class InvalidEmailAuthException implements Exception {}

class UnknownAuthException implements Exception {}

///Sign up exceptions
class EmailAlreaadyInUseAuthException implements Exception {}

class WeakPasswordAuthException implements Exception {}

///Generic auth exceptions

class GenericAuthException implements Exception {}

class UserNotLoggedInAuthException implements Exception {}
