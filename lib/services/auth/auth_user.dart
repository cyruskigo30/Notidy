///This file does two things
/// 1) just checks if the users email is verified in firebase
/// 2) optionally fetch the users email from firebase
import 'package:flutter/material.dart';

///In this file we just need the user property from firebase
///we then take an instance of that firebase user and share it's instance with our own local fireabse auth user constructor
import 'package:firebase_auth/firebase_auth.dart' show User;

///our local AuthUser constructor
///Immutable meaning the internals will not not change upon initialization

@immutable
class AuthUser {
  ///We need to know whether the user has verified email or not as required by login screen
  final bool isEmailVerified;

  ///This variable holds the email address received from firebase in auth user
  final String? authEmail;

  /// Const since we don't intend working any changes on this but just interested in its state
  const AuthUser({
    required this.authEmail,
    required this.isEmailVerified,
  });

  ///This factory user constructor contacts firebase
  ///gets the status of the registered email from firebase and assigns it to the varibale isEmailVerified in the local AuthUser constructor
  ///gets the email address of the registred user from firebase and assigns it to the varibale authEmail in the local AuthUser constructor
  /// All through the instance user of the firebase inbuilt User object
  factory AuthUser.fromFirebase(User user) => AuthUser(
        isEmailVerified: user.emailVerified,
        authEmail: user.email,
      );
}
