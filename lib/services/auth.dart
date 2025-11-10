import 'package:firebase_auth/firebase_auth.dart';

class AthServices {
  ///SignUp
  Future<User> registerUser({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return userCredential.user!;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  ///Login
  Future<User> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return userCredential.user!;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  ///Forgot Password
  Future forgotPassword(String email) async {
    return await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }
}
