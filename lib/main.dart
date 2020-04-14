import 'package:flutter/material.dart';
import 'package:victorapp/services/firebase.dart';
import 'package:victorapp/widgets/todo_read.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Victor's Todo",
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage() {
    // constructor
  }

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var newTaskController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final todoRead = new TodoRead();

    return Scaffold(
      appBar: AppBar(
        /*leading: Text("menu"),
          title: Text("Victor's Todo"),
          actions: <Widget>[Icon(Icons.add_circle_outline)],*/
        title: TextFormField(
          controller: newTaskController,
          keyboardType: TextInputType.text,
          style: TextStyle(color: Colors.white, fontSize: 18),
          decoration: InputDecoration(
              labelText: "New task",
              labelStyle: TextStyle(color: Colors.white)),
        ),
      ),
      body: todoRead,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (newTaskController.text.isEmpty) return;

          Firebase().create(
              'tasks', {
                "title": newTaskController.text,
                "done": false
              });

          FocusScope.of(context).requestFocus(FocusNode()); // close keyboard
          newTaskController.clear(); // clear input
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.pink,
      ),
    );
  }
}
