import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

import '../../../strapi_api.dart';

class Employees extends StatefulWidget {
  @override
  State<Employees> createState() => _EmployeesState();
}

class _EmployeesState extends State<Employees> {
  List<Map<String, String>> employees = [];

  Future getEmployees() async {
    employees = [];
    var url = Uri.parse("$server$employee?populate=*");

    // Await the http get response, then decode the json-formatted response.
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var jsonResponse =
          convert.jsonDecode(response.body) as Map<String, dynamic>;

      for (var element in jsonResponse['data']) {
        print(element);
        employees.add({
          "name": element['attributes']['employee_name'],
          "position": element['attributes']['employee_job'],
          "url": server +
              element['attributes']['picture']['data']['attributes']['url']
        });
      }
      // print(employees);
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
    return employees;
  }

  @override
  Widget build(BuildContext context) {
    return  Container(
        padding: const EdgeInsets.only(top: 110, left: 5, right: 5),
        child: FutureBuilder(
          future: getEmployees(),
          builder: (context, snapshot) {
            // print(employees);
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: _crossAxisCount(context),
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
              ),
              itemCount: employees.length,
              itemBuilder: (context, index) {
                if (snapshot.hasError || !snapshot.hasData) {
                  return SizedBox();
                }
                return Expanded(
                  child: Card(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Expanded(
                          child: CircleAvatar(
                            radius: 50,
                            child: Image.network(employees[index]['url']!),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          employees[index]['name']!,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          employees[index]['position']!,
                          style: const TextStyle(
                            fontSize: 10,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
   
    );
  }

  int _crossAxisCount(BuildContext context) {
    // Determine the number of items to display horizontally
    double screenWidth = MediaQuery.of(context).size.width;
    double itemWidth = 150.0; // Width of each item
    int crossAxisCount = (screenWidth / itemWidth).round();
    return crossAxisCount;
  }
}
