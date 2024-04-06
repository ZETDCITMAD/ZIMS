
import 'package:flutter/material.dart';
import 'package:oms_mobile/models/unassigned.dart';
import 'assign_details.dart';

class AssignJobPage extends StatelessWidget {

  final UnassignedOrders data;

  AssignJobPage({Key key, @required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = new GlobalKey<ScaffoldState>();
    return Container(
        child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
        centerTitle: true,
        title: Text('Unassigned job details', textAlign: TextAlign.center),
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
          padding: EdgeInsets.all(10.0),
          child: ListView(
            children: <Widget>[AssignDetails(data: this.data)],
          )),
    ));
  }
}
