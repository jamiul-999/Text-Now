import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:text_now/models/user_.dart';

@immutable
abstract class AuthenticationState extends Equatable {
  AuthenticationState([List props = const <dynamic>[]]); // : super(props);
}

class Uninitialized extends AuthenticationState {
  @override
  String toString() => 'Uninitialized';

  @override
  // TODO: implement props
  List<Object> get props => [Uninitialized];
}

class AuthInProgress extends AuthenticationState {
  @override
  String toString() => 'AuthInProgress';

  @override
  // TODO: implement props
  List<Object> get props => [AuthInProgress];
}

class Authenticated extends AuthenticationState {
  final User user;
  Authenticated(this.user);
  @override
  String toString() => 'Authenticated';

  @override
  // TODO: implement props
  List<Object> get props => [Authenticated];
}

class PreFillData extends AuthenticationState {
  final User user;
  PreFillData(this.user);
  @override
  String toString() => 'PreFillData';

  @override
  // TODO: implement props
  List<Object> get props => [PreFillData];
}

class UnAuthenticated extends AuthenticationState {
  @override
  String toString() => 'UnAuthenticated';

  @override
  // TODO: implement props
  List<Object> get props => [UnAuthenticated];
}

class ReceivedProfilePicture extends AuthenticationState {
  final File file;
  ReceivedProfilePicture(this.file);
  @override
  toString() => 'ReceivedProfilePicture';

  @override
  // TODO: implement props
  List<Object> get props => [ReceivedProfilePicture];
}

class ProfileUpdateInProgress extends AuthenticationState {
  @override
  String toString() => 'ProfileUpdateInProgress';

  @override
  // TODO: implement props
  List<Object> get props => [ProfileUpdateInProgress];
}

class ProfileUpdated extends AuthenticationState {
  @override
  String toString() => 'ProfileComplete';

  @override
  // TODO: implement props
  List<Object> get props => [ProfileUpdated];
}
