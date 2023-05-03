import 'package:flutter/material.dart';

import '../../constant/myColor.dart';

class viewReport extends StatefulWidget {
  String Name;
  String Date;
  String? Winner;
  String? Grade;

  viewReport(
      {Key? key, required this.Date, required this.Name, required this.Winner,required this.Grade})
      : super(key: key);

  @override
  State<viewReport> createState() => _viewReportState();
}

class _viewReportState extends State<viewReport> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Report',
          ),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: tileColors),
            ),
          )),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              child: Container(
                height: 150,
                width: 300,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text('Event Name:${widget.Name}'),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text('Date:${widget.Date}'),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          widget.Winner != ''
                              ? Text('Winner:${widget.Winner}')
                              : Text('No Paricipation found'),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          widget.Grade != ''
                              ? Text('Grade:${widget.Grade}')
                              : Text(''),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
