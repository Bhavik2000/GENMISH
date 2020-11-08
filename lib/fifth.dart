import 'dart:ui';
import 'package:FeedBack/models/persons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Fifth extends StatefulWidget {
  final Persons receiver;
  Fifth({this.receiver});
  @override
  _FifthState createState() => _FifthState();
}

class _FifthState extends State<Fifth> {
  var _scaffold = GlobalKey<ScaffoldState>();
  String description;
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffold,
      appBar: AppBar(
        title: Text("Fifth"),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Write your concern for blocking ...",
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding: EdgeInsets.all(5),
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(border: Border.all(width: 1)),
                  child: TextFormField(
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.done,
                    textCapitalization: TextCapitalization.sentences,
                    maxLines: 7,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Description ...",
                        hintStyle: TextStyle(fontSize: 18)),
                    style: TextStyle(fontSize: 18),
                    onChanged: (value) {
                      setState(() {
                        description = value;
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 50,
                      width: 300,
                      child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)),
                          elevation: 5,
                          color: Colors.amber,
                          onPressed: () async {
                            if (description == null) {
                              _scaffold.currentState.hideCurrentSnackBar();
                              _scaffold.currentState.showSnackBar(
                                SnackBar(
                                  content:
                                      Text("Please enter your description ..."),
                                  duration: Duration(
                                    milliseconds: 800,
                                  ),
                                ),
                              );
                              return;
                            }
                            setState(() {
                              loading = true;
                            });
                            await FirebaseFirestore.instance
                                .collection("users")
                                .doc(widget.receiver.uid)
                                .update({'reason': description});
                            setState(() {
                              loading = false;
                            });
                            Navigator.pop(context);
                          },
                          child: loading
                              ? CircularProgressIndicator()
                              : Text("SUBMIT", style: TextStyle(fontSize: 20))),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
