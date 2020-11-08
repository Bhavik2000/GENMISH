import 'package:FeedBack/models/persons.dart';
import 'package:FeedBack/otpForm.dart';
import 'package:flutter/material.dart';

class SecondScreen extends StatelessWidget {
  final Persons persons;
  SecondScreen({this.persons});
  final _scaffold = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffold,
      appBar: AppBar(
        title: Text("Second"),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OtpForm(
                  scaffold: _scaffold,
                  persons: persons,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
