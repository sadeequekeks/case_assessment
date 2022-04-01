import 'package:firebase_auth/firebase_auth.dart';

import '../service_injector/service_injector.dart';

class AssessmentService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  Future<String?> register({
    required String name,
    required String password,
    required String email,
  }) async {
    String? id;
    try {
      await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((UserCredential userCredentials) async {
        await si.firebaseService
            .addDoc(
          collection: 'users',
          data: {
            "name": name,
          },
          id: userCredentials.user!.uid,
        )
            .then((value) {
          if (value == true) {
            id = userCredentials.user!.uid;
          } else {
            id = '';
          }
        });
      });
    } catch (e) {
      id = '';
    }
    return id;
  }

  //sign in
  Future<dynamic> loginUser({
    required String email,
    required String password,
  }) async {
    dynamic user;
    try {
      await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((UserCredential userCredentials) async {
        await si.firebaseService
            .getOneDoc(collection: 'users', id: userCredentials.user!.uid)
            .then((value) {
          user = value!.data();
        });
      });
    } catch (e) {
      user = e.toString().split('] ')[1];
    }
    return user;
  }
}
