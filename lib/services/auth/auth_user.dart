///This file just checks if the user exists in firebase
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

  /// Const since we don't intend working any changes on this but just interested in its state
  const AuthUser(this.isEmailVerified);

  ///We create a factory user constructor whose job is to contact firebase
  ///and get our local constructor a copy of the firebase auth user account verification status
  ///The connstructor just accesses firebase User object and copies the status of the users email
  ///then gives it to our local constructor AuthUser above
  ///This fucntion only fetches and allows the use of verification status of the user and no other fucntionalities
  factory AuthUser.fromFirebase(User user) => AuthUser(user.emailVerified);
}
