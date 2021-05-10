import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:text_now/models/Utilizer.dart';

@immutable
abstract class AuthenticationState extends Equatable {
  AuthenticationState([List props = const <dynamic>[]]); // : super(props);
}

class Uninitialized extends AuthenticationState {
  @override
  String toString() => 'Uninitialized';

  List<Object> get props => [Uninitialized];
}

class AuthInProgress extends AuthenticationState {
  @override
  String toString() => 'AuthInProgress';

  List<Object> get props => [AuthInProgress];
}

class Authenticated extends AuthenticationState {
  final User user;
  Authenticated(this.user);
  @override
  String toString() => 'Authenticated';

  List<Object> get props => [Authenticated];
}

class PreFillData extends AuthenticationState {
  final Utilizer user;
  PreFillData(this.user);
  @override
  String toString() => 'PreFillData';

  List<Object> get props => [PreFillData];
}

class UnAuthenticated extends AuthenticationState {
  @override
  String toString() => 'UnAuthenticated';

  List<Object> get props => [UnAuthenticated];
}

class ReceivedProfilePicture extends AuthenticationState {
  final File file;
  ReceivedProfilePicture(this.file);
  @override
  toString() => 'ReceivedProfilePicture';

  List<Object> get props => [ReceivedProfilePicture];
}

class ProfileUpdateInProgress extends AuthenticationState {
  @override
  String toString() => 'ProfileUpdateInProgress';

  List<Object> get props => [ProfileUpdateInProgress];
}

class ProfileUpdated extends AuthenticationState {
  @override
  String toString() => 'ProfileComplete';

  List<Object> get props => [ProfileUpdated];
}
