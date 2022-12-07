import 'package:notidy/services/auth/auth_providers.dart';
import 'package:notidy/services/auth/auth_user.dart';

void main() {}

class MockAuthProvider implements AuthProvider {
  @override
  Future<AuthUser> createUser(
      {required String authId, required String authPassword}) {
    // TODO: implement createUser
    throw UnimplementedError();
  }

  @override
  // TODO: implement currentUser
  AuthUser? get currentUser => throw UnimplementedError();

  @override
  Future<void> initializeFirebase() {
    // TODO: implement initializeFirebase
    throw UnimplementedError();
  }

  @override
  Future<void> sendEmailVerification() {
    // TODO: implement sendEmailVerification
    throw UnimplementedError();
  }

  @override
  Future<AuthUser> signIn(
      {required String authId, required String authPassword}) {
    // TODO: implement signIn
    throw UnimplementedError();
  }

  @override
  Future<void> signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }
}
