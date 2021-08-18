import 'package:flutter/material.dart';
import 'package:flutter_bloc_pattern/bloc/employee_bloc.dart';
import 'package:flutter_bloc_pattern/model/employee.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final EmployeeBloc _employeeBloc = EmployeeBloc();

  @override
  void dispose() {
    _employeeBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Employee"),
      ),
      body: Container(
        child: StreamBuilder<List<Employee>>(
            stream: _employeeBloc.employeeListStream,
            builder:
                (BuildContext context, AsyncSnapshot<List<Employee>> snapshot) {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 5.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Container(
                            child: Text(
                              ' ${snapshot.data[index].id}',
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                ' ${snapshot.data[index].name}',
                                style: TextStyle(fontSize: 18),
                              ),
                              Text(
                                ' ${snapshot.data[index].salary}',
                                style: TextStyle(fontSize: 15),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          child: IconButton(
                            icon: Icon(Icons.thumb_up),
                            color: Colors.green,
                            onPressed: () {
                              _employeeBloc.employeeSalaryIncrement
                                  .add(snapshot.data[index]);
                            },
                          ),
                        ),
                        Container(
                          child: IconButton(
                            icon: Icon(Icons.thumb_down),
                            color: Colors.red,
                            onPressed: () {
                              _employeeBloc.employeeSalaryDecrement
                                  .add(snapshot.data[index]);
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            }),
      ),
    );
  }
}
