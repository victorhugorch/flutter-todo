import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:victorapp/models/todo_list.dart';

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
      body: new TodoList(),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        child: Icon(Icons.add),
        backgroundColor: Colors.pink,
      ),
    );
  }
}
