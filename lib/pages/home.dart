import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:to_do_app1/data/database.dart';
import 'package:to_do_app1/utill/dialog_box.dart';

import '../utill/todo_tile.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _myBox = Hive.box('myBox');
  ToDoBase db = ToDoBase();
  @override
  void initState() {
    if (_myBox.get('TODOLIST') == null) {
      db.createInitialDate();
    } else {
      db.loadDate();
    }
    super.initState();
  }

  final _controller = TextEditingController();

  void chekBoxingCHanged(bool value, int index) {
    setState(() {
      db.todo[index][1] = !db.todo[index][1];
    });
    db.updateBase();
  }

  void saveNewTask() {
    setState(() {
      db.todo.add([_controller.text, false]);
    });
    Navigator.of(context).pop();
    db.updateBase();
  }

  void creatNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controller,
          OnSave: saveNewTask,
          OnCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  void deleteTask(int index) {
    setState(() {
      db.todo.removeAt(index);
    });
    db.updateBase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: const [
            DrawerHeader(
              decoration:
                  BoxDecoration(color: Color.fromARGB(255, 255, 186, 12)),
              child: Text(
                'Task List',
                style: TextStyle(fontSize: 23, fontWeight: FontWeight.w700),
              ),
            ),
            ListTile(
              title: Text('Settings'),
            ),
            ListTile(
              title: Text('About App'),
            ),
          ],
        ),
      ),
      backgroundColor: const Color(0xFFFFF59D),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 186, 12),
        title: const Center(
          child: Text(
            'To Do App',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
          ),
        ),
        //elevation: ,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          creatNewTask();
        },
        child: const Icon(
          Icons.add,
        ),
      ),
      body: ListView.builder(
        itemCount: db.todo.length,
        itemBuilder: (context, index) {
          return ToDoTile(
            taskName: db.todo[index][0],
            taskComplated: db.todo[index][1],
            onChanged: (value) => chekBoxingCHanged(value!, index),
            deletedFunction: (context) => deleteTask(index),
          );
        },
      ),
    );
  }
}
////////////
