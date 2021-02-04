import 'dart:async';

import 'package:flutter/material.dart';
import 'package:instagram_clone/widgets/HeaderWidget.dart';

class CreateAccountPage extends StatefulWidget {
  CreateAccountPage({Key key}) : super(key: key);

  @override
  _CreateAccountPageState createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  String username = '';
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  submitUsername() {
    final form = _formKey.currentState;
    if (form != null) {
      if (form.validate()) {
        form.save();

        
         _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('Welcome' + username)));
        //ScaffoldMessenger.of(context).showSnackBar(snackBar);
        Timer(Duration(seconds: 4), () {
          Navigator.pop(context, username);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: header(
        context,
        strTitle: 'Settings',
        disappearedBackButton: true,
      ),
      body: ListView(
        children: [
          Container(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 26.0),
                  child: Center(
                    child: Text(
                      'Setup a Username',
                      style: TextStyle(fontSize: 26.0),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(17.0),
                  child: Container(
                    child: Form(
                      key: _formKey,
                      autovalidateMode: AutovalidateMode.always,
                      child: TextFormField(
                        style: TextStyle(color: Colors.white),
                        validator: (val) {
                          if(val != null){
                          if (val.trim().length < 5 || val.isEmpty) {
                            return 'User Name is very Short.';
                          } else if (val.trim().length > 15) {
                            return 'User Name is very Short.';
                          } else {
                            return null;
                          }
                        }},
                        onSaved: (val) => username = val,
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          border: OutlineInputBorder(),
                          labelText: 'Username',
                          labelStyle: TextStyle(fontSize: 16.0),
                          hintText: 'Must be atlest 5 Characters',
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: submitUsername,
                  child: Container(
                    height: 55.0,
                    width: 360.0,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Center(
                      child: Text(
                        "Proceed",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
