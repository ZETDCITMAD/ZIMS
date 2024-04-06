import 'package:flutter/material.dart';
import 'package:oms_mobile/models/serviceorders.dart';
import 'package:oms_mobile/ui/home_page/viewjobform.dart';

class ViewJobPage extends StatelessWidget {
  final data;

  ViewJobPage({Key key, @required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = new GlobalKey<ScaffoldState>();
    return Container(
        child: Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        title: Text('View Job', textAlign: TextAlign.center),
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
            children: <Widget>[ViewJobForm(data: this.data)],
          )),
    ));
  }
}
