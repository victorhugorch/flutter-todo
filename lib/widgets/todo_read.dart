import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TodoRead extends StatelessWidget {
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
            return new ListView(
              children:
                  asyncSnapshot.data.documents.map((DocumentSnapshot document) {
                    return Dismissible(
                        key: Key(document['title']),
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
                            // todo: remove in firestore
                            //remove(index);
                          }
                        },
                        child: CheckboxListTile(
                            title: Text(document['title']),
                            value: document['done'],
                            onChanged: (value) {
                              /* todo: update in firestore
                              setState(() {
                                item.done = value;
                              });*/
                            }
                        )
                    );
              }).toList(),
            );
        }
      },
    );
  }
}
