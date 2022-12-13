import 'package:firebase_auth/firebase_auth.dart'
    show FirebaseAuth, FirebaseAuthException;
import 'package:firebase_core/firebase_core.dart';
import 'auth_exceptions.dart';
import 'auth_providers.dart';
import 'auth_user.dart';
import 'package:notidy/firebase_options.dart';

///This file implements the abstract auth provider functionalities specifically for firebase
///this file needs the exceptions file to show the auth errors to user,
///it needs access to the user via auth user inorder to manipulate their state as mandated by auth provider whose
///sign in and sign up fucntions need to return a user
/// it needs the auth_provider inorder to successfully create an instance of a user and
/// manipulate their state following the auth provider's  allowed functionalities since the auth provider is just an abstract / template class of user auth permitted functionalities
/// like sign in, sign out and sing up
/// This file will also access firebase specifically the auth and auth exceptions

///this class copies / instantiates from the auth provider template
class FirebaseAuthProvider implements AuthProvider {
  ///impliment the firebase initialization as demanded by auth_provider template
  @override
  Future<void> initializeFirebase() async {
    /// we use the inbuilt firebase action to initialize our application
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  ///get the currentUser
  @override
  AuthUser? get currentUser {
    ///get the user from firebase using the inbuilt FirebaseAuth method
    final appUser = FirebaseAuth.instance.currentUser;

    ///if there is a user, pass them to the auth user class
    if (appUser != null) {
      return AuthUser.fromFirebase(appUser);
    } else {
      return null;
    }
  }

  @override

  ///create a firebase user
  Future<AuthUser> createUser({
    required String authProviderType,
    required String authProviderPassword,
  }) async {
    try {
      ///this is not immidiate thus needs to await the creation of the user

      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        ///and then pass those credentials to the local authId and authPassword
        email: authProviderType,
        password: authProviderPassword,
      );

      ///lets get our user which we did with the help of the current user getter
      ///we just need to know whether the user  exists in firebase and no other manipulation so let's use the currentuser fucntion
      final appUser = currentUser;

      ///if the user actually exists in firebase
      if (appUser != null) {
        ///return that user
        return appUser;
      } else {
        ///then tell user that they are not logged in
        ///remember they are looged in to firebase immidiately they create their account and awaiting
        ///email verification
        throw UserNotLoggedInAuthException();
      }

      ///catch known firebase auth exception errors listed in the auth exceptions file
    } on FirebaseAuthException catch (error) {
      if (error.code == 'email-already-in-use') {
        throw EmailAlreaadyInUseAuthException();
      } else if (error.code == 'invalid-email') {
        throw InvalidEmailAuthException();
      } else if (error.code == 'weak-password') {
        throw WeakPasswordAuthException();
      } else if (error.code == 'unknown') {
        throw UnknownAuthException();

        ///Other firebase auth errors that we may not know will be displayed by this else
      } else {
        throw GenericAuthException();
      }
    }

    ///when the error has nothing to do with firebase but another kinds of exceptions
    catch (error) {
      throw GenericAuthException();
    }
  }

  @override
  Future<void> sendEmailVerification() async {
    /// get the current user from firebase and not from curent user because
    ///We need more than just checking if the user exists  in firebase which is all current user function offers
    ///as seen in the auth_user file.
    ///So we need to get the full scope of the user functions from firebase which includes the sending email verification
    final appUser = FirebaseAuth.instance.currentUser;

    /// if the user exists in firebase, send them an email verification
    if (appUser != null) {
      await appUser.sendEmailVerification();
    } else {
      /// tell the user they are not logged in
      /// you cannot send an email to a user who isnt logged into firebase
      throw UserNotLoggedInAuthException();
    }
  }

  @override
  Future<AuthUser> signIn({
    required String authProviderType,
    required String authProviderPassword,
  }) async {
    try {
      ///try to log in with email and password and
      ///pass the received credentials to the local auth ID and password
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: authProviderType,
        password: authProviderPassword,
      );

      ///rememeber we must return a user as demanded by the auth exception abstract class
      ///so let's get the current User and also ensure that after signing in, he actually exists
      ///we just need to know whether the user exists in firebase and no other manipulation so let's use the currentuser fucntion

      final appUser = currentUser;

      ///check if user exists and if they do, return them to app
      if (appUser != null) {
        return appUser;
      } else {
        throw UserNotLoggedInAuthException();
      }

      ///if the logging in doesn't work, use exceptions to tell the user why it didn't work
    } on FirebaseAuthException catch (error) {
      if (error.code == 'user-not-found') {
        throw UserNotFoundAuthException();
      } else if (error.code == 'wrong-password') {
        throw WrongPasswordAuthException();
      } else if (error.code == 'invalid-email') {
        throw InvalidEmailAuthException();
      } else if (error.code == 'unknown') {
        throw UnknownAuthException();

        ///Other firebase auth errors that we may not know will be displayed by this else
      } else {
        throw GenericAuthException();
      }
    }

    ///when the error has nothing to do with firebase but another kinds of exceptions
    catch (_) {
      throw GenericAuthException();
    }
  }

  @override
  Future<void> signOut() async {
    ///In order for the user sign out, they first need to exist
    ///We need more than just checking if the user exists  in firebase which is all current user function offers
    ///as seen in the auth_user file.
    ///So we need to get the full scope of the user functions from firebase which includes the inbuillt firebase signout fucntion

    final appUser = FirebaseAuth.instance.currentUser;

    ///if the user exists, log them out of firebase
    if (appUser != null) {
      await FirebaseAuth.instance.signOut();
    } else {
      ///otherwise return  user not logged in auth exception
      throw UserNotLoggedInAuthException();
    }
  }
}
