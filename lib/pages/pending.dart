import 'package:flutter/material.dart';
import 'package:oms_mobile/ui/pending_form.dart';

class PendingPage extends StatelessWidget {
  String DateTime;
  final int job_id;
  PendingPage({Key key, @required this.job_id, String DateTime})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("In-Execution", textAlign: TextAlign.center),
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          // actions: <Widget>[
          //   Padding(
          //   padding: EdgeInsets.only(right: 20.0),
          //   child: GestureDetector(
          //     onTap: () {},
          //     child: Icon(
          //       Icons.location_on,
          //       size: 26.0,
          //     ),
          //   )
          // ),
          // ],
        ),
        body: Padding(
          padding: EdgeInsets.all(30.0),
          child: ListView(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(20.0, 0.0, 15.0, 0.0),
                child: Text("Fault number: $job_id",
                    textAlign: TextAlign.center,
                    style: new TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
              ),
              PendingForm(
                job_id: this.job_id,
                DateTime: this.DateTime,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
