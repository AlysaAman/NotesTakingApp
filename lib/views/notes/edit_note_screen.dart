import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:notetakeapp/view_models/note_view_model.dart';

class EditNoteScreen extends StatefulWidget {
  final Map<String, dynamic>? note; // Nullable for new notes

  EditNoteScreen({this.note});

  @override
  _EditNoteScreenState createState() => _EditNoteScreenState();
}

class _EditNoteScreenState extends State<EditNoteScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.note != null) {
      _titleController.text = widget.note!['title'];
      _contentController.text = widget.note!['content'];
    }
  }

  @override
  Widget build(BuildContext context) {
    final noteViewModel = Provider.of<NoteViewModel>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.note == null ? "Add Note" : "Edit Note"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: "Title"),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _contentController,
              decoration: InputDecoration(labelText: "Content"),
              maxLines: 5,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (widget.note == null) {
                  // Add new note
                  noteViewModel.addNote(
                    _titleController.text,
                    _contentController.text,
                  );
                } else {
                  // Update note logic (if required)
                  // Future Implementation: Updating Notes
                }
                Navigator.pop(context);
              },
              child: Text(widget.note == null ? "Save" : "Update"),
            ),
          ],
        ),
      ),
    );
  }
}
