import 'package:flutter/material.dart';
import 'package:oms_mobile/ui/home_page/jobs.dart';
import 'package:oms_mobile/ui/home_page/searchImg.dart';

class SearchJobs extends StatefulWidget {
  final String ecnumber;
  SearchJobs({Key key, @required this.ecnumber}) : super(key: key);

  @override
  _SearchJobsState createState() => _SearchJobsState();
}

class _SearchJobsState extends State<SearchJobs> {
  bool seachResult = true;
  String ecnumber;
  @override
  Widget build(BuildContext context) {
    var _ecnumController = new TextEditingController();
    return Container(
      child: Scaffold(
          body: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 10),
                Padding(
                  padding: EdgeInsets.all(5),
                ),
                Expanded(
                    child: Jobs(
                  ecnumber: widget.ecnumber,
                ))
              ])),
    );
  }
}
