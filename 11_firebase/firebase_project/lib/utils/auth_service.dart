import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<FirebaseUser> signUp(String email, String passwd) async {
    AuthResult result = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: passwd);
    return result.user;
  }

  Future<FirebaseUser> createUser(String email, String password) async {
    AuthResult result = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    FirebaseUser user = result.user;
    return user;
  }

  Future<FirebaseUser> getCurrentUser() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user;
  }

  Future<void> signOut() {
    return _firebaseAuth.signOut();
  }
}
