import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:text_now/pages/ConversationPageSlide.dart';
import 'package:text_now/repositories/AuthenticationRepository.dart';
import 'package:text_now/repositories/StorageRepository.dart';
import 'package:text_now/repositories/UserDataRepository.dart';
import 'config/Palette.dart';
import 'pages/RegisterPage.dart';
import 'blocs/authentication/Bloc.dart';

void main() {
  final AuthenticationRepository authRepository = AuthenticationRepository();
  final UserDataRepository userDataRepository = UserDataRepository();
  final StorageRepository storageRepository = StorageRepository();
  runApp(
    BlocProvider(
      create: (context) => AuthenticationBloc(
          authenticationRepository: authRepository,
          userDataRepository: userDataRepository,
          storageRepository: storageRepository)
        ..add(AppLaunched()),
      child: TextNow(
        authenticationRepository: authRepository,
        userDataRepository: userDataRepository,
        storageRepository: storageRepository,
      ),
    ),
  );
}

class TextNow extends StatelessWidget {
  // This widget is the root of your application.
  final AuthenticationRepository authenticationRepository;
  final UserDataRepository userDataRepository;
  final StorageRepository storageRepository;

  TextNow(
      {Key key,
      @required this.authenticationRepository,
      @required this.userDataRepository,
      @required this.storageRepository})
      : assert(authenticationRepository != null),
        assert(userDataRepository != null),
        assert(storageRepository != null),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Text Now',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Palette.primaryColor,
      ),
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is UnAuthenticated) {
            return RegisterPage();
          } else if (state is ProfileUpdated) {
            return ConversationPageSlide();
          } else {
            return RegisterPage();
          }
        },
      ),
    );
  }
}
