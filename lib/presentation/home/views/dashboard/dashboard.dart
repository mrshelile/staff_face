import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _presentCount = 0;
  int _absentCount = 0;

  final List<Employee> employees = [
    Employee(
        name: 'John Doe',
        attendance: 'Present',
        entryTime: '09:00 AM',
        exitTime: '05:00 PM'),
    Employee(
        name: 'Jane Smith', attendance: 'Absent', entryTime: '', exitTime: ''),
    Employee(
        name: 'Alice Johnson',
        attendance: 'Present',
        entryTime: '09:30 AM',
        exitTime: '05:30 PM'),
    // Add more employees as needed
  ];

  @override
  void initState() {
    super.initState();
    _calculateAttendanceAnalysis();
  }

  void _calculateAttendanceAnalysis() {
    _presentCount =
        employees.where((employee) => employee.attendance == 'Present').length;
    _absentCount =
        employees.where((employee) => employee.attendance == 'Absent').length;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          Text(
            'Attendance Analysis',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildAnalysisCard('Total Present', _presentCount.toString()),
              _buildAnalysisCard('Total Absent', _absentCount.toString()),
              _buildAnalysisCard(
                  'Total Employees', employees.length.toString()),
            ],
          ),
          SizedBox(height: 30),
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
              rows: employees.map((employee) {
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
