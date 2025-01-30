import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:notetakeapp/view_models/note_view_model.dart';
import 'edit_note_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<NoteViewModel>(context, listen: false).fetchNotes());
  }

  @override
  Widget build(BuildContext context) {
    final noteViewModel = Provider.of<NoteViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Your Notes"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () => noteViewModel.fetchNotes(), // Refresh Notes
          ),
        ],
      ),
      body: noteViewModel.notes.isEmpty
          ? Center(child: Text("No notes available."))
          : ListView.builder(
        itemCount: noteViewModel.notes.length,
        itemBuilder: (context, index) {
          final note = noteViewModel.notes[index];

          return Card(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: ListTile(
              title: Text(note['title'], style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(note['content']),
              trailing: IconButton(
                icon: Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  noteViewModel.deleteNote(note['id']);
                },
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditNoteScreen(note: note),
                  ),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => EditNoteScreen()),
        ),
        child: Icon(Icons.add),
      ),
    );
  }
}
