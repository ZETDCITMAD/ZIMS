import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:oms_mobile/models/unassigned.dart';

import 'assign_page.dart';

Future<List<UnassignedOrders>> fetchServiceOrders({ecnumber}) async {
      var serviceOrders = UnassignedOrders();
    //print(response.body);
    // print(serviceOrders.toOrderList(response.body));
    return serviceOrders.toOrderList([{
      'network_SERVICE_NUMBER' : 'ZIMS2022-235',
      'network_SERVICE_SUBTYPE': 'TREE ON LINE',
      'situation': 'No Power On Red Phase',
      'creation_DATE_INC': '2022-08-07',
      'reference_ELEMENT_ADDRESS': '69 Chiremba Road, Wilmington Park',
      'voltage_LEVEL': 'MV',
      'hood_LABEL_INC': 'Chiremba Areas',
      'node_ID_INC': ''
    }]);
  // final response = await http.post(
  //     'https://agent.zetdc.co.zw/omsmobile/listing_pending_jobs.php?ecnumber=$ecnumber');

  // if (response.statusCode == 200) {
  //   // If the server did return a 200 OK response,
  //   // then parse the JSON.
  //   var serviceOrders = UnassignedOrders();
  //   //print(response.body);
  //   // print(serviceOrders.toOrderList(response.body));
  //   return serviceOrders.toOrderList(json.decode(response.body));
  // } else {
  //   // If the server did not return a 200 OK response,
  //   // then throw an exception.
  //   print(response.statusCode);
  //   return showDialog(
  //     builder: (context) {
  //       return AlertDialog(
  //         // Retrieve the text the user has entered by using the
  //         // TextEditingController.
  //         content: Text("No service orders to assign"),
  //       );
  //     }, context: null,
  //   );
  // }
}

String getOrderAddress(adres) {
  if (adres != null) {
    return adres;
  } else {
    return 'No Address';
  }
}

class AssignToPage extends StatefulWidget {
  final String ecnumber;
  AssignToPage({Key key, @required this.ecnumber}) : super(key: key);

  @override
  _AssignToPageState createState() => _AssignToPageState();
}

class _AssignToPageState extends State<AssignToPage> {
  Future<List<UnassignedOrders>> unassignedOrders;

    @override
  void initState() {
    super.initState();
    unassignedOrders = fetchServiceOrders(ecnumber: widget.ecnumber);
  }

  @override
    Widget build(BuildContext context) {
    return FutureBuilder<List<UnassignedOrders>>(
      future: unassignedOrders,
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
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => AssignJobPage(
                                                data: snapshot.data[index])),
                                      );
                                    },
                                    child: ListTile(
                                      leading: Icon(
                                        Icons.build,
                                        size: 30,
                                        color: Colors.red,
                                      ),
                                      title: Text(getOrderAddress(snapshot
                                          .data[index].reference_ELEMENT_ADDRESS)),
                                      subtitle: Text(snapshot
                                          .data[index].network_SERVICE_SUBTYPE),
                                      trailing: Text(
                                          snapshot.data[index].network_SERVICE_NUMBER),
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
  // Widget build(BuildContext context) {
  //   return Container(
  //     child: Scaffold(
  //         appBar: AppBar(
  //           centerTitle: true,
  //           title: Text('Reported faults', textAlign: TextAlign.center),
  //         ),
  //         body: Padding(
  //             padding: EdgeInsets.all(8.0),
  //             child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.center,
  //                 children: <Widget>[
  //                   Card(
  //                     elevation: 10,
                      // 
                      // child: Column(mainAxisSize: MainAxisSize.min, children: <
                      //     Widget>[
                      //   const ListTile(
                      //     leading: Icon(Icons.table_chart, size: 50),
                      //     title: Text("Reported date:   19-11-2020"),
                      //     subtitle: Text("Fault number:  2020-26395"),
                      //     trailing: Text("123rd,  Avenues"),
                      //   ),
                      //   ButtonBar(
                      //     children: <Widget>[
                      //       FlatButton(
                      //         child: const Text('Assign',
                      //             style: TextStyle(color: Colors.green)),
                      //         onPressed: () {
                      //           showDialog(
                      //               context: context,
                      //               builder: (BuildContext context) {
                      //                 return Dialog(
                      //                   shape: RoundedRectangleBorder(
                      //                       borderRadius: BorderRadius.circular(
                      //                           20.0)), //this right here
                      //                   child: Container(
                      //                     height: 200,
                      //                     child: Padding(
                      //                       padding: const EdgeInsets.all(12.0),
                      //                       child: Column(
                      //                         mainAxisAlignment:
                      //                             MainAxisAlignment.center,
                      //                         crossAxisAlignment:
                      //                             CrossAxisAlignment.start,
                      //                         children: [
                      //                           TextField(
                      //                             decoration: InputDecoration(
                      //                                 border: InputBorder.none,
                      //                                 hintText:
                      //                                     'Enter EC Number to assign job'),
                      //                           ),
                      //                           SizedBox(
                      //                             width: 320.0,
                      //                             child: RaisedButton(
                      //                               onPressed: () {
                      //                                 Scaffold.of(context)
                      //                                     .showSnackBar(SnackBar(
                      //                                         content: Text(
                      //                                             'Successfully assigned job')));
                      //                               },
                      //                               child: Text(
                      //                                 "Assign",
                      //                                 style: TextStyle(
                      //                                     color: Colors.white),
                      //                               ),
                      //                               color: Colors.green,
                      //                             ),
                      //                           )
                      //                         ],
                      //                       ),
                      //                     ),
                      //                   ),
                      //                 );
                      //               });
                      //         },
                      //       ),
                      //       FlatButton(
                      //         child: const Text('View more...',
                      //             style: TextStyle(color: Colors.red)),
                      //         onPressed: () {
                      //           Navigator.push(
                      //               context,
                      //               new MaterialPageRoute(
                      //                   builder: (context) => AssignDetails()));
                      //         },
                      //       ),
                      //     ],
                      //   ),
                      // ]),
  //                   ),
  //                 ]))),
  //   );
  // }
}
