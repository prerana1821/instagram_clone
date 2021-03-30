import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_clone/pages/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/models/user.dart' as iUser;
import 'package:instagram_clone/widgets/ProgressWidget.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage>
    with AutomaticKeepAliveClientMixin<SearchPage> {
  TextEditingController searchTextEditingController = TextEditingController();
  Future<QuerySnapshot> futureSearchResults;

  emptyTextFormField() {
    searchTextEditingController.clear();
  }

  controllSearching(String str) {
    Future<QuerySnapshot> allUsers =
        usersReference.where('profileName', isGreaterThanOrEqualTo: str).get();

    setState(() {
      futureSearchResults = allUsers;
    });
  }

  AppBar searchPageHeader() {
    return AppBar(
      backgroundColor: Colors.black,
      title: TextFormField(
        style: TextStyle(
          fontSize: 18.0,
          color: Colors.white,
        ),
        controller: searchTextEditingController,
        decoration: InputDecoration(
          hintText: 'Search here...',
          hintStyle: TextStyle(color: Colors.grey),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          filled: true,
          prefixIcon: Icon(
            Icons.person_pin,
            color: Colors.white,
            size: 30.0,
          ),
          suffixIcon: IconButton(
            icon: Icon(Icons.clear),
            onPressed: emptyTextFormField,
          ),
        ),
        onFieldSubmitted: controllSearching,
      ),
    );
  }

  Widget displayNoSearchResultScreen() {
    final Orientation orientation = MediaQuery.of(context).orientation;
    return Container(
      child: Center(
        child: ListView(
          shrinkWrap: true,
          children: [
            Icon(
              Icons.group,
              color: Colors.grey,
              size: 200.0,
            ),
            Text(
              'Search Users',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 65.0,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget displayUsersFoundScreen() {
    return FutureBuilder(
      future: futureSearchResults,
      builder: (context, dataSnapshot) {
        if (!dataSnapshot.hasData) {
          return circularProgress();
        }

        List<UserResult> searchUsersResult = [];
        dataSnapshot.data.docs.forEach((document) {
          iUser.User eachUser = iUser.User.fromDocument(document);
          UserResult userResult = UserResult(eachUser);
          searchUsersResult.add(userResult);
        });
        return ListView(
          children: searchUsersResult,
        );
      },
    );
  }

  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: searchPageHeader(),
      body: futureSearchResults == null
          ? displayNoSearchResultScreen()
          : displayUsersFoundScreen(),
    );
  }
}

class UserResult extends StatelessWidget {
  final iUser.User eachUser;
  UserResult(this.eachUser);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(3.0),
      child: Container(
        color: Colors.white54,
        child: Column(
          children: [
            GestureDetector(
              onTap: () => print('Tapped'),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.black,
                  backgroundImage: CachedNetworkImageProvider(eachUser.url),
                ),
                title: Text(
                  eachUser.profileName,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  eachUser.username,
                  style: TextStyle(color: Colors.black, fontSize: 13.0),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
