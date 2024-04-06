import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:oms_mobile/database/DBHelper.dart';
import 'package:oms_mobile/models/pending_so.dart';
import 'package:oms_mobile/models/serviceorders.dart';
import 'package:oms_mobile/pages/reject_job.dart';

_updateOrder({job_id, context}) async {
  Map<String, String> headers = {"Content-type": "application/json"};
  // var map = new Map<String,dynamic>();
  // map['status'] = "accepted";
  //  map['job_id'] = job_id;
  Map<dynamic, dynamic> body = {
    "status": "accepted"
    //  "job_id": job_id
    };
    // var job_id = data.job_id;
//  var map = new Map<String,dynamic>();
//   map['job_id'] = job_id;
//   map['status'] = 'accepted';
  Response response = await post(
      'http://10.0.2.2:8000/api/incoming_jobs/$job_id',
      body: body);

  if (response.statusCode == 200) {
  } else {
    print(response.statusCode);
  }
}

// _updateOrder({job_id:String, context}) async {
//   // Map<String, String> headers = {"Content-type": "application/json"};
//   var map = new Map<String,dynamic>();
//   map['status'] = "accepted";
//    map['reason'] = "accepted";
//    map['job_id'] = "$job_id";
//     //  map['reason'] = null;
// print(map);
//   // Map<dynamic, dynamic> body = {
//   //   "status": "accepted"
//   //   //  "job_id": job_id
//   //   };
//     // var job_id = data.job_id;
// //  var map = new Map<String,dynamic>();
// //   map['job_id'] = job_id;
// //   map['status'] = 'accepted';
//   Response response = await post(
//       'http://moms.zetdc.co.zw/zims_incoming_jobs.php/$job_id',
//       body: map);

//   if (response.statusCode == 200) {
//       print(response);
//   } else {
//     print(response.statusCode);
//   }
// }
Future<List<PendingServiceOrder>> getPendingServiceOrderFromDB() async {
  var dbHelper = DatabaseHelper();
  Future<List<PendingServiceOrder>> orderz = dbHelper.getServiceOrders();
  return orderz;
}

class ViewJobForm extends StatefulWidget {
  String DateTime;
  final String exec_label;
  final data;
  ViewJobForm({Key key, @required this.data, this.exec_label})
      : super(key: key);

  @override
  _ViewJobFormState createState() => _ViewJobFormState();
}

