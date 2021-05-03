import 'dart:async';
import 'package:bloc/bloc.dart';
import './Bloc.dart';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:text_now/config/Paths.dart';
import 'package:text_now/models/user_.dart';
import 'package:text_now/repositories/AuthenticationRepository.dart';
import 'package:text_now/repositories/StorageRepository.dart';
import 'package:text_now/repositories/UserDataRepository.dart';
import 'package:text_now/utils/Validators.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  // AuthenticationBloc authenticationBloc;
  final AuthenticationRepository authenticationRepository;
  final UserDataRepository userDataRepository;
  final StorageRepository storageRepository;

  AuthenticationBloc(
      {this.authenticationRepository,
      this.userDataRepository,
      this.storageRepository})
      : assert(authenticationRepository != null),
        assert(userDataRepository != null),
        assert(storageRepository != null),
        super(null);

  @override
  AuthenticationState get initialState => Uninitialized();

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    print(event);
    if (event is AppLaunched) {
      yield* mapAppLaunchedToState();
    } else if (event is ClickedGoogleLogin) {
      yield* mapClickedGoogleLoginToState();
    } else if (event is LoggedIn) {
      yield* mapLoggedInToState(event.user);
    } else if (event is PickedProfilePicture) {
      yield ReceivedProfilePicture(event.file);
    } else if (event is SaveProfile) {
      yield* mapSaveProfileToState(
          event.profileImage, event.age, event.username);
    } else if (event is ClickedLogout) {
      yield* mapLoggedOutToState();
    }
  }

  Stream<AuthenticationState> mapAppLaunchedToState() async* {
    try {
      yield AuthInProgress();
      final isSignedIn = await authenticationRepository.isLoggedIn();
      if (isSignedIn) {
        final user = await authenticationRepository.getCurrentUser();
        bool isProfileComplete =
            await userDataRepository.isProfileComplete(user.uid);
        print(isProfileComplete);
        if (isProfileComplete) {
          yield ProfileUpdated();
        } else {
          yield Authenticated(user);
          add(LoggedIn(user));
        }
      } else {
        yield UnAuthenticated();
      }
    } catch (_, stacktrace) {
      print(stacktrace);
      yield UnAuthenticated();
    }
  }

  Stream<AuthenticationState> mapClickedGoogleLoginToState() async* {
    yield AuthInProgress();
    try {
      User firebaseUser = await authenticationRepository.signInWithGoogle();
      bool isProfileComplete =
          await userDataRepository.isProfileComplete(firebaseUser.uid);
      print(isProfileComplete);
      if (isProfileComplete) {
        yield ProfileUpdated();
      } else {
        yield Authenticated(firebaseUser);
        add(LoggedIn(firebaseUser));
      }
    } catch (_, stacktrace) {
      print(stacktrace);
      yield UnAuthenticated();
    }
  }

  Stream<AuthenticationState> mapLoggedInToState(User firebaseUser) async* {
    yield ProfileUpdateInProgress();
    User user =
        await userDataRepository.saveDetailsFromGoogleAuth(firebaseUser);
    yield PreFillData(user);
  }

  Stream<AuthenticationState> mapSaveProfileToState(
      File profileImage, int age, String username) async* {
    yield ProfileUpdateInProgress();
    String profilePictureUrl = await storageRepository.uploadImage(
        profileImage, Paths.profilePicturePath);
    User user = await authenticationRepository.getCurrentUser();
    await userDataRepository.saveProfileDetails(
        user.uid, profilePictureUrl, age, username);
    yield ProfileUpdated();
  }

  Stream<AuthenticationState> mapLoggedOutToState() async* {
    yield UnAuthenticated();
    authenticationRepository.signOutUser();
  }
}
