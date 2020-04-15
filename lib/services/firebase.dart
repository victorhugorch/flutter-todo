import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Firebase {
  create(String collection, data) {
    return Firestore.instance.collection(collection).document().setData(data);
  }

  update(String collection, uuid, data) {
    return Firestore.instance
        .collection(collection)
        .document(uuid)
        .updateData(data)
        .catchError((error) {
      print(error);
    });
  }

  delete(String collection, uuid) {
    return Firestore.instance
        .collection(collection)
        .document(uuid)
        .delete()
        .catchError((error) {
      print(error);
    });
  }

  stream(String collection) {
    return Firestore.instance.collection(collection).snapshots();
  }

  signInWithEmailAndPassword(String email, String password) async {
    try {
      final user = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password
      );

      return user;
    } catch (error) {
      print(error.toString());
      return null;
    }
  }
}
