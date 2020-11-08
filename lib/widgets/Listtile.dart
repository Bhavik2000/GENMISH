import 'package:FeedBack/chatscreen/chatscreen.dart';
import 'package:FeedBack/models/persons.dart';
import 'package:FeedBack/utility/audio_utilities.dart';
import 'package:FeedBack/utility/call_utilities.dart';
import 'package:FeedBack/utility/permissions.dart';
import 'package:flutter/material.dart';
import '../fifth.dart';

class CustomTile extends StatefulWidget {
  final Persons sender;
  final Persons receiver;
  CustomTile({this.sender, this.receiver});
  @override
  _CustomTileState createState() => _CustomTileState();
}

class _CustomTileState extends State<CustomTile> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Container(
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
            border: Border.all(width: 1), color: Colors.amber[200]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            (widget.receiver.status == 0 || widget.receiver.status == 2)
                ? Text(
                    "OFFILE",
                    style: TextStyle(
                      color: Colors.redAccent,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                : Text(
                    "ONLINE",
                    style: TextStyle(
                      color: Colors.lightGreen,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
            SizedBox(
              height: 5,
            ),
            Container(
              height: 60,
              decoration: BoxDecoration(
                  border: Border.all(width: 1), color: Colors.grey[200]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    widget.receiver.name.toUpperCase(),
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  CircleAvatar(
                    child: InkWell(
                      onTap: () async {
                        try {
                          print(
                              "Sure sender and recever both are available or not?????/....");
                          await Permissions
                                  .cameraAndMicrophonePermissionsGranted()
                              ? AudioUtils.dial(
                                  from: widget.sender,
                                  to: widget.receiver,
                                  context: context,
                                )
                              : Container();
                        } catch (e) {
                          print(e);
                        }
                      },
                      child: Text(
                        "A",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                  CircleAvatar(
                    child: InkWell(
                      onTap: () async {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ChatScreen(
                                  sender: widget.sender,
                                  receiver: widget.receiver,
                                )));
                      },
                      child: Text(
                        "C",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                  CircleAvatar(
                    child: InkWell(
                      onTap: () async {
                        try {
                          await Permissions
                                  .cameraAndMicrophonePermissionsGranted()
                              ? CallUtils.dial(
                                  from: widget.sender,
                                  to: widget.receiver,
                                  context: context,
                                )
                              : Container();
                        } catch (e) {
                          print(e);
                        }
                      },
                      child: Text(
                        "V",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                  CircleAvatar(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Fifth(
                                      receiver: widget.receiver,
                                    )));
                      },
                      child: Text(
                        "B",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
