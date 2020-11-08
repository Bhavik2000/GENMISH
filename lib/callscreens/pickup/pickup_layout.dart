import 'package:FeedBack/audiocall/receiver_audio_call.dart';
import 'package:FeedBack/callscreens/pickup/pickup_screen.dart';
import 'package:FeedBack/methods/audio_methods.dart';
import 'package:FeedBack/methods/call_methods.dart';
import 'package:FeedBack/models/call.dart';
import 'package:FeedBack/models/persons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PickupLayout extends StatelessWidget {
  final Widget scaffold;
  final Persons currentUser;

  PickupLayout({@required this.scaffold, @required this.currentUser});

  final CallMethods callMethods = CallMethods();

  final AudioMethods audioMethods = AudioMethods();

  @override
  Widget build(BuildContext context) {
    return (currentUser != null)
        ? StreamBuilder<DocumentSnapshot>(
            stream: callMethods.callStream(uid: currentUser.uid),
            builder: (context, snapshot1) {
              return StreamBuilder<DocumentSnapshot>(
                stream: audioMethods.audiocallStream(uid: currentUser.uid),
                builder: (context, snapshot2) {
                  if (snapshot1.hasData && snapshot1.data.data() != null) {
                    Call call = Call.fromMap(snapshot1.data.data());
                    if (!call.hasDialled) {
                      return PickupScreen(call: call);
                    }
                  } else if (snapshot2.hasData &&
                      snapshot2.data.data() != null) {
                    Call call = Call.fromMap(snapshot2.data.data());
                    if (!call.hasDialled) {
                      return AudioCallPickup(call: call);
                    }
                  }
                  return scaffold;
                },
              );
            },
          )
        : Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
  }
}
