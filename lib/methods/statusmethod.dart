import 'package:FeedBack/models/enums/user_state.dart';
import 'package:FeedBack/utility/utilities.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class StatusMethod {
  final CollectionReference _userCollection =
      FirebaseFirestore.instance.collection('users');
  void setUserState({@required String uid, @required UserState userState}) {
    int stateNum = Utils.stateToNum(userState);
    _userCollection.document(uid).updateData({
      "status": stateNum,
    });
  }
}
