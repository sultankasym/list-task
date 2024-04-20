import 'package:hive_flutter/hive_flutter.dart';

class ToDoBase {
  List todo = [];
  final _myBox = Hive.box('myBox');

  void createInitialDate() {
    todo = [
      ['Do Exercise', false],
      ['Make Tutorial', false],
    ];
  }

  void loadDate() {
    todo = _myBox.get('T0D0LIST')??[];
  }

  void updateBase() {
    _myBox.put('TODOLIST', todo);
  }
}
