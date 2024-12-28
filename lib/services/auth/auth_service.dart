import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  //instance of auth
 final FirebaseAuth _auth = FirebaseAuth.instance;
 final FirebaseFirestore _firestore = FirebaseFirestore.instance;

 //get current user
  User? getcurrentUser(){ return _auth.currentUser;}

  //sign in
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);   
      _firestore.collection('users').doc(userCredential.user!.uid).set({
        'Email': email,
        'uid': userCredential.user!.uid,
      });   
      return userCredential;
    } on FirebaseAuthException catch(e) {
      throw Exception(e.code);      
    }
  }

  //sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  //sign up
  Future signUpWithEmailAndPassword(String email, String password) async {
    try {
      //create user
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      //save user
      _firestore.collection('users').doc(userCredential.user!.uid).set({
        'Email': email,
        'uid': userCredential.user!.uid,
      });
      return userCredential;
    } on FirebaseAuthException catch(e) {
      throw Exception(e.code);
    }
  }

}