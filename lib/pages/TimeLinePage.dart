import 'package:flutter/material.dart';
import 'package:instagram_clone/widgets/HeaderWidget.dart';
import 'package:instagram_clone/widgets/ProgressWidget.dart';

class TimeLinePage extends StatefulWidget {
  TimeLinePage({Key key}) : super(key: key);

  @override
  _TimeLinePageState createState() => _TimeLinePageState();
}

class _TimeLinePageState extends State<TimeLinePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context, isAppTitle: true, strTitle: 'hi'),
      body: circularProgress(),
    );
  }
}