class _ViewJobFormState extends State<ViewJobForm> {
  static final _formKey = GlobalKey<FormState>();
  String exec_label;
  String additional_notes;
  final controller_address = new TextEditingController();
  final controller_job_id = new TextEditingController();
  final controller_out_type_description = new TextEditingController();
  final controller_meterno = new TextEditingController();
  final controller_complaintno = new TextEditingController();
  final controller_artisanassignedon = new TextEditingController();
  final controller_additional_notes = new TextEditingController();
  final controller_status = new TextEditingController();
  @protected
  @mustCallSuper
  void didChangeDependencies() {
    controller_address.text = widget.data['address'];
    controller_job_id.text = widget.data['job_id'].toString();
    controller_out_type_description.text = widget.data['out_type_description'];
    controller_meterno.text = widget.data['meterno'];
    controller_complaintno.text = widget.data['complaintno'];
    controller_artisanassignedon.text = widget.data['artisanassignedon'];
    controller_additional_notes.text = widget.data['additional_notes'];
    controller_status.text = widget.data['status'];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        child: Padding(
            padding: EdgeInsets.only(top: 5.0, left: 20.0, right: 20.0),
            child: Form(
                key: _formKey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Image.asset('android/assets/outage.png'),
                      TextFormField(
                        autofocus: false,
                        readOnly: true,
                        decoration: InputDecoration(

                            // hintText: '${widget.data.company_name}',
                            labelText: 'Date Assigned'),
                        controller: controller_artisanassignedon,
                      ),
                      TextFormField(
                        autofocus: false,
                        readOnly: true,
                        decoration: InputDecoration(
                            // hintText: '${widget.data.company_name}',
                            labelText: 'Fault Address'),
                        controller: controller_address,
                      ),
                      
                      TextFormField(
                        autofocus: false,
                        readOnly: true,
                        decoration: InputDecoration(
                            // hintText: '${widget.data.company_name}',
                            labelText: 'Complaint #'),
                        controller: controller_complaintno,
                      ),
                      TextFormField(
                        autofocus: false,
                        readOnly: true,
                        decoration: InputDecoration(
                            // hintText: r'${widget.data.company_name}',
                            labelText: 'Network Incident Number'),
                        controller: controller_job_id,
                      ),
                      TextFormField(
                        autofocus: false,
                        readOnly: true,
                        decoration: InputDecoration(
                            // hintText: '${widget.data.company_name}',
                            labelText: 'Incident Type'),
                        controller: controller_out_type_description,
                      ),
                      TextFormField(
                        autofocus: false,
                        readOnly: true,
                        decoration:
                            InputDecoration(labelText: 'Additional Notes'),
                        controller: controller_additional_notes,
                      ),
                      TextFormField(
                        autofocus: false,
                        readOnly: true,
                        decoration: InputDecoration(labelText: 'Meter Number'),
                        controller: controller_meterno,
                      ),
                      // TextFormField(
                      //   readOnly: true,
                      //   decoration: InputDecoration(
                      //       fillColor: Colors.red[200],
                      //       labelText: 'Fault Status'),
                      //   controller: controller_status,
                      // ),
                      Padding(
                          padding: EdgeInsets.only(top: 5.0),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                  child: FlatButton(
                                      color: Colors.red,
                                      textColor: Colors.white,
                                      child: Text(
                                        'Abort',
                                        textScaleFactor: 1.3,
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            new MaterialPageRoute(
                                                builder: (context) =>
                                                    RejectJobPage(
                                                      incident_number: widget
                                                          .data['job_id']
                                                          .toString(),
                                                    )));
                                      })),
                              Container(width: 10.0),
                              Expanded(
                                  child: RaisedButton(
                                      color: Colors.blue[800],
                                      textColor: Colors.white,
                                      child: Text(
                                        'Accept',
                                        textScaleFactor: 1.3,
                                      ),
                                      onPressed: () {
                                        DateTime now = DateTime.now();
                                        DateFormat formatterDay =
                                            DateFormat('yyyy-MM-dd');
                                        DateFormat formatterTime =
                                            DateFormat('hh:mm:ss');
                                        String formattedDay =
                                            formatterDay.format(now);
                                        String formattedTime =
                                            formatterTime.format(now);
                                        // Validate returns true if the form is valid, or true
                                        // otherwise.
                                        if (_formKey.currentState.validate()) {
                                          _formKey.currentState.save();
                                          var dateTime = formattedDay +
                                              'T' +
                                              formattedTime +
                                              'Z';

                                          var job = PendingServiceOrder(
                                              job_id: widget.data['job_id'],
                                              fault_IDENTIFICATION: '',
                                              arrival_AT_LOCATION: '',
                                              attendance_START: dateTime,
                                              notes: '',
                                              weather_CONDITION: '',
                                              cause: '',
                                              so_CURRENT_STATUS: '');
                                          var db = DatabaseHelper();

                                          print(dateTime);
                                          Navigator.pop(context);
                                          bholato() {
                                            _updateOrder(
                                                job_id: widget.data['job_id'],
                                                context: context);

                                            return showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  // Retrieve the text the user has entered by using the
                                                  // TextEditingController.
                                                  content: Text(
                                                      "Service order now in execution"),
                                                );
                                              },
                                            );
                                          }

                                          maya() {
                                            return showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  // Retrieve the text the user has entered by using the
                                                  // TextEditingController.
                                                  content: Text(
                                                      "You have a pending job"),
                                                );
                                              },
                                            );
                                          }

                                          getPendingServiceOrderFromDB()
                                              .then((value) => {
                                                    if (value.length == 0)
                                                      {
                                                        db.addServiceOrder(job),
                                                        bholato()
                                                      }
                                                    else
                                                      {maya()}
                                                  });
                                        } else
                                          return showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                // Retrieve the text the user has entered by using the
                                                // TextEditingController.
                                                content:
                                                    Text("Error accepting job"),
                                              );
                                            },
                                          );
                                      })),
                            ],
                          ))
                    ]))));
  }
}
