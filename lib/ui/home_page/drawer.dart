import 'package:flutter/material.dart';
import 'package:oms_mobile/pages/home.dart';
import 'package:oms_mobile/pages/login.dart';

class AppDrawer extends StatefulWidget {
  // final String username;
    // AppDrawer({Key key, this.username}) : super(key: key);

  get ecnumber => null;

  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  Widget _createHeader() {
    return DrawerHeader(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
        image: DecorationImage(
            fit: BoxFit.scaleDown,
            image: AssetImage('android/assets/person.png')),
      ),
      child: Stack(children: <Widget>[
    
        // Positioned(
        //     bottom: 0.0,
        //     left: 120.0,
        //     child: Text(widget.ecnumber,
        //         style: TextStyle(
        //             color: Colors.black,
        //             fontSize: 16.0,
        //             fontWeight: FontWeight.w500))),
      ]),
    );
  }

  Widget _createDrawerItem(
      {IconData icon, String text, GestureTapCallback onTap}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(icon),
          Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text(text),
          )
        ],
      ),
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          _createHeader(),
          // _createDrawerItem(
          //     icon: Icons.home,
          //     text: 'Home',
          //     onTap: () => {
          //           Navigator.push(context,
          //               MaterialPageRoute(builder: (context) => HomePage()))
          //         }),
          // _createDrawerItem(
          //     icon: Icons.local_library, text: 'Materials', onTap: () => {}),
          // _createDrawerItem(
          //     icon: Icons.notifications,
          //     text: 'Notifications',
          //     onTap: () => {}),
          // _createDrawerItem(icon: Icons.info, text: 'About', onTap: () => {}),
          _createDrawerItem(
              icon: Icons.timelapse,
              text: 'Logout',
              onTap: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    )
                  }),
        ],
      ),
    );
  }
}
