import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../model/user_model.dart';

abstract class AuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  //create user from FirebaseUser
  static UserModel? _userFromFirebaseUser(User? user) {
    return user != null
        ? UserModel(
            uid: user.uid,
            name: user.displayName,
            email: user.email!,
            password: user.refreshToken!,
          )
        : null;
  }

  //auth change user stream
  static Stream<UserModel?> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  //sing in with email and password
  static Future<UserModel?> login(
    String password,
    String email,
  ) async {
    try {
      final result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  static User? get currentUser => _auth.currentUser;

  //register with email
  static Future<UserModel?> registration(
    String password,
    String email,
    String username,
  ) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await result.user!.updateDisplayName(username);
      result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (result.user == null) return null;
      User user = result.user!;
      return _userFromFirebaseUser(user);
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  //sign out
  static Future<void> signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  static void logOut() {
    AuthService.logOut();
  }

  static void deleteAccount() {
    AuthService.deleteAccount();
  }

// static Stream getAllUsers() {}
}
