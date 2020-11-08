import 'package:FeedBack/audiocall/pickup_audio_call.dart';
import 'package:FeedBack/callscreens/call_screen.dart';
import 'package:FeedBack/methods/audio_methods.dart';
import 'package:FeedBack/methods/call_methods.dart';
import 'package:FeedBack/models/call.dart';
import 'package:FeedBack/utility/permissions.dart';
import 'package:flutter/material.dart';

class AudioCallPickup extends StatefulWidget {
  final Call call;
  AudioCallPickup({@required this.call});
  @override
  _AudioCallPickupState createState() => _AudioCallPickupState();
}

class _AudioCallPickupState extends State<AudioCallPickup> {
  final AudioMethods audioMethods = AudioMethods();

  bool isCallMissed = true;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 100),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Incoming...",
              style: TextStyle(
                fontSize: 30,
              ),
            ),
            SizedBox(height: 50),
            // CachedImage(
            //   widget.call.callerPic,
            //   isRound: true,
            //   radius: 180,
            // ),
            SizedBox(height: 15),
            Text(
              widget.call.callerName,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            SizedBox(height: 75),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.call_end),
                  color: Colors.redAccent,
                  onPressed: () async {
                    isCallMissed = false;
                    // addToLocalStorage(callStatus: CALL_STATUS_RECEIVED);
                    await audioMethods.endCall(call: widget.call);
                  },
                ),
                SizedBox(width: 25),
                IconButton(
                    icon: Icon(Icons.call),
                    color: Colors.green,
                    onPressed: () async {
                      isCallMissed = false;
                      // addToLocalStorage(callStatus: CALL_STATUS_RECEIVED);
                      await Permissions.cameraAndMicrophonePermissionsGranted()
                          ? Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    PickupAudio(call: widget.call),
                              ),
                            )
                          : {};
                    }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
