import 'package:flutter/material.dart';
import 'package:oms_mobile/database/DBHelper.dart';
import 'package:http/http.dart';
import 'package:oms_mobile/models/pending_so.dart';
import 'dart:convert';

import 'package:oms_mobile/pages/home.dart';
import 'package:oms_mobile/pages/pending.dart';

Future<List<PendingServiceOrder>> getPendingServiceOrderFromDB() async {
  var dbHelper = DatabaseHelper();
  Future<List<PendingServiceOrder>> orderz = dbHelper.getServiceOrders();
  return orderz;
}

class PendingForm extends StatefulWidget {
  String DateTime;
  final int job_id;
  PendingForm({Key key, @required this.job_id, this.DateTime})
      : super(key: key);

  @override
  _PendingFormState createState() => _PendingFormState();
}

class _PendingFormState extends State<PendingForm> {
  final _formKey = GlobalKey<FormState>();

  DatabaseHelper helper = DatabaseHelper();

  int _status;
  int _cause;
  dynamic _weather;

  List<DropdownMenuItem<int>> statusList = [];
  List<DropdownMenuItem<int>> causeList = [];
  List<DropdownMenuItem<int>> weatherList = [];

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

  List<String> causevaluez = [
    '25350',
    '25351',
    '25352',
    '25353',
    '25354',
    '25355',
    '25356',
    '25357',
    '25358',
    '25359',
    '25360',
    '25361',
    '25362',
    '25363',
    '25364',
    '25365',
    '25366',
    '25367',
    '25368',
    '25369',
    '25370',
    '25371',
    '25372',
    '25373',
    '25374',
    '25375',
    '25376',
    '25377',
    '25378',
    '25379',
    '25380',
    '25381',
    '25382',
    '25383',
    '25384',
    '25385',
    '25386',
    '25387',
    '25388',
    '25389',
    '25390',
    '25391',
    '25392',
    '25393'
  ];

  void loadCauseList() {
    causeList = [];
    causeList.add(new DropdownMenuItem(
      child: new Text('VOLTAGE LEVELS'),
      value: 0,
    ));
    causeList.add(new DropdownMenuItem(
      child: new Text('OTHERS'),
      value: 1,
    ));
    causeList.add(new DropdownMenuItem(
      child: new Text('POWER OUTAGE'),
      value: 2,
    ));
    causeList.add(new DropdownMenuItem(
      child: new Text('DANGEROUS OCCURRENCE'),
      value: 3,
    ));
    causeList.add(new DropdownMenuItem(
      child: new Text('METER FAULT'),
      value: 4,
    ));
    causeList.add(new DropdownMenuItem(
      child: new Text('SINGLE PHASING'),
      value: 5,
    ));
    causeList.add(new DropdownMenuItem(
      child: new Text('HIGH VOLTAGE'),
      value: 6,
    ));
    causeList.add(new DropdownMenuItem(
      child: new Text('LOW VOLTAGE'),
      value: 7,
    ));
    causeList.add(new DropdownMenuItem(
      child: new Text('VOLTAGE FLUCTUATION'),
      value: 8,
    ));
    causeList.add(new DropdownMenuItem(
      child: new Text('VOLTAGE DIP'),
      value: 9,
    ));
    causeList.add(new DropdownMenuItem(
      child: new Text('VOLTAGE SURGE'),
      value: 10,
    ));
    causeList.add(new DropdownMenuItem(
      child: new Text('TREE FALLEN ON LINE'),
      value: 11,
    ));
    causeList.add(new DropdownMenuItem(
      child: new Text('NO POWER'),
      value: 12,
    ));
    causeList.add(new DropdownMenuItem(
      child: new Text('LOAD SHEDDING'),
      value: 13,
    ));
    causeList.add(new DropdownMenuItem(
      child: new Text('BREAKER TRIP'),
      value: 14,
    ));
    causeList.add(new DropdownMenuItem(
      child: new Text('BLOWN FUSE'),
      value: 15,
    ));
    causeList.add(new DropdownMenuItem(
      child: new Text('BROKEN CONDUCTORS'),
      value: 16,
    ));
    causeList.add(new DropdownMenuItem(
      child: new Text('POLES DOWN'),
      value: 17,
    ));
    causeList.add(new DropdownMenuItem(
      child: new Text('LINES DOWN'),
      value: 18,
    ));
    causeList.add(new DropdownMenuItem(
      child: new Text('BROKEN WEATHER DAC'),
      value: 19,
    ));
    causeList.add(new DropdownMenuItem(
      child: new Text('SPARKS ON EQUIPMENT/MATERIAL'),
      value: 20,
    ));
    causeList.add(new DropdownMenuItem(
      child: new Text('POLES DOWN'),
      value: 21,
    ));
    causeList.add(new DropdownMenuItem(
      child: new Text('DANGLING STAY WIRES'),
      value: 22,
    ));
    causeList.add(new DropdownMenuItem(
      child: new Text('SHOCK ON INSTALLATION'),
      value: 23,
    ));
    causeList.add(new DropdownMenuItem(
      child: new Text('EXPOSED CABLE '),
      value: 24,
    ));
    causeList.add(new DropdownMenuItem(
      child: new Text('BURNING EQUIPMENT/MATERIAL'),
      value: 25,
    ));
    causeList.add(new DropdownMenuItem(
      child: new Text('VANDALIZED EQUIPMENT'),
      value: 26,
    ));
    causeList.add(new DropdownMenuItem(
      child: new Text('LOW LYING CONDUCTORS'),
      value: 27,
    ));
    causeList.add(new DropdownMenuItem(
      child: new Text('SHOCKING STAY WIRE'),
      value: 28,
    ));
    causeList.add(new DropdownMenuItem(
      child: new Text('CLASHING CONDUCTORS'),
      value: 29,
    ));
    causeList.add(new DropdownMenuItem(
      child: new Text('LEAKING EQUIPMENT'),
      value: 30,
    ));
    causeList.add(new DropdownMenuItem(
      child: new Text('TOPUP FAILURE'),
      value: 31,
    ));
    causeList.add(new DropdownMenuItem(
      child: new Text('TAMPER MODE'),
      value: 32,
    ));
    causeList.add(new DropdownMenuItem(
      child: new Text('TAMPER MODE'),
      value: 33,
    ));
    causeList.add(new DropdownMenuItem(
      child: new Text('BLANK CIU'),
      value: 34,
    ));
    causeList.add(new DropdownMenuItem(
      child: new Text('STUCK METER'),
      value: 35,
    ));
    causeList.add(new DropdownMenuItem(
      child: new Text('FREE SUPPLY MODE'),
      value: 36,
    ));
    causeList.add(new DropdownMenuItem(
      child: new Text('HIGH CONSUMPTION'),
      value: 37,
    ));
    causeList.add(new DropdownMenuItem(
      child: new Text('METER TRIP'),
      value: 38,
    ));
    causeList.add(new DropdownMenuItem(
      child: new Text('CIU INDICATING ERROR'),
      value: 39,
    ));
    causeList.add(new DropdownMenuItem(
      child: new Text('FAULTY METER'),
      value: 40,
    ));
    causeList.add(new DropdownMenuItem(
      child: new Text('OBJECTS ON LINE'),
      value: 41,
    ));
    causeList.add(new DropdownMenuItem(
      child: new Text('REQUEST FOR TREE CUTTING'),
      value: 42,
    ));
    causeList.add(new DropdownMenuItem(
      child: new Text('ON/OFF '),
      value: 43,
    ));
  }

