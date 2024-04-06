import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:oms_mobile/database/DBHelper.dart';
import 'package:oms_mobile/models/pending_so.dart';
import 'package:oms_mobile/pages/materials/reserve_materials.dart';
import 'package:oms_mobile/pages/pending.dart';
import 'package:shared_preferences/shared_preferences.dart';

_updateOrder({orderJSON, context}) async {
  Map<String, String> headers = {"Content-type": "application/json"};
  dynamic exec = orderJSON['job_id.toString()'],
      fault_IDENTIFICATION = orderJSON['fault_IDENTIFICATION'],
      attendance_START = orderJSON['attendance_START'],
      arrival_AT_LOCATION = orderJSON['arrival_AT_LOCATION'],
      notes = orderJSON['notes'],
      weather_CONDITION = orderJSON['weather_CONDITION'],
      cause = orderJSON['cause'],
      so_CURRENT_STATUS = orderJSON['so_CURRENT_STATUS'];

  Response response = await put(
      'https://agent.zetdc.co.zw/omsmobile/update_order.php?job_id.toString()=$exec&fault_IDENTIFICATION=$fault_IDENTIFICATION&attendance_START=$attendance_START&arrival_AT_LOCATION=$arrival_AT_LOCATION&notes=$notes&weather_CONDITION=$weather_CONDITION&cause=$cause&so_CURRENT_STATUS=$so_CURRENT_STATUS',
      headers: headers);

  print(fault_IDENTIFICATION + 'identify');

  if (response.statusCode == 200) {
    print('bholato');
  } else {
    print(response.statusCode);
    showDialog(
        context: context,
        builder: (context) {
          // return AlertDialog(content: Text("Failed"));
          return AlertDialog(content: Text("Success"));
        });
  }
}

// Future<void> _asyncConfirmDialog(
//     {BuildContext context, PendingServiceOrder order, stateFn}) async {
//   return showDialog<void>(
//     context: context,
//     barrierDismissible: false, // user must tap button for close dialog!
//     builder: (BuildContext context) {
//       return AlertDialog(
//         content: const Text('Are you sure you want to delete this job?'),
//         actions: <Widget>[
//           FlatButton(
//             child: const Text('NO'),
//             onPressed: () {
//               Navigator.of(context).pop(context);
//             },
//           ),
//           FlatButton(
//             child: const Text('YES'),
//             onPressed: () {
//               var dbHelper = DatabaseHelper();
//               dbHelper.deleteServiceOrder(order);
//               stateFn();
//               Navigator.of(context).pop(context);
//             },
//           )
//         ],
//       );
//     },
//   );
// }

Future<dynamic> arriveIdentfy({job_id}) async {
  var dbHelper = DatabaseHelper();
  Future<List<PendingServiceOrder>> order =
      dbHelper.getOneServiceOrder(job_id: job_id);
  return order;
}

Future<List<PendingServiceOrder>> getPendingServiceOrderFromDB() async {
  var dbHelper = DatabaseHelper();
  Future<List<PendingServiceOrder>> orderz = dbHelper.getServiceOrders();
  return orderz;
}

class PendingList extends StatefulWidget {
  PendingList({Key key}) : super(key: key);

  @override
  _PendingListState createState() => _PendingListState();
}

