import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:oms_mobile/models/serviceorders.dart';
import 'package:oms_mobile/ui/home_page/viewjob.dart';

Future<List<dynamic>> fetchServiceOrders({ecnumber}) async {
  var serviceOrders = ServiceOrders();
  //to parse parameters into url, formed by curl
  var map = new Map<String,dynamic>();
  map['ecnumber'] = ecnumber;
  final response = await http.post('http://10.0.2.2:8000/api/artisan_get_jobs/$ecnumber');
  // final response = await http.post('http://moms.zetdc.co.zw/zims_artisan_get_jobs.php', body:map);
print(response);
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    var serviceOrders = ServiceOrders();

    return json.decode(response.body);
  } else if (response.contentLength == null){
    // If the server did not return a 200 OK response,
    // then throw an exception.
    return showDialog(
      builder: (context) {
        return AlertDialog(
          // Retrieve the text the user has entered by using the
          // TextEditingController.
          content: Text("No obs Found"),
        );
      },
      context: null,
    );
  }
}

String getOrderAddress(address) {
  if (address != null) {
    return address;
  } else {
    return 'No Address';
  }
}

class Jobs extends StatefulWidget {
  final String ecnumber;
  Jobs({Key key, @required this.ecnumber}) : super(key: key);

  @override
  _JobsState createState() => _JobsState();
}

class _JobsState extends State<Jobs> {
  Future<List<dynamic>> serviceOrders;

  @override
  void initState() {
    super.initState();
    serviceOrders = fetchServiceOrders(ecnumber: widget.ecnumber);
  }

  @override
  Widget build(BuildContext context) {

    return FutureBuilder<List<dynamic>>(
      future: serviceOrders,
      builder: (context, snapshot) {
          if (snapshot.data == null) {
       return AlertDialog(  
        
    content: Text("Awaiting Jobs",  
     textAlign: TextAlign.center,
      style: TextStyle(
                            color: Colors.red,
                          ),
     ),
    actions: [
 
    ]);
          }
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
                                            builder: (context) => ViewJobPage(
                                                data: snapshot.data[index])),
                                      );
                                    },
                                    child: ListTile(
                                      leading: Icon(
                                        Icons.build,
                                        size: 30,
                                        color: Colors.orange,
                                      ),
                                      title:
                                          Text(snapshot.data[index]['address']),
                                      subtitle: Text(snapshot.data[index]
                                          ['out_type_description']),
                                      trailing: Text(snapshot.data[index]
                                              ['job_id']
                                          .toString()),
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
}
