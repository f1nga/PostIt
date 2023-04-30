import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypt/crypt.dart';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:crypto/crypto.dart';
import 'package:uuid/uuid.dart';

import '../../helpers/get.dart';
import '../models/user.dart';

const String userStore = "user_store";
const String emailConstant = "email";
const String token = "token";
const String passwordConstant = "password";

/// Class that contains the provider methods logic
class AuthenticationProvider {
  Future<QuerySnapshot<Map<String, dynamic>>> findUserWithEmailInDatabase(
      String? email) {
    // Search the user in the database that matches the email entered
    return FirebaseFirestore.instance
        .collection(userStore)
        .where(
          emailConstant,
          isEqualTo: email,
        )
        .limit(1)
        .get();
  }

  /// A function sign in a user if the wallet id match with any other in database.
  /// @param {String} The user wallet id.
  /// @returns {User?} The user that can be null.
  Future<User?> login(String email, String password) async {
    try {
      /// Find user in database by email
      final QuerySnapshot<Map<String, dynamic>> record =
          await findUserWithEmailInDatabase(email);
      if (record.docs.isEmpty) return null;

      print("$email, $password");

      /// Encrypt the user password
      User user = User.fromMap(record.docs.first.data());
      final Crypt hInfo = Crypt(user.password!);
      user.password = "";

      if (hInfo.match(password)) {
        /// Save the token and email into the shared preferences
        final SharedPreferences prefs = await SharedPreferences.getInstance();

        prefs.setString(token, generateToken().toString());

        prefs.setString(emailConstant, email);

        await myUser();
        return user;
      }
      return null;
    } catch (exception) {
      if (kDebugMode) {
        print(exception);
      }
      return null;
    }
  }

  /// Register function that add a user in database if it doesn't exists.
  /// @param {User} The user data.
  /// @returns {boolean} Returns true if everything go ok, return false if the user already exist.
  Future<bool> register(String nickname, String email, String password) async {
    try {
      /// Find user in database by email
      final QuerySnapshot<Map<String, dynamic>> record =
          await findUserWithEmailInDatabase(email);
      if (record.docs.isNotEmpty) return false;

      /// Encrypt the user password
      final Crypt cryptHash = Crypt.sha256(password);

      ///Creates the new user
      final User newUser = User(
        nickname: nickname,
        email: email,
        password: cryptHash.toString(),
      );

      /// Insert the user into firebase user collection
      await FirebaseFirestore.instance.collection(userStore).add(
            newUser.toMap(),
          );
      return true;
    } catch (exception) {
      if (kDebugMode) {
        print(exception);
      }
      return false;
    }
  }

  /// Method that generates sha-256 token to save user in the shared preferences
  /// @returns {Future<Digest>} Returns the token
  Future<Digest> generateToken() async {
    Uuid uuid = const Uuid();
    List<int> bytes1 = utf8.encode(uuid.v1());

    return sha256.convert(bytes1);
  }

  /// Method that checks if the user have a token in the shared preference
  /// @returns {Future<bool>} Returns true if the user have token, if not, returns false
  Future<bool> tokenExists() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userToken = prefs.getString(token);

    return userToken != null ? true : false;
  }

  /// Method that inject the current user in the dependencies
  Future<void> myUser() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String? email = prefs.getString(emailConstant);

      /// Find user in the database by email
      final QuerySnapshot<Map<String, dynamic>> record =
          await findUserWithEmailInDatabase(email);

      if (record.docs.isNotEmpty) {
        /// Inject the user
        User user = User.fromMap(record.docs.first.data());
        user.password = "";
        Get.i.put<User>(user);
      }
    } catch (exception) {
      if (kDebugMode) {
        print(exception);
      }
    }
  }
}
