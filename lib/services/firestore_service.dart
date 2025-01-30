import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/note.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Create or Update a Note
  Future<void> saveNote(Note note) async {
    await _db.collection("notes").doc(note.id).set(note.toMap());
  }

  // Fetch all notes (Real-time updates)
  Stream<List<Note>> getNotes() {
    return _db.collection("notes").orderBy('createdAt', descending: true).snapshots().map(
          (snapshot) => snapshot.docs.map((doc) => Note.fromMap(doc.data(), doc.id)).toList(),
    );
  }

  // Delete a Note
  Future<void> deleteNote(String noteId) async {
    await _db.collection("notes").doc(noteId).delete();
  }
}

