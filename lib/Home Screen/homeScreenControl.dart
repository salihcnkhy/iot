import 'package:flutter/material.dart';
import 'package:iot102/FireBaseConn.dart';
import 'package:iot102/Login%20Screen/loginPageController.dart';
import 'package:iot102/splashScreen.dart';
import '../User.dart';
import './mainPage.dart';
import './profilePage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Map<Widget, String> _pages = {
    MainPage(): "Ana Ekran",
    ProfilePage(): "Profil"
  };

  int _pageIndex = 0;

  void onTabTapped(int index) {
    setState(() {
      print(index);
      _pageIndex = index;
    });
  }

  Widget bottomNavBar() {
    return BottomNavigationBar(
      onTap: onTabTapped,
      currentIndex: _pageIndex,
      items: [
        BottomNavigationBarItem(
          icon: new Icon(Icons.home),
          title: new Text('Home'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          title: Text('Profile'),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var appBar = AppBar(
      title: Text(_pages.entries.elementAt(_pageIndex).value),
      actions: <Widget>[

        IconButton(

          onPressed: () async {
            FireBaseConn().logOut();
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                builder: (BuildContext context) {
                  return new LoginPage();
                },
              ), (_) => false);
          },
          icon: Icon(Icons.lock_open),
          
        )

      ],
    );

    return FutureBuilder(
      future: FireBaseConn().getDocumentsFrom(collectionName: "Users",documentName: "user1"),
      builder: (context, res) {
        if (res.data != null) {
           user = new User(
              containerCapacity: res.data["containerCapacity"],
              currentContainerCapacity: res.data["currentContainerCapacity"],
              currentStorageCapacity: res.data["currentStorageCapacity"],
              storageCapacity: res.data["storageCapacity"],
              lastSevenDays: List.from(res.data["days"]));
          return Scaffold(
              appBar: appBar,
              bottomNavigationBar: bottomNavBar(),
              body: _pages.entries.elementAt(_pageIndex).key);
        }
        else return SplashScreen();
      },
    );
  }
}
