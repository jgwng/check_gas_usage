import 'dart:async';
import 'package:checkgasusage/constants/firestore_path.dart';
import 'package:checkgasusage/models/user.dart';
import 'package:checkgasusage/providers/firebase_auth_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/all.dart';

//Firebase CloudStore CRUD 하는 곳
class FirestoreRepository {
  final Reader read;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  String get uid => read(firebaseAuthProvider).currentUser.uid;
  FirestoreRepository({this.read});

  Future<bool> getUserState() async {
    DocumentReference userRef = firestore.doc(FirestorePath.user(uid));
    DocumentSnapshot userSnapshot = await userRef.get();
    if (userSnapshot.data() == null) return false;
    return userSnapshot.data()['userState'];
  }

  Future<User> fetchUserData() async {
    DocumentReference userRef = firestore.doc(FirestorePath.user(uid));
    DocumentSnapshot userSnapshot = await userRef.get();
    User user = User.fromJson(userSnapshot.data(), userSnapshot.id);
    return user;
  }

  updateUser(Map<String, dynamic> updateData, {String userKey}) async {
    DocumentReference userRef = firestore.doc(FirestorePath.user(userKey == null? uid : userKey));
    await userRef.update(updateData);
  }


  Future<void> setUserData(User user) async {
    Map<String, dynamic> userInfo = user.toJson();
    await firestore.collection('user').doc(uid).set(userInfo);
  }

  }
