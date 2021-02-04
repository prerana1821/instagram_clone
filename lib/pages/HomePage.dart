import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_clone/models/user.dart' as iUser;
import 'package:instagram_clone/pages/CreateAccountPage.dart';
import 'package:instagram_clone/pages/NotificationsPage.dart';
import 'package:instagram_clone/pages/ProfilePage.dart';
import 'package:instagram_clone/pages/SearchPage.dart';
import 'package:instagram_clone/pages/TimeLinePage.dart';
import 'package:instagram_clone/pages/UploadPage.dart';

final GoogleSignIn gSignIn = GoogleSignIn();
final usersReference = FirebaseFirestore.instance.collection("users");
final DateTime timestamp = DateTime.now();
iUser.User currentUser =  iUser.User();

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isSignedIn = false;
  int getPageIndex = 0;
  PageController pageController = PageController();

  Scaffold buildHomeScreen() {
    return Scaffold(
      body: PageView(
        children: [
          // TimeLinePage
          RaisedButton.icon(
            onPressed: logoutUser,
            icon: Icon(Icons.close),
            label: Text('Sign Out'),
          ),
          SearchPage(),
          UploadPage(),
          NotificationsPage(),
          ProfilePage(),
        ],
        controller: pageController,
        onPageChanged: whenPageChanges,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: CupertinoTabBar(
        currentIndex: getPageIndex,
        onTap: onTagChangePage,
        activeColor: Colors.white,
        inactiveColor: Colors.blueGrey,
        backgroundColor: Theme.of(context).accentColor,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home)),
          BottomNavigationBarItem(icon: Icon(Icons.search)),
          BottomNavigationBarItem(
              icon: Icon(
            Icons.photo_camera,
            size: 37.0,
          )),
          BottomNavigationBarItem(icon: Icon(Icons.favorite)),
          BottomNavigationBarItem(icon: Icon(Icons.person)),
        ],
      ),
    );
    // RaisedButton.icon(
    //   onPressed: logoutUser,
    //   icon: Icon(Icons.close),
    //   label: Text('Sign Out'),
    // );
  }

  onTagChangePage(int pageIndex) {
    pageController.animateToPage(pageIndex,
        duration: Duration(milliseconds: 400), curve: Curves.bounceInOut);
  }

  whenPageChanges(int pageIndex) {
    setState(() {
      this.getPageIndex = pageIndex;
    });
  }

  @override
  void initState() {
    super.initState();
    pageController = PageController();
    gSignIn.onCurrentUserChanged.listen((gSigninAccount) {
      controlSignIn(gSigninAccount);
    }, onError: ( Object gError) {
      print("Error Message: " + gError.toString());
    });

    gSignIn.signInSilently(suppressErrors: true).then((gSignInAccount) {
      controlSignIn(gSignInAccount);
    }).catchError(( Object gError) {
      print("Error Message: " + gError.toString());
    });
  }

  controlSignIn(GoogleSignInAccount signInAccount) async {
    if (signInAccount != null) {
      await saveUserInfoToFirestore();
      setState(() {
        isSignedIn = true;
      });
    } else {
      setState(() {
        isSignedIn = false;
      });
    }
  }

  saveUserInfoToFirestore() async {
    final GoogleSignInAccount gCurrentUser = gSignIn.currentUser;
    DocumentSnapshot documentSnapshot =
        await usersReference.doc(gCurrentUser.id).get();

    if (!documentSnapshot.exists) {
      final username = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CreateAccountPage(),
        ),
      );
      usersReference.doc(gCurrentUser.id).set({
        "id": gCurrentUser.id,
        "profileName": gCurrentUser.displayName,
        "username": username,
        "url": gCurrentUser.photoUrl,
        "email": gCurrentUser.email,
        "bio": "",
        "timestamp": timestamp,
      });
      documentSnapshot = await usersReference.doc(gCurrentUser.id).get();
      print('Hello');
      // print(documentSnapshot.data());
    }
    currentUser = iUser.User.fromDocument(documentSnapshot);
  }

  loginUser() {
    gSignIn.signIn();
  }

  logoutUser() {
    gSignIn.signOut();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  Scaffold buildSigninScreen() {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Theme.of(context).accentColor,
              Theme.of(context).primaryColor
            ],
          ),
        ),
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'preCodes',
              style: TextStyle(
                  color: Colors.white, fontSize: 60.0, fontFamily: 'Signatra'),
            ),
            GestureDetector(
              onTap: loginUser,
              child: Container(
                width: 300.0,
                height: 65.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/google_signin_button.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // Image.asset('assets/images/google_signin_button.png'),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isSignedIn) {
      return buildHomeScreen();
    } else {
      return buildSigninScreen();
    }
  }
}
