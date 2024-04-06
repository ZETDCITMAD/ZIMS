
import 'package:flutter/material.dart';
import 'package:oms_mobile/models/unassigned.dart';
import 'package:oms_mobile/pages/assignto/crew_list.dart';


class AssignDetails extends StatefulWidget {
  final UnassignedOrders data;

  AssignDetails({Key key, @required this.data}) : super(key: key);

  @override
  _AssignDetailsState createState() => _AssignDetailsState();
}

class _AssignDetailsState extends State<AssignDetails> {
  static final _formKey = GlobalKey<FormState>();

//pending list controllers
  final controllernetworkServiceNo = new TextEditingController();
  final controllernetworkServiceSubtype = new TextEditingController();
  final controllersituation = new TextEditingController();
  final controllercreationDate = new TextEditingController();
  final controlleraddress = new TextEditingController();
  final controllervoltageLevel = new TextEditingController();
  final controllerhoodLevel = new TextEditingController();
  final controllernodeID = new TextEditingController();

  @protected
  @mustCallSuper
  void didChangeDependencies() {
    controllernetworkServiceNo.text = widget.data.network_SERVICE_NUMBER;
    controllernetworkServiceSubtype.text = widget.data.network_SERVICE_SUBTYPE;
    controllersituation.text = widget.data.situation;
    controllercreationDate.text = widget.data.creation_DATE_INC;
    controlleraddress.text = widget.data.reference_ELEMENT_ADDRESS;
    controllervoltageLevel.text = widget.data.voltage_LEVEL;
    controllerhoodLevel.text = widget.data.hood_LABEL_INC;
    controllernodeID.text = widget.data.node_ID_INC;
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
                    Image.asset('android/assets/landing.png'),
                    TextFormField(
                      autofocus: false,
                      decoration:
                          InputDecoration(labelText: 'Network Service Number'),
                      controller: controllernetworkServiceNo,
                    ),
                    TextFormField(
                      autofocus: false,
                      decoration:
                          InputDecoration(labelText: 'Network Service Subtype'),
                      controller: controllernetworkServiceSubtype,
                    ),
                    TextFormField(
                      autofocus: false,
                      decoration: InputDecoration(labelText: 'Situation'),
                      controller: controllersituation,
                    ),
                    TextFormField(
                      autofocus: false,
                      decoration: InputDecoration(labelText: 'Date Created'),
                      controller: controllercreationDate,
                    ),
                    TextFormField(
                      autofocus: false,
                      decoration: InputDecoration(labelText: 'Fault Address'),
                      controller: controlleraddress,
                    ),
                    TextFormField(
                      autofocus: false,
                      decoration: InputDecoration(labelText: 'Voltage Level'),
                      controller: controllervoltageLevel,
                    ),
                    TextFormField(
                      autofocus: false,
                      decoration: InputDecoration(labelText: 'Area'),
                      controller: controllerhoodLevel,
                    ),
                                       
                    Padding(
                        padding: EdgeInsets.only(top: 5.0),
                        child: Row(children: <Widget>[
                          Expanded(
                              child: FlatButton(
                                  color: Colors.red,
                                  textColor: Colors.white,
                                  child: Text(
                                    'Cancel',
                                    textScaleFactor: 1.3,
                                  ),
                                  onPressed: () {})),
                          Container(width: 10.0),
                          Expanded(
                              child: FlatButton(
                                  color: Colors.blue[400],
                                  textColor: Colors.white,
                                  child: Text(
                                    'Assign to',
                                    textScaleFactor: 1.3,
                                  ),
                                  onPressed: () {                                  

                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => CrewList(data: widget.data,
                                              //wozoisa node inc kana wapedza
                                               )),
                                      );

                                    //start
                                    // 
                                    // Map<dynamic, dynamic> dataJson = {
                                    //   "exec_order": widget.data.order_ID,
                                    //   "dispatch_date": dateTime,
                                    //   "instance_oper_node":
                                    //       widget.data.node_ID_INC,
                                    //   "resource_id": controllerresourceid
                                    // };

                                    // _updateJob(
                                    //     jobJSON: dataJson, context: context);

                                    // return showDialog(
                                    //     context: context,
                                    //     builder: (context) {
                                    //       return AlertDialog(
                                    //           content: Text(
                                    //               "Job assigned to artisan successfully"));
                                    //     });
                                    //end


                                    // showDialog(
                                    //     context: context,
                                    //     builder: (BuildContext context) {
                                    //       return Dialog(
                                    //         shape: RoundedRectangleBorder(
                                    //             borderRadius:
                                    //                 BorderRadius.circular(
                                    //                     20.0)), //this right here
                                    //         child: Container(
                                    //           height: 200,
                                    //           child: Padding(
                                    //             padding:
                                    //                 const EdgeInsets.all(12.0),
                                    //             child: Column(
                                    //               mainAxisAlignment:
                                    //                   MainAxisAlignment.center,
                                    //               crossAxisAlignment:
                                    //                   CrossAxisAlignment.start,
                                    //               children: [
                                    //                 TextField(
                                    //                   decoration: InputDecoration(
                                    //                       border:
                                    //                           InputBorder.none,
                                    //                       hintText:
                                    //                           'Enter EC Number to assign job'),
                                    //                 ),
                                    //                 SizedBox(
                                    //                   width: 320.0,
                                    //                   child: RaisedButton(
                                    //                     onPressed: () {},
                                    //                     child: Text(
                                    //                       "Assign",
                                    //                       style: TextStyle(
                                    //                           color:
                                    //                               Colors.white),
                                    //                     ),
                                    //                     color: Colors.green,
                                    //                   ),
                                    //                 )
                                    //               ],
                                    //             ),
                                    //           ),
                                    //         ),
                                    //       );
                                    //  });
                                  })),
                        ]))
                  ]))),
    );
  }
}
