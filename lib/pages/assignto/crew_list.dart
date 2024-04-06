import 'package:flutter/material.dart';
import 'package:oms_mobile/models/unassigned.dart';
import 'package:oms_mobile/pages/assignto/track_crew.dart';

class CrewList extends StatefulWidget {
  final UnassignedOrders data;
  CrewList({Key key, @required this.data}) : super(key: key);

  @override
  _CrewListState createState() => _CrewListState();
}

class _CrewListState extends State<CrewList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title:
                Text('Crew List', textAlign: TextAlign.center),
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
                Expanded(child: TrackCrew(data: this.widget.data,))
              ])),
    );
  }
}
