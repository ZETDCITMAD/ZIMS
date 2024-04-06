import 'package:flutter/material.dart';

class AssignedJobPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Action job", textAlign: TextAlign.center),
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: <Widget>[
            Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () {},
                  child: Icon(
                    Icons.location_on,
                    size: 22.0,
                  ),
                )),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.all(30.0),
          child: ListView(
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.fromLTRB(20.0, 0.0, 15.0, 0.0),
                  child: Text('Job details',
                      style: new TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold))),
              // AssignedJobForm(),
              FlatButton(
                child:
                    const Text('VIEW MORE...', style: TextStyle(color: Colors.blue)),
                onPressed: () {
                  
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
