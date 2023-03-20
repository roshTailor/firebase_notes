import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart';

import '../Model/noteModel.dart';
class CloudHelper {
  static CloudHelper instance = CloudHelper();
  CollectionReference notes = FirebaseFirestore.instance.collection('Notes');

  insertData(Note note) async {
    return notes
        .add(note.toMap())
        .then((value) => print("Note Added.."))
        .catchError((error) => print("Failed to add Note: $error"));
  }

  updateData({required int index, required Note noteData}) async {
    var docSnap = await notes.get();
    var doc_id = docSnap.docs;
    return notes
        .doc(doc_id[index].id)
        .update(noteData.toMap())
        .then((value) => print("note Updated.."))
        .catchError((error) => print("Failed to update note: $error"));
  }

  deleteData({required int index}) async {
    var docSnap = await notes.get();
    var doc_id = docSnap.docs;
    return notes
        .doc(doc_id[index].id)
        .delete()
        .then((value) => print("note Deleted.."))
        .catchError((error) => print("Failed to delete note: $error"));
  }
}