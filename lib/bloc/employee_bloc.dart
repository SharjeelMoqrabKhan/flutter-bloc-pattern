/* 7 steps in bloc application */

//1 import
import 'dart:async';
import 'package:flutter_bloc_pattern/model/employee.dart';

class EmployeeBloc {
  //2 creating list employee
  List<Employee> _employeeList = [
    Employee(1, "Sharjeel", 40000.0),
    Employee(2, "Johua", 30000.0),
    Employee(3, "Alien", 50000.0),
    Employee(4, "Turrner", 450000.0)
  ];

  //3 creating data flow, sink to input data , stream to out data
  final _employeeListStreamController = StreamController<List<Employee>>();
  final _employeeIncrementStreamController = StreamController<Employee>();
  final _employeeDecrementStreamController = StreamController<Employee>();

  //4 getter for IO and increment decrement
  Stream<List<Employee>> get employeeListStream =>
      _employeeListStreamController.stream;
  StreamSink<List<Employee>> get employeeListSink =>
      _employeeListStreamController.sink;
  StreamSink<Employee> get employeeSalaryIncrement =>
      _employeeIncrementStreamController;
  StreamSink<Employee> get employeeSalaryDecrement =>
      _employeeDecrementStreamController;

  //5 Constructor add data and listen to change data
  EmployeeBloc() {
    _employeeListStreamController.add(_employeeList);
    _employeeIncrementStreamController.stream.listen(_incrementSalary);
    _employeeDecrementStreamController.stream.listen(_decrementSalary);
  }

  //6 Core Functions
  _incrementSalary(Employee employee) {
    double salary = employee.salary;
    double increment = salary * 20 / 100;
    _employeeList[employee.id - 1].salary = salary + increment;
    employeeListSink.add(_employeeList);
  }

  _decrementSalary(Employee employee) {
    double salary = employee.salary;
    double decrement = salary * 20 / 100;
    _employeeList[employee.id - 1].salary = salary - decrement;
    employeeListSink.add(_employeeList);
  }

  //7 dispose

  void dispose() {
    _employeeIncrementStreamController.close();
    _employeeDecrementStreamController.close();
  }
}