  void loadWeatherList() {
    weatherList = [];
    weatherList.add(new DropdownMenuItem(
      child: new Text('NORMAL'),
      value: 0,
    ));
    weatherList.add(new DropdownMenuItem(
      child: new Text('RAINY'),
      value: 1,
    ));
    //    weatherList.add(new DropdownMenuItem(
    //   child: new Text('WINDY'),
    //   value: 2,
    // ));
    //    weatherList.add(new DropdownMenuItem(
    //   child: new Text('STORM'),
    //   value: 3,
    // ));
  }

  String fault_IDENTIFICATION;
  String attendance_START;
  String arrival_AT_LOCATION;
  String notes;
  String weather_CONDITION;
  String cause;
  String so_CURRENT_STATUS;

  TextEditingController faultController = TextEditingController();
  TextEditingController attendanceController = TextEditingController();
  TextEditingController arrivalController = TextEditingController();
  TextEditingController notesController = TextEditingController();
  TextEditingController weatherController = TextEditingController();
  TextEditingController causeController = TextEditingController();
  TextEditingController statusController = TextEditingController();

  // _PendingFormState(this.pendingServiceOrder);

  @override
  Widget build(BuildContext context) {
    loadStatusList();
    loadCauseList();
    loadWeatherList();
    return Container(
      alignment: Alignment.center,
      child: FutureBuilder<List<PendingServiceOrder>>(
        future: getPendingServiceOrderFromDB(),
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            if (snapshot.hasData) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 2.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Visibility(
                          visible: true,
                          child: DropdownButton(
                            hint: new Text('Weather Condition'),
                            items: weatherList,
                            value: _weather,
                            onChanged: (value) {
                              setState(() {
                                _weather = value;
                              });
                            },
                            isExpanded: true,
                          )),
                      Visibility(
                          visible: true,
                          child: DropdownButton(
                            hint: new Text('Service Order Cause'),
                            items: causeList,
                            value: _cause,
                            onChanged: (value) {
                              setState(() {
                                _cause = value;
                              });
                            },
                            isExpanded: true,
                          )),
                      Visibility(
                          visible: true,
                          child: DropdownButton(
                            hint: new Text('Service order status'),
                            items: statusList,
                            value: _status,
                            onChanged: (value) {
                              setState(() {
                                _status = value;
                              });
                            },
                            isExpanded: true,
                          )),
                      Visibility(
                        visible: true,
                        child: TextFormField(
                          decoration: InputDecoration(
                              labelText: 'Fault resolution notes'),
                          controller: notesController,
                          onSaved: (value) => notes = value,
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              RaisedButton(
                                onPressed: () {
                                  _formKey.currentState.save();

                                  List<String> weatherz = ['Normal', 'Rainy','Windy','Storm'];

                                  var job = PendingServiceOrder(
                                      job_id: snapshot.data[0].job_id,
                                      weather_CONDITION: weatherz[_weather],
                                      cause: causevaluez[_cause],
                                      so_CURRENT_STATUS: valuez[_status],
                                      notes: notesController.text);

                                  var db = DatabaseHelper();
                                  db.updateServiceInexecution(job);
                                  Navigator.pop(context);

                                  return showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        content: Text("Inexecution data saved"),
                                      );
                                    },
                                  );
                                },
                                child: Text('SAVE'),
                                color: Theme.of(context).primaryColor,
                                textColor: Colors.white,
                                splashColor: Colors.grey,
                              ),
                            ],
                          ))
                    ],
                  ),
                ),
              );
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

  // save data to the database
  void _save() async {}
}
