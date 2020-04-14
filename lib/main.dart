import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'models/todo.dart';

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
  var todos = new List<Todo>();

  HomePage() {
    todos = [];
    todos.add(Todo(title: "Remover estado do app", done: false));
    todos.add(Todo(title: "Colocar appbar no footer", done: false));
    todos.add(Todo(title: "Criar um side menu", done: false));
    todos.add(Todo(title: "Brincar com os texts Style possiveis", done: false));
    todos.add(
        Todo(title: "Adicionar floating button pra criar tarefa", done: false));
    todos.add(Todo(title: "Conectar app com firebase", done: false));
    todos.add(Todo(
        title: "Implementar alerta popup ao clicar em add vazio", done: false));
    todos.add(Todo(title: "Criar uma splash screen ao iniciar", done: true));
  }

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var newTaskController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Widget content = StreamBuilder(
      stream: Firestore.instance.collection('tasks').snapshots(),
      builder: (BuildContext buildContext, AsyncSnapshot asyncSnapshot) {
        if (asyncSnapshot.hasError) {
          return Center(
            child: Text("Error: ${asyncSnapshot.error}"),
          );
        }

        switch (asyncSnapshot.connectionState) {
          case ConnectionState.waiting:
            return Center(
              child: LinearProgressIndicator(),
            );
            break;
          default:
            var todosString = asyncSnapshot.data.toString();
            Map todoMap = jsonDecode(todosString);
            var todo = Todo.fromJson(todoMap);
        
            return CheckboxListTile(
              title: Text(todo.title),
              value: todo.done,
              onChanged: (value) {
                setState(() {
                  todo.done = value;
                });
              }
            );
            break;
        }

      });
    
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
      /*body: Container(
          child: Center(
            child: Text("Olá mundo"),
          ),
        ),*/
      body: ListView.builder(
          itemCount: widget.todos.length,
          itemBuilder: (BuildContext context, int index) {
            final item = widget.todos[index];

            return Dismissible(
                key: Key(item.title),
                background: Container(
                  color: Colors.green.withOpacity(0.2),
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  alignment: AlignmentDirectional.centerStart,
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                  ),
                ),
                secondaryBackground: Container(
                  color: Colors.red.withOpacity(0.2),
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  alignment: AlignmentDirectional.centerEnd,
                  child: Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ),
                onDismissed: (direction) {
                  if (direction == DismissDirection.startToEnd) {
                    return;
                  }

                  if (direction == DismissDirection.endToStart) {
                    remove(index);
                  }
                },
                child: content
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: addTask,
        child: Icon(Icons.add),
        backgroundColor: Colors.pink,
      ),
    );
  }

  void addTask() {
    if (newTaskController.text.isEmpty) return;

    setState(() {
      widget.todos.add(Todo(title: newTaskController.text, done: false));

      newTaskController.clear();
    });
  }

  void remove(int index) {
    setState(() {
      widget.todos.removeAt(index);
    });
  }
}
