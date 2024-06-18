import 'package:flutter/material.dart';

class AddEmployee extends StatefulWidget {
  const AddEmployee({super.key});

  @override
  State<AddEmployee> createState() => _AddEmployeeState();
}

class _AddEmployeeState extends State<AddEmployee> {
  final _formKey = GlobalKey<FormState>();
  String _inputValue = '';
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Input Data'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: TextFormField(
            decoration: InputDecoration(
              labelText: 'Enter some data',
            ),
            validator: (value) {
              // if (value.isEmpty) {
              //   return 'Please enter some data';
              // }
              return null;
            },
            onSaved: (value) {
              setState(() {
                // _inputValue = value;
              });
            },
          ),
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Closing the dialog
          },
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            // if (_formKey.currentState.validate()) {
            //   _formKey.currentState.save();
            //   // Do something with the input value
            //   print('Input Value: $_inputValue');
            //   Navigator.of(context).pop(); // Closing the dialog
            // }
          },
          child: Text('Submit'),
        ),
      ],
    );
  }
}
