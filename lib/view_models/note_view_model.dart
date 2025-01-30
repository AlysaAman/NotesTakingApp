import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class NoteViewModel extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final Uuid uuid = Uuid(); // UUID for unique note IDs

  List<Map<String, dynamic>> _notes = [];
  List<Map<String, dynamic>> get notes => _notes;

  // ✅ Add a new note
  Future<void> addNote(String title, String content) async {
    if (title.isEmpty || content.isEmpty) return;

    try {
      String noteId = uuid.v4(); // Generate unique ID
      await _firestore.collection('notes').doc(noteId).set({
        'id': noteId,
        'title': title,
        'content': content,
        'timestamp': FieldValue.serverTimestamp(),
      });
      fetchNotes(); // Refresh notes after adding
    } catch (e) {
      print('Error adding note: $e');
    }
  }

  // ✅ Fetch notes from Firestore
  Future<void> fetchNotes() async {
    try {
      QuerySnapshot snapshot =
      await _firestore.collection('notes').orderBy('timestamp', descending: true).get();
      _notes = snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
      notifyListeners();
    } catch (e) {
      print('Error fetching notes: $e');
    }
  }

  // ✅ Delete a note by ID
  Future<void> deleteNote(String noteId) async {
    try {
      await _firestore.collection('notes').doc(noteId).delete();
      fetchNotes(); // Refresh notes after deleting
    } catch (e) {
      print('Error deleting note: $e');
    }
  }
}

