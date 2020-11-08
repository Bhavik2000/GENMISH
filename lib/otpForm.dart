import 'package:FeedBack/methods/statusmethod.dart';
import 'package:FeedBack/models/enums/user_state.dart';
import 'package:FeedBack/models/persons.dart';
import 'package:FeedBack/third.dart';
import 'package:FeedBack/utility/utilities.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OtpForm extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffold;
  final Persons persons;
  final DocumentReference documentReference =
      FirebaseFirestore.instance.collection("users").doc();
  OtpForm({
    this.scaffold,
    this.persons,
    Key key,
  }) : super(key: key);

  @override
  _OtpFormState createState() => _OtpFormState();
}

class _OtpFormState extends State<OtpForm> {
  var _formKey = GlobalKey<FormState>();

  String dropdownValue;
  FocusNode pin2FocusNode;
  FocusNode pin3FocusNode;
  FocusNode pin4FocusNode;
  String a, b, c, d;
  bool _isupload = false;
  bool _isExist = false;
  String uid;
  Persons getpersons = Persons();

  @override
  void initState() {
    super.initState();
    pin2FocusNode = FocusNode();
    pin3FocusNode = FocusNode();
    pin4FocusNode = FocusNode();
    authenticateUser().then((value) {
      setState(() {
        _isExist = value;
      });
    });
  }

  Future<bool> authenticateUser() async {
    QuerySnapshot result = await FirebaseFirestore.instance
        .collection("users")
        .where('email', isEqualTo: widget.persons.email)
        .get();
    final List<DocumentSnapshot> docs = result.docs;

    setState(() {
      getpersons = Persons.fromMap(docs[0].data());
    });

    //if user is registered then length of list > 0 or else less than 0
    return docs.length == 0 ? false : true;
  }

  @override
  void dispose() {
    super.dispose();
    pin2FocusNode.dispose();
    pin3FocusNode.dispose();
    pin4FocusNode.dispose();
  }

  void nextField(String value, FocusNode focusNode) {
    if (value.length == 1) {
      focusNode.requestFocus();
    }
  }

  Future<void> isupload() async {
    Persons user = Persons(
        country: widget.persons.country,
        email: widget.persons.email,
        otp: widget.persons.otp,
        uid: widget.documentReference.id,
        name: widget.persons.name);
    await widget.documentReference.set(user.toMap(user));
    widget.persons.uid = widget.documentReference.id;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Container(
            height: 50,
            width: 300,
            padding: EdgeInsets.only(left: 15, top: 5, right: 15, bottom: 5),
            // decoration: BoxDecoration(border: Border.all(width: 1)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 30,
                  child: TextFormField(
                    autofocus: true,
                    obscureText: true,
                    style: TextStyle(fontSize: 24),
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 5.5,
                      ),
                      border: OutlineInputBorder(
                        // borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      focusedBorder: OutlineInputBorder(
                        // borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      enabledBorder: OutlineInputBorder(
                        // borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                    onChanged: (value) {
                      a = value;
                      nextField(value, pin2FocusNode);
                    },
                  ),
                ),
                SizedBox(
                  width: 30,
                  child: TextFormField(
                    focusNode: pin2FocusNode,
                    obscureText: true,
                    style: TextStyle(fontSize: 24),
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 5.5),
                      border: OutlineInputBorder(
                        // borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      focusedBorder: OutlineInputBorder(
                        // borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      enabledBorder: OutlineInputBorder(
                        // borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                    onChanged: (value) {
                      b = value;
                      nextField(value, pin3FocusNode);
                    },
                  ),
                ),
                SizedBox(
                  width: 30,
                  child: TextFormField(
                    focusNode: pin3FocusNode,
                    obscureText: true,
                    style: TextStyle(fontSize: 24),
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 5.5),
                      border: OutlineInputBorder(
                        // borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      focusedBorder: OutlineInputBorder(
                        // borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      enabledBorder: OutlineInputBorder(
                        // borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                    onChanged: (value) {
                      c = value;
                      nextField(value, pin4FocusNode);
                    },
                  ),
                ),
                SizedBox(
                  width: 30,
                  child: TextFormField(
                    focusNode: pin4FocusNode,
                    obscureText: true,
                    style: TextStyle(fontSize: 24),
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 5.5,
                      ),
                      border: OutlineInputBorder(
                        // borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      focusedBorder: OutlineInputBorder(
                        // borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      enabledBorder: OutlineInputBorder(
                        // borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                    onChanged: (value) {
                      d = value;
                      if (value.length == 1) {
                        pin4FocusNode.unfocus();
                        // Then you need to check is the code is correct or not
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            padding: EdgeInsets.all(3),
            width: 300,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              border: Border.all(
                width: 1,
                color: Colors.black,
              ),
            ),
            child: DropdownButton<String>(
              value: dropdownValue,
              isExpanded: true,
              hint: Text(
                "Services",
                style: TextStyle(fontSize: 18),
              ),
              iconSize: 30,
              elevation: 16,
              style: TextStyle(color: Colors.blueGrey),
              underline: const SizedBox(),
              onChanged: (String newValue) {
                setState(() {
                  dropdownValue = newValue;
                });
              },
              items: <String>['One', 'Two', 'Free', 'Four']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: TextStyle(fontSize: 18),
                  ),
                );
              }).toList(),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          SizedBox(
            height: 50,
            width: 300,
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50)),
              elevation: 5,
              color: Colors.amber,
              onPressed: () async {
                if (a == null || b == null || c == null || d == null) {
                  widget.scaffold.currentState.hideCurrentSnackBar();
                  widget.scaffold.currentState.showSnackBar(SnackBar(
                      duration: Duration(milliseconds: 800),
                      content: Text("Please enter OTP ...")));
                  return;
                } else if (dropdownValue == null) {
                  widget.scaffold.currentState.hideCurrentSnackBar();
                  widget.scaffold.currentState.showSnackBar(SnackBar(
                      duration: Duration(milliseconds: 800),
                      content: Text("Please Select One service ... ")));
                  return;
                }

                print("...................................................");
                print(a + b + c + d);
                print(widget.persons.otp);
                print(widget.persons.name);
                if ((a + b + c + d) != widget.persons.otp) {
                  widget.scaffold.currentState.hideCurrentSnackBar();
                  widget.scaffold.currentState.showSnackBar(SnackBar(
                      duration: Duration(milliseconds: 800),
                      content: Text("Please enter Valid OTP ...")));
                  return;
                }
                setState(() {
                  _isupload = !_isupload;
                });
                if (_isExist) {
                  await FirebaseFirestore.instance
                      .collection("users")
                      .doc(getpersons.uid)
                      .update({'otp': widget.persons.otp});

                  widget.persons.uid = getpersons.uid;
                } else {
                  await isupload();
                }
                setState(() {
                  _isupload = !_isupload;
                });
                print(widget.persons.name);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ThirdScreen(
                              persons: widget.persons,
                            )));
              },
              child: _isupload
                  ? CircularProgressIndicator()
                  : Text("SUBMIT", style: TextStyle(fontSize: 20)),
            ),
          ),
        ],
      ),
    );
  }
}
