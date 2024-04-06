import 'package:flutter/material.dart';
import 'package:oms_mobile/ui/home_page/drawer.dart';
import 'package:oms_mobile/ui/home_page/pending_list.dart';
import 'package:oms_mobile/ui/home_page/resolved_list.dart';
import 'package:oms_mobile/ui/home_page/search_jobs.dart';

import 'assignto/unassigned_jobs.dart';

class HomePage extends StatefulWidget {
  final String ecnumber;
  // final int role;
  final String username;
  HomePage({Key key, @required this.ecnumber, this.username}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
            title: Text('Jobs'),
            bottom: TabBar(
              tabs: <Widget>[
                //  Tab(icon: Icon(Icons.assignment), text: 'Faults'),
                Tab(icon: Icon(Icons.assignment), text: 'Assigned'),
                Tab(icon: Icon(Icons.access_time), text: 'Pending'),
                Tab(icon: Icon(Icons.notifications_active), text: 'Resolved'),
              ],
            ),
            actions: <Widget>[]),
        drawer: AppDrawer(
          
          //  ecnumber:this.ecnumber

        ),
        body: TabBarView(
          children: [
            Card(
              elevation: 10,
              child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                Expanded(
                    child: SearchJobs(
                  ecnumber: widget.ecnumber,
                ))
              ]),
            ),
            Card(
              elevation: 10,
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[Expanded(child: PendingList())]),
            ),
            Card(
              elevation: 10,
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[Expanded(child: ResolvedList())]),
            ),
          ],
        ),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {
        //     Navigator.push(
        //         context,
        //         new MaterialPageRoute(
        //             builder: (context) => UnassignedJobs(
        //                   ecnumber: widget.ecnumber,
        //                 )));
        //   },
        //   child: Icon(Icons.work),
        //   backgroundColor: Colors.red,
        // ),
      ),
    );
  }
}
