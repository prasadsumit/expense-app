import 'package:firebase_auth/firebase_auth.dart';
import 'package:rupiya/models/database_service.dart';
import 'package:rupiya/other/date_time.dart';


class AuthenticationService{
  final FirebaseAuth _firebaseAuth;

  AuthenticationService(this._firebaseAuth);

  Stream<User> get authStateChanges => _firebaseAuth.idTokenChanges();

  Future<void> signOut() async{
    await _firebaseAuth.signOut();
  }

  Future<String> signIn({String email, String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      return "Signed In";

    } on FirebaseAuthException catch (e) {
      print(e);
      return e.code;
    }
    
  }
  Future<String> signUp({String email, String password}) async {
    try {
      Date today = Date(date: DateTime.now());
      today.getDate();
      var result = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      await DatabaseService(uid: result.user.uid).initializeUserData(today.year);
      return "Signed Up";

    } on FirebaseAuthException catch (e) {
      print(e);
      return e.code;
    }
  }

}