import 'dart:ui';
import 'package:FeedBack/callscreens/pickup/pickup_layout.dart';
import 'package:FeedBack/methods/chat_methods.dart';
import 'package:FeedBack/models/Person.dart';
import 'package:FeedBack/models/enums/selectradiobuttonvalue.dart';
import 'package:FeedBack/models/persons.dart';
import 'package:FeedBack/widgets/Listtile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Fourth extends StatefulWidget {
  final SelectValue selectValue;
  final Persons persons;
  Fourth({this.selectValue, this.persons});
  @override
  _FourthState createState() => _FourthState();
}

class _FourthState extends State<Fourth> {
  final List<Person> person = List<Person>();
  final ChatMethods chatMethods = ChatMethods();
  final CollectionReference _userCollection =
      FirebaseFirestore.instance.collection('users');

  List<DocumentSnapshot> getusers;
  int numberofUser;

  bool _loading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(numberofUser);
    getUsers();
  }

  Future<List<DocumentSnapshot>> getUsers() async {
    if (widget.selectValue == SelectValue.mandatory) {
      QuerySnapshot querySnapshot = await _userCollection
          .where(
            'country',
            isEqualTo: widget.persons.country,
          )
          .get();
      getusers = querySnapshot.docs;
      for (int i = 0; i < getusers.length; i++) {
        if (Persons.fromMap(getusers[i].data()).uid == widget.persons.uid) {
          getusers.removeAt(i);
          numberofUser = getusers.length;
        } else {
          numberofUser = getusers.length;
        }
      }
      print(getusers.length);
      setState(() {
        _loading = true;
      });
      return getusers;
    }
    if (widget.selectValue == SelectValue.random) {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection("users").get();

      getusers = querySnapshot.docs;
      for (int i = 0; i < getusers.length; i++) {
        if (Persons.fromMap(getusers[i].data()).uid == widget.persons.uid) {
          getusers.removeAt(i);
          print(getusers.length);
          numberofUser = getusers.length;
        }
      }
      setState(() {
        _loading = true;
      });
      return getusers;
    }
  }

  @override
  Widget build(BuildContext context) {
    return PickupLayout(
      currentUser: widget.persons,
      scaffold: Scaffold(
        appBar: AppBar(
          title: Text("Fourth"),
          centerTitle: true,
        ),
        body: numberofUser != null
            ? _loading == false
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Container(
                    padding: EdgeInsets.all(5),
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.all(5),
                          child: CustomTile(
                            sender: widget.persons,
                            receiver: Persons.fromMap(getusers[index].data()),
                          ),
                        );
                      },
                      itemCount: numberofUser,
                    ),
                  )
            : Center(
                child: Text(
                  "No Result Found",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
      ),
    );
  }
}
