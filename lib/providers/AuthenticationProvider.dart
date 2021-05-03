import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'BaseProviders.dart';

class AuthenticationProvider extends BaseAuthenticationProvider {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  @override
  Future<User> signInWithGoogle() async {
    final GoogleSignInAccount account =
        await googleSignIn.signIn(); //show the google login prompt
    final GoogleSignInAuthentication authentication =
        await account.authentication; //get the authentication object
    final AuthCredential credential = GoogleAuthProvider.credential(
        //retreive the authentication credentials
        idToken: authentication.idToken,
        accessToken: authentication.accessToken);
    await firebaseAuth.signInWithCredential(
        credential); //sign in to firebase using the generated credentials
    //return currentUser;
    return firebaseAuth.currentUser; //return the firebase user created
  }

  @override
  Future<void> signOutUser() async {
    return Future.wait([firebaseAuth.signOut(), googleSignIn.signOut()]);
  }

  @override
  Future<User> getCurrentUser() async {
    return firebaseAuth.currentUser;
  }

  Future<bool> isLoggedIn() async {
    final user = firebaseAuth.currentUser;
    return user != null;
  }
}
