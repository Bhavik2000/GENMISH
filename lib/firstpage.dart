import 'dart:math';
import 'dart:ui';
import 'package:FeedBack/models/Person.dart';
import 'package:FeedBack/second.dart';
import 'package:FeedBack/utility/utilities.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import './CountryList.dart';
import 'package:http/http.dart' as http;

import 'models/persons.dart';

class FirstScreen extends StatefulWidget {
  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  var _formKey = GlobalKey<FormState>();
  var _scaffold = GlobalKey<ScaffoldState>();
  String _email;
  String _country;
  String otp;
  String _name;
  CountryList countyList = CountryList();
  bool _issend = false;
  Persons persons = Persons();

  bool validation() {
    if (_email == null) {
      _scaffold.currentState.hideCurrentSnackBar();
      _scaffold.currentState.showSnackBar(SnackBar(
          duration: Duration(milliseconds: 800),
          content: Text("Please enter email ...")));
      return false;
    } else if (_country == null) {
      _scaffold.currentState.hideCurrentSnackBar();
      _scaffold.currentState.showSnackBar(SnackBar(
          duration: Duration(milliseconds: 800),
          content: Text("Please choose county ...")));
      return false;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffold,
      appBar: AppBar(
        title: Text("First"),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 5),
                    width: 300,
                    height: 40,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: Colors.black,
                      ),
                    ),
                    child: TextFormField(
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: 18,
                      ),
                      key: ValueKey('email'),
                      autocorrect: false,
                      textCapitalization: TextCapitalization.none,
                      enableSuggestions: true,
                      decoration: InputDecoration(
                        enabledBorder: InputBorder.none,
                        hintText: "Email ",
                        border: InputBorder.none,
                      ),
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (value) {
                        setState(() {
                          _email = value;
                        });
                      },
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).unfocus();
                      },
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
                      value: _country,
                      isExpanded: true,
                      hint: Text(
                        "Country",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      iconSize: 30,
                      elevation: 16,
                      style: TextStyle(color: Colors.black),
                      underline: const SizedBox(),
                      onChanged: (String newValue) {
                        setState(() {
                          _country = newValue;
                        });
                      },
                      items: countyList.listofcountry
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
                        if (validation()) {
                          setState(() {
                            _issend = !_issend;
                          });
                          var res = await http.get(
                              'https://us-central1-feedback-e7a03.cloudfunctions.net/sendMail?dest=${_email}');

                          print(
                              "=====================================================");
                          print(res.body);
                          otp = res.body;
                          setState(() {
                            _issend = !_issend;
                          });
                          persons.email = _email;
                          persons.name = _email.substring(0, 6);
                          persons.otp = otp;
                          persons.country = _country;
                          Fluttertoast.showToast(
                            msg: "Send reset link your register email...",
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                          );
                          // print(rng.nextInt(9999));
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      SecondScreen(persons: persons)));
                        } else {
                          return;
                        }
                      },
                      child: _issend
                          ? CircularProgressIndicator()
                          : Text("SEND OTP", style: TextStyle(fontSize: 20)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
