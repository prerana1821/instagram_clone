import 'package:flutter/material.dart';
import 'package:instagram_clone/widgets/HeaderWidget.dart';

class NotificationsPage extends StatefulWidget {

  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context,strTitle:'Notifications'),
    );
  }
}

class NotificationsItem extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('Activity Feed Item goes here'),
    );
  }
}