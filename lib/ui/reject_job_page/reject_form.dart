import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:oms_mobile/ui/home_page/viewjobform.dart';

// _updateOrder({job_id, context, res}) async {
//   // Map<String, String> headers = {"Content-type": "application/json"};

//   Map<dynamic, dynamic> body = {"status": "aborted", "reason": res};

//   Response response = await post(
//       'http://10.0.2.2:8000/api/incoming_jobs/$job_id',
//       body: body);

//   if (response.statusCode == 200) {
//     print('zanu');
//     Scaffold.of(context)
//         // ignore: deprecated_member_use
//         .showSnackBar(SnackBar(content: Text('Job aborted successfully')));
//     Navigator.pop(context, true);
//   } else {
//     print(response.statusCode);
//   }
// }
_updateOrder({job_id, context, res}) async {
  // Map<String, String> headers = {"Content-type": "application/json"};

  // Map<dynamic, dynamic> body = {"status": "aborted", "reason": res};
  var map = new Map<String,dynamic>();
  map['status'] = "aborted";
    map['reason'] = "$res" ;
   map['job_id'] = job_id;
  Response response = await post(
      'http://moms.zetdc.co.zw/zims_incoming_jobs.php/$job_id',
      body: map);

  if (response.statusCode == 200) {
    print('zanu');
    print(res);
    Scaffold.of(context)
        // ignore: deprecated_member_use
        .showSnackBar(SnackBar(content: Text('Job aborted successfully')));
    Navigator.pop(context, true);
  } else {
    print(response.statusCode);
  }
}
class RejectJobForm extends StatefulWidget {
  final String incident_number;
  String reason;
  String so_CURRENT_STATUS;

  RejectJobForm({
    Key key,
    this.incident_number,
  }) : super(key: key);

  @override
  _RejectJobFormState createState() => _RejectJobFormState();
}

class _RejectJobFormState extends State<RejectJobForm> {
  static final _formKey = GlobalKey<FormState>();
  String incident_number;

  dynamic _reason;

  int _status;

  List<DropdownMenuItem<int>> reasonList = [];

  List<DropdownMenuItem<int>> statusList = [];

  void loadReasonList() {
    reasonList = [];
    reasonList.add(new DropdownMenuItem(
      child: new Text('Requested by the customer'),
      value: 0,
    ));
    reasonList.add(new DropdownMenuItem(
      child: new Text('Service already executed'),
      value: 1,
    ));
    reasonList.add(new DropdownMenuItem(
      child: new Text('SO improperly generated'),
      value: 2,
    ));
    reasonList.add(new DropdownMenuItem(
      child: new Text('Team unavailable'),
      value: 3,
    ));
    reasonList.add(new DropdownMenuItem(
      child: new Text('Planning failure'),
      value: 4,
    ));
    reasonList.add(new DropdownMenuItem(
      child: new Text('False Alarm'),
      value: 5,
    ));
  }

  List<String> valuez = [
    'PENDING',
    'CLOSED',
    'DISCONNECTED',
    'ABORTED',
    'CANCELLED'
  ];

  void loadStatusList() {
    statusList = [];
    statusList.add(new DropdownMenuItem(
      child: new Text('PENDING'),
      value: 0,
    ));
    statusList.add(new DropdownMenuItem(
      child: new Text('CLOSED'),
      value: 1,
    ));
    statusList.add(new DropdownMenuItem(
      child: new Text('DISCONNECTED'),
      value: 2,
    ));
    statusList.add(new DropdownMenuItem(
      child: new Text('ABORTED'),
      value: 3,
    ));
    statusList.add(new DropdownMenuItem(
      child: new Text('CANCELLED'),
      value: 4,
    ));
  }

  int selectedRadioTile;

  final controller_incident = new TextEditingController();
  final controller_exec_label = new TextEditingController();
  final controller_reason = new TextEditingController();
  final controller_status = new TextEditingController();

  @protected
  @mustCallSuper
  void didChangeDependencies() {
    controller_incident.text = widget.incident_number;

    controller_reason.text = widget.reason;
    controller_status.text = widget.so_CURRENT_STATUS;
  }

  @override
  Widget build(BuildContext context) {
    loadReasonList();
    loadStatusList();
    return Container(
      child: Padding(
          padding: EdgeInsets.symmetric(vertical: 0.0),
          child: Form(
              key: _formKey,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      'android/assets/abort.png',
                      height: 150,
                      width: 150,
                    ),
                    Text('Enter reason for aborting job',
                        style: new TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        )),
                    TextFormField(
                      autofocus: false,
                      decoration: InputDecoration(labelText: 'Fault number'),
                      controller: controller_incident,
                    ),
                    // TextFormField(
                    //   autofocus: false,
                    //   decoration: InputDecoration(labelText: 'Incident number'),
                    //   controller: controller_incident,
                    // ),
                    DropdownButton(
                      hint: new Text('Reason'),
                      items: reasonList,
                      value: _reason,
                      onChanged: (value) {
                        setState(() {
                          _reason = value;
                        });
                      },
                      isExpanded: true,
                    ),
                    Padding(
                        padding: EdgeInsets.only(top: 5.0),
                        child: Row(children: <Widget>[
                          Expanded(
                              child: RaisedButton(
                                  color: Colors.red,
                                  textColor: Colors.white,
                                  child: Text(
                                    'Abort',
                                    textScaleFactor: 1.3,
                                  ),
                                  onPressed: () {
                                    List<String> reasonz = [
                                      'Requested by the customer',
                                      'Service already executed',
                                      'So improperly generated',
                                      'Team unavailable',
                                      'Planning failure',
                                      'False Alarm'
                                    ];

                                    _updateOrder(
                                        job_id: widget.incident_number,
                                        context: context,
                                        res: reasonz[_reason]);
                                  }))
                        ]))
                  ]))),
    );
  }
}
