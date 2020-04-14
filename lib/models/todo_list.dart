import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:victorapp/models/todo.dart';

class TodoList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('tasks').snapshots(),
      builder:
          (BuildContext context, AsyncSnapshot<QuerySnapshot> asyncSnapshot) {
        if (asyncSnapshot.hasError) {
          return Center(
            child: Text("Error: ${asyncSnapshot.error}"),
          );
        }

        switch (asyncSnapshot.connectionState) {
          case ConnectionState.waiting:
            return Center(
              child: CircularProgressIndicator(),
            );
          default:
            asyncSnapshot.data.documents.map((DocumentSnapshot document) {
              var tasks =
                  new Todo(title: document['title'], done: document['done']);

              print(tasks);
            });

            return new ListView(
              children:
                  asyncSnapshot.data.documents.map((DocumentSnapshot document) {
                return new CheckboxListTile(
                    title: new Text(document['title']),
                    value: document['done'],
                    onChanged: (value) {
                      /*setState(() {
                      item.done = value;
                      });
                      }*/
                      // todo: update in firestore
                    });
              }).toList(),
            );
        }
      },
    );
  }
}
