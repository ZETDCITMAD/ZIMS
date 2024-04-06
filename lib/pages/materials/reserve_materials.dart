import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:oms_mobile/models/materials.dart';
import 'package:http/http.dart' as http;
import 'package:oms_mobile/utils/settings.dart';

class ReserveMaterials extends StatefulWidget {
  final int job_id;
  final Materials materials;
  ReserveMaterials({Key key, @required this.job_id, this.materials})
      : super(key: key);

  @override
  _ReserveMaterialsState createState() => _ReserveMaterialsState();
}

class _ReserveMaterialsState extends State<ReserveMaterials> {
  Future<http.Response> sentMaterialReq({String materialReq}) async {
    URLconfigs urLconfigs;
    urLconfigs = new URLconfigs();
    String url = urLconfigs.getMaterialRequisitionURL();
    final response = await http.post(url, body: materialReq, headers: {
      "accept": "application/json",
      "content-type": "application/json"
    });
    return response;
  }

  Future<void> _stfNumber({BuildContext context, String stfnumber}) {
    showDialog<Null>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return new AlertDialog(
          content: new SingleChildScrollView(
            child: new ListBody(
              children: <Widget>[
                new Text('Your STF Number is $stfnumber'),
              ],
            ),
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  final _formKey = GlobalKey<FormState>();

  TextEditingController resDateController = TextEditingController();
  TextEditingController createdbyController = TextEditingController();
  TextEditingController moveTypeController = TextEditingController();
  TextEditingController materialController = TextEditingController();
  TextEditingController plantController = TextEditingController();
  TextEditingController stgelocController = TextEditingController();
  TextEditingController entryqntController = TextEditingController();
  TextEditingController reqDateController = TextEditingController();
  TextEditingController itemtextController = TextEditingController();

  String resDate;
  String createdby;
  String moveType;
  String material;
  String plant;
  String stgeloc;
  String entryqnt;
  String reqDate;
  String itemtext;

  Materials materials = new Materials();

  DateTime selectedDate = DateTime.now();
  DateTime selectDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    var job_id;
    return Container(
        alignment: Alignment.center,
        child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text('Reserve materials', textAlign: TextAlign.center),
            ),
            body: Padding(
              padding: EdgeInsets.only(top: 15.0, left: 30.0, right: 30.0),
              child: Form(
                key: _formKey,
                child: ListView(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () => _selectDate(context),
                        child: AbsorbPointer(
                          child: TextFormField(
                            decoration: InputDecoration(
                                labelText: 'Reservation Date',
                                hintText: 'Reservation Date'),
                            controller: resDateController,
                            keyboardType: TextInputType.datetime,
                            onSaved: (value) => this.resDate = value,
                          ),
                        ),
                      ),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            labelText: 'Created By', hintText: 'Created By'),
                        controller: createdbyController,
                        onSaved: (value) => this.createdby = value,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            labelText: 'Movement Type',
                            hintText: 'Movement Type'),
                        controller: moveTypeController,
                        onSaved: (value) => this.moveType = value,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            labelText: 'Material', hintText: 'Material'),
                        controller: materialController,
                        onSaved: (value) => this.material = value,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                            labelText: 'Plant', hintText: 'Plant'),
                        controller: plantController,
                        keyboardType: TextInputType.number,
                        onSaved: (value) => this.plant = value,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                            labelText: 'Storage Location',
                            hintText: 'Storage Location'),
                        controller: stgelocController,
                        keyboardType: TextInputType.number,
                        onSaved: (value) => this.stgeloc = value,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                            labelText: 'Quantity', hintText: 'Quantity'),
                        controller: entryqntController,
                        keyboardType: TextInputType.number,
                        onSaved: (value) => this.entryqnt = value,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            labelText: 'Item Text', hintText: 'Item Text'),
                        controller: itemtextController,
                        onSaved: (value) => this.itemtext = value,
                      ),
                      Padding(
                          padding: EdgeInsets.only(top: 20.0),
                          child: Row(children: <Widget>[
                            Expanded(
                              child: RaisedButton(
                                color: Colors.orange,
                                elevation: 3,
                                textColor: Colors.white,
                                child: const Text('Request Materials',
                                    textScaleFactor: 1.3),
                                onPressed: () {
                                  if (_formKey.currentState.validate()) {
                                    _formKey.currentState.save();
                                    Map<String, dynamic> newMaterialReq = {
                                      "ResDate": resDate,
                                      "CreatedBy": createdby,
                                      "MoveType": moveType,
                                      "Material": material,
                                      "Plant": plant,
                                      "StgeLoc": stgeloc,
                                      "ReqDate": resDate,
                                      "ItemText": itemtext,
                                      "entryqnt": entryqnt
                                    };

                                    sentMaterialReq(
                                            materialReq:
                                                json.encode(newMaterialReq))
                                        .then((response) {
                                      if (response.statusCode == 200) {
                                        _stfNumber(
                                            stfnumber: jsonDecode(
                                                response.body)['Reservation'],
                                            context: context);
                                      }
                                    }).catchError((err) {
                                      print(err);
                                    });
                                  }
                                },
                              ),
                            )
                          ])),
                    ]),
              ),
            )));
  }

  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectDate,
        firstDate: DateTime(2021, 5),
        lastDate: DateTime(2100));
    if (picked != null && picked != selectDate) {
      setState(() {
        selectDate = picked;
        var date =
            "${picked.year.toString()}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
        resDateController.text = date;
      });
    }
  }
}
