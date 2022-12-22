import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_clean_todo/application/todo/todo.dart';
import 'package:flutter_clean_todo/application/todo/todos_service.dart';

class FirebaseTodosService implements TodosService {
  static const todosCollectionName = "todos";
  static const usersCollectionName = "users";
  final FirebaseFirestore _firestore;
  final FirebaseAuth _firebaseAuth;

  FirebaseTodosService(this._firestore, this._firebaseAuth);

  String get uid =>
      _firebaseAuth.currentUser?.uid ??
      (throw Exception("Couldn't get current user id"));

  CollectionReference get _todosCollection => _firestore
      .collection(usersCollectionName)
      .doc(uid)
      .collection(todosCollectionName);

  @override
  Future<void> deleteTodo(String todoId) async {
    await _todosCollection.doc(todoId).delete();
  }

  Todo _todoFromDoc(QueryDocumentSnapshot documentSnapshot) {
    final data = documentSnapshot.data() as Map? ??
        (throw Exception("Invalid document data"));
    return Todo(
        id: documentSnapshot.id,
        createdAt: (data["createdAt"] as Timestamp?)?.toDate(),
        title: data["title"],
        description: data["description"],
        isDone: data["isDone"]);
  }

  @override
  Stream<List<Todo>> listTodos() {
    return _todosCollection
        .orderBy("isDone")
        .orderBy("createdAt", descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map(_todoFromDoc).toList());
  }

  @override
  Future<void> createTodo(
      {required String title, required String description}) async {
    await _todosCollection.doc().set({
      "title": title,
      "description": description,
      "isDone": false,
      "createdAt": FieldValue.serverTimestamp()
    });
  }

  @override
  Future<void> setIsDone({required String todoId, required bool isDone}) async {
    await _todosCollection
        .doc(todoId)
        .set({"isDone": isDone}, SetOptions(merge: true));
  }
}
