import 'package:notidy/services/auth/auth_providers.dart';
import 'package:notidy/services/auth/auth_user.dart';

///The auth service acts as the link / messanger between providers and the UI
///It takes the specific provided functionalities from the providers and exposes them to the UI
///it also utilizes the auth provider's dectated fucntionalities
class AuthService implements AuthProvider {
  ///Auth service had no access to firebase, that's all done by firebase_auth_provider
  ///which passes accessed firebase content to auth provider and also manipulates user firebase content and state
  ///and in turn this file fetches that content from auth provider and shares with the UI
  ///we need to first create an instace of the auth provider
  final AuthProvider authProviderInstance;

  ///create a constructot
  const AuthService(this.authProviderInstance);

  ///import  and expose all allowed  auth provider functionalities to the UI
  ///which is essentially the purpose of auth service
  @override
  Future<AuthUser> createUser({
    required String authId,
    required String authPassword,

    /// now we
  }) =>
      authProviderInstance.createUser(
        authId: authId,
        authPassword: authPassword,
      );

  @override
  AuthUser? get currentUser => authProviderInstance.currentUser;

  @override
  Future<void> sendEmailVerification() =>
      authProviderInstance.sendEmailVerification();

  @override
  Future<AuthUser> signIn({
    required String authId,
    required String authPassword,
  }) =>
      authProviderInstance.signIn(
        authId: authId,
        authPassword: authPassword,
      );

  @override
  Future<void> signOut() => authProviderInstance.signOut();
}
