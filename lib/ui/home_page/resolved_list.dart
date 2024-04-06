import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
// import 'package:http/http.dart';
// import 'package:intl/intl.dart';
import 'package:oms_mobile/database/DBHelper.dart';
import 'package:oms_mobile/models/pending_so.dart';
//import 'package:oms_mobile/pages/pending.dart';
// _updateOrder({orderJSON, context, data}) async {
//   // Map<String, String> headers = {"Content-type": "application/json"};
// var job_id = data.job_id;
//   var job_id2 = data.job_id;
//   var map = new Map<String,dynamic>(); 
//   map['job_id'] = "$job_id2";
//   map['attendance_START'] = data.attendance_START;
//    map['fault_IDENTIFICATION'] = data.fault_IDENTIFICATION;
//    map['arrival_AT_LOCATION'] = data.arrival_AT_LOCATION;
//     map['weather_CONDITION'] =data.weather_CONDITION;
//    map['notes'] = data.notes;
//    map['cause'] = data.cause;
   
//    map['so_CURRENT_STATUS'] = data.so_CURRENT_STATUS;
//   Response response = await post(
//       'http://moms.zetdc.co.zw/zims_update_active_job.php/',
//       body: map);
//   if (response.statusCode == 200) {
//     print(job_id);
//      print(job_id2);
//      print(map);
//     // Scaffold.of(context)
//     //     .showSnackBar(SnackBar(content: Text('Job successfully sent')));

//   } else {
//     print(job_id);
//   }
// }
_updateOrder({orderJSON, context, data}) async {
  // Map<String, String> headers = {"Content-type": "application/json"};

  var job_id = data.job_id;

  Response response = await put(
      'http://10.0.2.2:8000/api/update_active_job/$job_id',
      body: orderJSON);
  if (response.statusCode == 200) {
    print(job_id);
    // Scaffold.of(context)
    //     .showSnackBar(SnackBar(content: Text('Job successfully sent')));

  } else {
    print(job_id);
  }
}
// _updateOrder({orderJSON, context, data}) async {
//   // Map<String, String> headers = {"Content-type": "application/json"};
//  Map<String, String> headers = {"Content-type": "application/json"};
//   dynamic exec = orderJSON['job_id.toString()'],
//       fault_IDENTIFICATION = orderJSON['fault_IDENTIFICATION'],
//       attendance_START = orderJSON['attendance_START'],
//       arrival_AT_LOCATION = orderJSON['arrival_AT_LOCATION'],
//       notes = orderJSON['notes'],
//       weather_CONDITION = orderJSON['weather_CONDITION'],
//       cause = orderJSON['cause'],
//       so_CURRENT_STATUS = orderJSON['so_CURRENT_STATUS'];

//   Response response = await put(
//       'http://moms.zetdc.co.zw/zims_update_active_job.php?job_id.toString()=$exec&fault_IDENTIFICATION=$fault_IDENTIFICATION&attendance_START=$attendance_START&arrival_AT_LOCATION=$arrival_AT_LOCATION&notes=$notes&weather_CONDITION=$weather_CONDITION&cause=$cause&so_CURRENT_STATUS=$so_CURRENT_STATUS',
//       headers: headers);

//   print(fault_IDENTIFICATION + 'identify');

//   if (response.statusCode == 200) {
//     print('bholato');
//   } else {
//     print(response.statusCode);
//     showDialog(
//         context: context,
//         builder: (context) {
//           // return AlertDialog(content: Text("Failed"));
//           return AlertDialog(content: Text("Success"));
//         });
//   }
// }
Future<void> _asyncConfirmDialog(
    {BuildContext context, PendingServiceOrder order, data}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button for close dialog!
    builder: (BuildContext context) {
      return AlertDialog(
        content: const Text('Are you sure you want to send this job?'),
        actions: <Widget>[
          TextButton(
            child: const Text('NO'),
            onPressed: () {
              Navigator.of(context).pop(context);
            },
          ),
          TextButton(
            child: const Text('YES'),
            onPressed: () {
              Map<dynamic, dynamic> dataJson = {
                "attendance_START": data.attendance_START,
                "fault_IDENTIFICATION": data.fault_IDENTIFICATION,
                "arrival_AT_LOCATION": data.arrival_AT_LOCATION,
                "notes": data.notes,
                "weather_CONDITION": data.weather_CONDITION,
                "cause": data.cause,
                "so_CURRENT_STATUS": data.so_CURRENT_STATUS
              };
              _updateOrder(
                  orderJSON: dataJson,
                  // orderJSON: jsonEncode(dataJson),
                  context: context,
                  data: data);

              //stateFn();
              Navigator.of(context).pop(context);

              return showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: Text("Data successfully sent"),
                  );
                },
              );
            },
          )
        ],
      );
    },
  );
}

Future<List<PendingServiceOrder>> getPendingServiceOrderFromDB() async {
  var dbHelper = DatabaseHelper();
  Future<List<PendingServiceOrder>> orderz = dbHelper.getServiceOrders();
  return orderz;
}

class ResolvedList extends StatefulWidget {
  ResolvedList({Key key}) : super(key: key);

  @override
  _ResolvedListState createState() => _ResolvedListState();
}

class _ResolvedListState extends State<ResolvedList> {
  bool view = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: FutureBuilder<List<PendingServiceOrder>>(
        future: getPendingServiceOrderFromDB(),
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    if (snapshot.data[index].so_CURRENT_STATUS != '') {
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
                                          // Navigator.push(
                                          //   context,
                                          //   MaterialPageRoute(
                                          //       builder: (context) =>
                                          //           UpdateDataPage(
                                          //               data: snapshot
                                          //                   .data[index])),
                                          // );
                                        },
                                        child: ListTile(
                                            leading:
                                                Icon(Icons.album, size: 50),
                                            title: Text(snapshot
                                                .data[index].job_id
                                                .toString()),
                                            subtitle: Text(snapshot
                                                .data[index].attendance_START),
                                            trailing: GestureDetector(
                                              child: Icon(Icons.delete,
                                                  color: Colors.red),
                                              onTap: () {
                                                var dbHelper = DatabaseHelper();
                                                dbHelper.deleteServiceOrder(
                                                    snapshot
                                                        .data[index].job_id);
                                                setState(() {
                                                  getPendingServiceOrderFromDB();
                                                });
                                              },
                                            )),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              // apa tuku edza reloading with new list
                              // void stateFn() {
                              //   setState(() {
                              //     getPendingServiceOrderFromDB();
                              //   });
                              // }

                              var data = snapshot.data[index];

                              _asyncConfirmDialog(context: context, data: data);
                            },
                            child: const Text('Sync',
                                style: TextStyle(color: Colors.blue)),
                          ),
                        ],
                      );
                    } else {
                      return Container();
                    }
                  });
            } else if (snapshot.data.length == 0) {
              return Text('No Data Found');
            }
          }

          // show loadinf indicator wen snapshot is empty
          return new Container(
            alignment: AlignmentDirectional.center,
            child: new CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
