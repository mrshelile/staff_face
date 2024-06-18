import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../../../strapi_api.dart';

class Attendance extends StatefulWidget {
  const Attendance({Key? key}) : super(key: key);

  @override
  State<Attendance> createState() => _AttendanceState();
}

class _AttendanceState extends State<Attendance> {
  int _presentCount = 0;
  int _absentCount = 0;

  List<Employee> attendanceList = [
    // Employee(
    //     name: 'John Doe',
    //     attendance: 'Present',
    //     entryTime: '09:00 AM',
    //     exitTime: '05:00 PM'),
    // Employee(
    //     name: 'Jane Smith', attendance: 'Absent', entryTime: '', exitTime: ''),
    // Employee(
    //     name: 'Alice Johnson',
    //     attendance: 'Present',
    //     entryTime: '09:30 AM',
    //     exitTime: '05:30 PM'),
    // Add more employees as needed
  ];

  @override
  void initState() {
    super.initState();
    _calculateAttendanceAnalysis();
  }

  void _calculateAttendanceAnalysis() {
    _presentCount = attendanceList
        .where((employee) => employee.attendance == 'Present')
        .length;
    _absentCount = attendanceList
        .where((employee) => employee.attendance == 'Absent')
        .length;
  }
   String getDateInFormat(DateTime dateTime, {String format = 'd/M/yyyy hh:mm'}) {
    return DateFormat(format).format(dateTime);
  }
  Future _getAttedance() async {
    attendanceList = [];
    var url = Uri.parse("$server$attendance?populate=*");

    // Await the http get response, then decode the json-formatted response.
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var jsonResponse =
          convert.jsonDecode(response.body) as Map<String, dynamic>;
      for (var element in jsonResponse['data']) {
        var entry = DateTime.parse(element['attributes']['entry']);
        var exit = element['attributes']['exit'] == null
            ? ''
            : DateTime.parse(element['attributes']['entry']).toString();
        

        var now = DateTime.now();
        if (entry.year == now.year &&
            now.month == now.month &&
            entry.day == now.day) {
          attendanceList.add(Employee(
              name: element['attributes']['employee']['data']['attributes']
                  ['employee_name'],
              attendance: "Present",
              entryTime: getDateInFormat(entry),
              exitTime:exit==''?'': getDateInFormat(DateTime.parse(exit))));
        }
        
      }
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getAttedance(),
      builder: (context, snapshot) {
        return Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 80),
              Text(
                'Employee Attendance',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: DataTable(
                  headingRowColor:
                      MaterialStateColor.resolveWith((states) => Colors.blue),
                  columns: [
                    DataColumn(
                        label: Text('Employee',
                            style: TextStyle(color: Colors.white))),
                    DataColumn(
                        label: Text('Attendance',
                            style: TextStyle(color: Colors.white))),
                    DataColumn(
                        label: Text('Entry Time',
                            style: TextStyle(color: Colors.white))),
                    DataColumn(
                        label: Text('Exit Time',
                            style: TextStyle(color: Colors.white))),
                  ],
                  rows: attendanceList.map((employee) {
                    return DataRow(cells: [
                      DataCell(Text(employee.name)),
                      DataCell(Text(employee.attendance)),
                      DataCell(Text(employee.entryTime)),
                      DataCell(Text(employee.exitTime)),
                    ]);
                  }).toList(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAnalysisCard(String title, String value) {
    return Card(
      color: Colors.lightBlue,
      child: Padding(
        padding: EdgeInsets.all(12.0),
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            SizedBox(height: 5),
            Text(
              value,
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

class Employee {
  final String name;
  final String attendance;
  final String entryTime;
  final String exitTime;

  Employee(
      {required this.name,
      required this.attendance,
      required this.entryTime,
      required this.exitTime});
}
