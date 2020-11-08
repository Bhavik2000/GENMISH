import 'package:FeedBack/fourth.dart';
import 'package:FeedBack/methods/statusmethod.dart';
import 'package:FeedBack/models/enums/user_state.dart';
import 'package:FeedBack/models/persons.dart';
import 'package:flutter/material.dart';
import 'models/enums/selectradiobuttonvalue.dart';

class ThirdScreen extends StatefulWidget {
  final Persons persons;
  ThirdScreen({this.persons});
  @override
  _ThirdScreenState createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> with WidgetsBindingObserver {
  SelectValue _character = SelectValue.mandatory;
  String currentUserId;

  final StatusMethod statusMethod = StatusMethod();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    currentUserId = widget.persons.uid;

    super.didChangeAppLifecycleState(state);

    switch (state) {
      case AppLifecycleState.resumed:
        currentUserId != null
            ? statusMethod.setUserState(
                uid: currentUserId, userState: UserState.Online)
            : print("resume state");
        break;
      case AppLifecycleState.inactive:
        currentUserId != null
            ? statusMethod.setUserState(
                uid: currentUserId, userState: UserState.Offline)
            : print("inactive state");
        break;
      case AppLifecycleState.paused:
        currentUserId != null
            ? statusMethod.setUserState(
                uid: currentUserId, userState: UserState.Waiting)
            : print("paused state");
        break;
      case AppLifecycleState.detached:
        currentUserId != null
            ? statusMethod.setUserState(
                uid: currentUserId, userState: UserState.Offline)
            : print("detached state");
        break;
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Third"),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            ListTile(
              title: const Text('Based on Mandatory'),
              leading: Radio(
                activeColor: Colors.amber,
                value: SelectValue.mandatory,
                groupValue: _character,
                onChanged: (SelectValue value) {
                  setState(() {
                    _character = value;
                  });
                },
              ),
            ),
            SizedBox(
              height: 5,
            ),
            ListTile(
              title: const Text('Random'),
              leading: Radio(
                activeColor: Colors.amber,
                value: SelectValue.random,
                groupValue: _character,
                onChanged: (SelectValue value) {
                  setState(() {
                    _character = value;
                  });
                },
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
                onPressed: () {
                  print(widget.persons.uid);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Fourth(
                                selectValue: _character,
                                persons: widget.persons,
                              )));
                },
                child: Text("SUBMIT", style: TextStyle(fontSize: 20)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
