///The auth service acts as the link / messanger between the auth provider and the UI
///It takes the specific provided functionalities from the auth provider and exposes them to the UI

import 'package:notidy/services/auth/auth_providers.dart';
import 'package:notidy/services/auth/auth_user.dart';

///Note that this service has absolutely no direct access to firebase
///that's all done by firebase_auth_provider which directly accesses firebase and passes the content to auth provider
///as well as perform manipulations like sign out
///and then this service just accesses the functionalities and returned values in the auth provider
class AuthService implements AuthProvider {
  ///In turn this service fetches passed content in auth provider and also fucntionalities
  /// from the auth provider and passes them to the UI
  ///it accesses auth provider via an instance of the provider below
  final AuthProvider authProviderInstance;

  ///create a constructor
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
