///This is just an abstract class that dictates the rules / scope that every
///auth provider must adhere to and what functionality they can carry out

import 'package:notidy/services/auth/auth_user.dart';

///This rules are applicable to all possible auth providers
///like email and password, gmail, facebook, phone etc

abstract class AuthProvider {
  ///the provider must first optionally return the current user
  ///with the help of the auth_user since in this case is resposnible for collecting the user from firebase
  AuthUser? get currentUser;

  ///Allow the auth provider to log into the application
  ///and must return a user or give error exceptions
  Future<AuthUser> signIn(

      ///every auth provider must have a unique id like email, phone number username etc and password to allow log in
      {
    required String authId,
    required String authPassword,
  });

  ///Allow whichever the auth provider you use to sign up to the app
  ///and must return a user or give error exceptions
  Future<AuthUser> createUser({
    ///every auth provider must have a unique id like email, phone number username etc and password to allow sign up

    required String authId,
    required String authPassword,
  });

  ///Allow whichever the auth provider you use to sign out
  ///this doesnt return anything
  Future<void> signOut();

  ///Allow whichever the auth provider you use to send email verification
  Future<void> sendEmailVerification();
}
