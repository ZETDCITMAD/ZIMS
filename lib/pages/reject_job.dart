import 'package:flutter/material.dart';
import 'package:oms_mobile/models/serviceorders.dart';
import 'package:oms_mobile/ui/home_page/viewjobform.dart';
import 'package:oms_mobile/ui/reject_job_page/reject_form.dart';
import 'package:http/http.dart';

_updateOrder({job_id, context}) async {
  Map<String, String> headers = {"Content-type": "application/json"};
  var map = new Map<String,dynamic>();
  map['status'] = "aborted";
    map['reason'] = "rejected";
   map['job_id'] = job_id;
  // Map<dynamic, dynamic> body = {
  //   "status": "accepted"
  //   //  "job_id": job_id
  //   };
    // var job_id = data.job_id;
//  var map = new Map<String,dynamic>();
//   map['job_id'] = job_id;
//   map['status'] = 'accepted';
  Response response = await post(
      'http://moms.zetdc.co.zw/zims_incoming_jobs.php/$job_id',
      body: map);

  if (response.statusCode == 200) {
  } else {
    print(response.statusCode);
  }
}

class RejectJobPage extends StatelessWidget {
  final String incident_number;
  RejectJobPage({Key key, @required this.incident_number}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = new GlobalKey<ScaffoldState>();
    return Container(
        child: Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Abort Job', textAlign: TextAlign.center),
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
            children: <Widget>[
              RejectJobForm(incident_number: this.incident_number)
            ],
          )),
    ));
  }
}
