import 'package:flutter/material.dart';

AppBar header(context,
    {bool isAppTitle = false,  String strTitle, disappearedBackButton = false}) {
  return AppBar(
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
    backgroundColor: Theme.of(context).accentColor,
    automaticallyImplyLeading: disappearedBackButton ? false : true,
    title: Text(
      isAppTitle ? 'preCodes' : strTitle,
      style: TextStyle(
        fontFamily: isAppTitle ? 'Signatra' : '',
        fontSize: isAppTitle ? 45.0 : 22.0,
        color: Colors.white,
      ),
      overflow: TextOverflow.ellipsis,
    ),
    centerTitle: true,
  );
}
