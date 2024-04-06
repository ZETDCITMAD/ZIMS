import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:oms_mobile/models/crews.dart';
import 'package:oms_mobile/models/unassigned.dart';

Future<List<Crews>> fetchCrews({String depot}) async {
  var crew = Crews();
  // print(serviceOrders.toOrderList(response.body));
  return crew.toOrderList([
    {'rsc_description': 'L. Simoyi', 'pers_identity': 'CBD-674'},
    {'rsc_description': 'T. Saidi', 'pers_identity': 'CBD-675'},
    {'rsc_description': 'T. Mubaiwa', 'pers_identity': 'CBD-677'},
    {'rsc_description': 'B. Chikura', 'pers_identity': 'CBD-676'},
  ]);

  // final response = await http.post(
  //     'https://agent.zetdc.co.zw/omsmobile/track_crew_depot.php?depot=$depot');

  // if (response.statusCode == 200) {
  //   // If the server did return a 200 OK response,
  //   // then parse the JSON.
  //   var crew = Crews();
  //   // print(serviceOrders.toOrderList(response.body));
  //   return crew.toOrderList(json.decode(response.body));
  // } else {
  //   // If the server did not return a 200 OK response,
  //   // then throw an exception.
  //   print(response.statusCode);
  //   return showDialog(
  //     builder: (context) {
  //       return AlertDialog(
  //         // Retrieve the text the user has entered by using the
  //         // TextEditingController.
  //         content: Text("No crews"),
  //       );
  //     },
  //     context: null,
  //   );
  // }
}

_updateJob({orderJSON, context}) async {
  Map<String, String> headers = {"Content-type": "application/json"};
  dynamic exec_order = orderJSON['exec_order'],
      dispatch_date = orderJSON['dispatch_date'],
      instance_oper_node = orderJSON['instance_oper_node'],
      resource_id = orderJSON['resource_id'];

  Response response = await put(
      'https://agent.zetdc.co.zw/omsmobile/update_art.php?exec_order=$exec_order&dispatch_date=$dispatch_date&instance_oper_node=$instance_oper_node&resource_id=$resource_id',
      headers: headers);

  print(resource_id + 'bho');

  if (response.statusCode == 200) {
    print("bholato artisan assigned");
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          // Retrieve the text the user has entered by using the
          // TextEditingController.
          content: Text("Job assigned successfully"),
        );
      },
    );
  } else {
    print(response.statusCode);
  }
}

class TrackCrew extends StatefulWidget {
  final UnassignedOrders data;
  final Crews daata;
  TrackCrew({Key key, @required this.data, this.daata}) : super(key: key);

  @override
  _TrackCrewState createState() => _TrackCrewState();
}

class _TrackCrewState extends State<TrackCrew> {
  Future<List<Crews>> crews;

  @override
  void initState() {
    super.initState();
    crews = fetchCrews(depot: widget.data.node_ID_INC);
    //crews = fetchCrews();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Crews>>(
      future: crews,
      builder: (context, snapshot) {
        if (snapshot.data != null) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return new Row(
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Card(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: () {
                                      //print(widget.daata.rsc_description);
                                      bholato();
                                    },
                                    child: ListTile(
                                      leading: Icon(
                                        Icons.person,
                                        size: 40,
                                        color: Colors.blue[400],
                                      ),
                                      title: Text(
                                          snapshot.data[index].rsc_description),
                                      trailing: Text(
                                          snapshot.data[index].pers_identity),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  );
                });
          } else if (snapshot.data.length == 0) {
            return Text('No Data Found');
          }
        }
        // By default, show a loading spinner.
        return new Container(
          alignment: AlignmentDirectional.center,
          child: new CircularProgressIndicator(),
        );
      },
    );
  }

  void bholato() {
    DateTime now = DateTime.now();
    DateFormat formatterDay = DateFormat('yyyy-MM-dd');
    DateFormat formatterTime = DateFormat('hh:mm:ss');
    String formattedDay = formatterDay.format(now);
    String formattedTime = formatterTime.format(now);

    var dateTime = formattedDay + 'T' + formattedTime + 'Z';

    print(dateTime);

    Map<dynamic, dynamic> dataJson = {
      "exec_order": widget.data.order_ID,
      "dispatch_date": dateTime,
      "instance_oper_node": widget.data.node_ID_INC,
      "resource_id": '26026'
    };

    _updateJob(orderJSON: dataJson, context: context);
  }
}