class _PendingListState extends State<PendingList> {
  String arrivalTime;
  bool arrive;
  bool id;
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
                    if (snapshot.data[index].arrival_AT_LOCATION == '') {
                      this.arrive = true;
                      this.id = false;
                    } else {
                      this.arrive = false;
                      if (snapshot.data[index].fault_IDENTIFICATION == '') {
                        this.id = true;
                        this.view = false;
                      } else {
                        this.view = true;
                        this.id = false;
                      }
                    }
                    return new Row(
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              // Text("Increase efficiency by tracking your work",
                              //     style: new TextStyle(fontSize: 16)),

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
                                        leading: Icon(
                                          Icons.album,
                                          size: 50,
                                          color: Colors.orange,
                                        ),
                                        title: Text(snapshot.data[index].job_id
                                            .toString()),
                                        subtitle: Text(snapshot
                                            .data[index].attendance_START),
                                      ),
                                    ),
                                    Visibility(
                                      visible: this.arrive, //(snapshot.data[index].attendance_START == '')? true : false,
                                      child: FlatButton(
                                          child: const Text('ARRIVE',
                                              style:
                                                  TextStyle(color: Colors.red)),
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

                                            var dateTime = formattedDay +
                                                'T' +
                                                formattedTime +
                                                'Z';

                                            Map<dynamic, dynamic> dataJson = {
                                              "job_id.toString()": snapshot
                                                  .data[index].job_id
                                                  .toString(),
                                              "attendance_START": snapshot
                                                  .data[index].attendance_START,
                                              "fault_IDENTIFICATION": '',
                                              "arrival_AT_LOCATION": dateTime,
                                              "notes": '',
                                              "weather_CONDITION": '',
                                              "cause": '',
                                              "so_CURRENT_STATUS": ''
                                            };

                                            _updateOrder(
                                                orderJSON: dataJson,
                                                //orderJSON: jsonEncode(dataJson),
                                                context: context);

                                            var job = PendingServiceOrder(
                                                job_id:
                                                    snapshot.data[index].job_id,
                                                arrival_AT_LOCATION: dateTime);

                                            var db = DatabaseHelper();
                                            db.updateServiceOrderArrivalAtLocation(
                                                job);

                                            print(snapshot
                                                .data[index].attendance_START);
                                            print(snapshot.data[index]
                                                .arrival_AT_LOCATION);

                                            // apa takubisa arrive from UX toisa id
                                            setState(() {
                                              this.arrive = false;
                                              // getPendingServiceOrderFromDB();
                                            });

                                            return showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  // Retrieve the text the user has entered by using the
                                                  // TextEditingController.
                                                  content: Text(
                                                      "Arrival time saved"),
                                                );
                                              },
                                            );
                                          }),
                                    ),
                                    // Visibility(
                                    //   visible: view,
                                    //   child: GestureDetector(
                                    //     onTap: () {
                                    //       var dbHelper = DatabaseHelper();
                                    //       dbHelper.deleteServiceOrder(
                                    //           snapshot.data[index].job_id.toString());
                                    //       setState(() {
                                    //         getPendingServiceOrderFromDB();
                                    //       });
                                    //     },
                                    //     child: Padding(
                                    //       padding: EdgeInsets.only(bottom: 10),
                                    //       child: const Text('Delete',
                                    //           style:
                                    //               TextStyle(color: Colors.red)),
                                    //     ),
                                    //   ),
                                    // ),
                                    Visibility(
                                      visible: this.id,
                                      child: FlatButton(
                                        child: const Text('IDENTIFY FAULT',
                                            style:
                                                TextStyle(color: Colors.blue)),
                                        onPressed: () {
                                          setState(() {
                                            this.id = false;
                                          });
                                          DateTime now = DateTime.now();
                                          DateFormat formatterDay =
                                              DateFormat('yyyy-MM-dd');
                                          DateFormat formatterTime =
                                              DateFormat('hh:mm:ss');
                                          String formattedDay =
                                              formatterDay.format(now);
                                          String formattedTime =
                                              formatterTime.format(now);

                                          var dateTime = formattedDay +
                                              'T' +
                                              formattedTime +
                                              'Z';

                                          Map<dynamic, dynamic> dataJson = {
                                            "job_id.toString()": snapshot
                                                .data[index].job_id
                                                .toString(),
                                            "attendance_START": snapshot
                                                .data[index].attendance_START,
                                            "fault_IDENTIFICATION": dateTime,
                                            "arrival_AT_LOCATION": snapshot
                                                .data[index]
                                                .arrival_AT_LOCATION,
                                            "notes": '',
                                            "weather_CONDITION": '',
                                            "cause": '',
                                            "so_CURRENT_STATUS": ''
                                          };

                                          _updateOrder(
                                              orderJSON: dataJson,
                                              //orderJSON: jsonEncode(dataJson),
                                              context: context);

                                          var job = PendingServiceOrder(
                                              job_id:
                                                  snapshot.data[index].job_id,
                                              fault_IDENTIFICATION: dateTime);

                                          var db = DatabaseHelper();
                                          db.updateServiceOrderFaultID(job);

                                          print(snapshot
                                              .data[index].attendance_START);
                                          print(snapshot
                                              .data[index].arrival_AT_LOCATION);
                                          print(snapshot.data[index]
                                              .fault_IDENTIFICATION);

                                          return showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                // Retrieve the text the user has entered by using the
                                                // TextEditingController.
                                                content: Text(
                                                    "Fault identification time saved"),
                                              );
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                    ButtonBar(
                                      alignment: MainAxisAlignment.center,
                                      children: [
                                        RaisedButton(
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  new MaterialPageRoute(
                                                      builder: (context) =>
                                                          ReserveMaterials(
                                                            job_id: snapshot
                                                                .data[index]
                                                                .job_id,
                                                          )));
                                            },
                                            child: Text('Reserve Materials'),
                                            elevation: 5,
                                            color: Colors.orange,
                                            textColor: Colors.white,
                                            splashColor: Colors.grey),
                                        RaisedButton(
                                          onPressed: () {
                                            setState(() {
                                              getPendingServiceOrderFromDB();
                                            });
                                            Navigator.push(
                                                context,
                                                new MaterialPageRoute(
                                                    builder: (context) =>
                                                        PendingPage(
                                                            job_id: snapshot
                                                                .data[index]
                                                                .job_id)));
                                          },
                                          child: Text('View more'),
                                          elevation: 5,
                                          color: Theme.of(context).accentColor,
                                          textColor: Colors.white,
                                          splashColor: Colors.grey,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),

                              // GestureDetector(
                              //   onTap: () {
                              //     setState(() {
                              //       //getPendingServiceOrderFromDB();
                              //     });
                              //   },
                              //   child: const Text('Reserve Materials',
                              //       style:
                              //           TextStyle(color: Colors.blue)),
                              // ),
                            ],
                          ),
                        ),
                        // Visibility(
                        //   visible: view,
                        //   child: GestureDetector(
                        //     onTap: () {
                        //       setState(() {
                        //         getPendingServiceOrderFromDB();
                        //       });
                        //       // Navigator.push(
                        //       //     context,
                        //       //     new MaterialPageRoute(
                        //       //         builder: (context) => PendingPage(
                        //       //             job_id.toString(): snapshot
                        //       //                 .data[index].job_id.toString())));
                        //     },
                        //     child: const Text('Reserve Materials',
                        //         style: TextStyle(color: Colors.blue)),
                        //   ),
                        // ),
                      ],
                    );
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
