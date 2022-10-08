import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:online_attendence_app/constants/network_objects.dart';

class GoogleSignInServies {
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<User?> signInWithGoogle() async {
    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount!.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final authResult = await firebaseAuth.signInWithCredential(credential);

    if (authResult.additionalUserInfo!.isNewUser) {
    } else {}

    final User? user = authResult.user;

    assert(!user!.isAnonymous);
    assert(await user!.getIdToken() != null);

    final User? currentUser = firebaseAuth.currentUser;
    assert(user!.uid == currentUser!.uid);

    return currentUser;
  }

  void signOutGoogle() async {
    await googleSignIn.signOut();
  }
}
