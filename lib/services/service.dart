import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diary_webapp/model/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DiaryService {
  final CollectionReference userCollectionReference =
      FirebaseFirestore.instance.collection('users');

  Future<void> loginUser(String email, String password) async {
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    return;
  }

  Future<void> createUser(String displayName, String emailAddress,
      BuildContext context, String uid) async {
    MUser user = MUser(
        avatarUrl: 'https://picsum.photos/200/300',
        displayName: displayName,
        emailAddress: emailAddress,
        uid: uid);
    userCollectionReference.add(user.toMap());
    return;
  }

  Future<void> update(String avatarUrl, String displayName, String emailAddress,
      String profession, MUser user,  BuildContext context) async {
    MUser updateUser = MUser(
        avatarUrl: avatarUrl,
        displayName: displayName,
        emailAddress: emailAddress,
        profession: profession,
        uid: user.uid);

    userCollectionReference.doc(user.id).update(updateUser.toMap());
    return;
  }
}
