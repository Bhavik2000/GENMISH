import 'dart:math';
import 'package:FeedBack/callscreens/call_screen.dart';
import 'package:FeedBack/methods/call_methods.dart';
import 'package:FeedBack/models/call.dart';
import 'package:FeedBack/models/persons.dart';
import 'package:flutter/material.dart';

class CallUtils {
  static final CallMethods callMethods = CallMethods();

  static dial({Persons from, Persons to, context}) async {
    print(from.uid);
    print(to.uid);
    Call call = Call(
      callerId: from.uid,
      callerName: from.name,
      receiverId: to.uid,
      receiverName: to.name,
      channelId: Random().nextInt(1000).toString(),
    );

    // Log log = Log(
    //   callerName: from.name,
    //   callerPic: from.profilePhoto,
    //   callStatus: CALL_STATUS_DIALLED,
    //   receiverName: to.name,
    //   receiverPic: to.profilePhoto,
    //   timestamp: DateTime.now().toString(),
    // );

    bool callMade = await callMethods.makeCall(call: call);

    call.hasDialled = true;

    if (callMade) {
      // enter log
      // LogRepository.addLogs(log);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CallScreen(call: call),
        ),
      );
    }
  }
}
