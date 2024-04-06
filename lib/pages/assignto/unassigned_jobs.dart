import 'package:flutter/material.dart';
import 'package:oms_mobile/pages/assignto/assignto.dart';

class UnassignedJobs extends StatefulWidget {
  final String ecnumber;
  UnassignedJobs({Key key, @required this.ecnumber}) : super(key: key);

  @override
  _UnassignedJobsState createState() => _UnassignedJobsState();
}

class _UnassignedJobsState extends State<UnassignedJobs> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title:
                Text('Unassigned service orders', textAlign: TextAlign.center),
            leading: new IconButton(
              icon: new Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 10),
                Padding(
                  padding: EdgeInsets.all(5),
                ),
                Expanded(child: AssignToPage(ecnumber: widget.ecnumber))
              ])),
    );
  }
}
