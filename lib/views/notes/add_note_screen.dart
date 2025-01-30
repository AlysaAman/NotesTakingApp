import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:notetakeapp/view_models/note_view_model.dart';


class AddNoteScreen extends StatelessWidget {
  const AddNoteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController titleController = TextEditingController();
    final TextEditingController contentController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('Add Note')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: contentController,
              decoration: const InputDecoration(labelText: 'Content'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (titleController.text.isNotEmpty && contentController.text.isNotEmpty) {
                  await Provider.of<NoteViewModel>(context, listen: false)
                      .addNote(titleController.text, contentController.text);
                  Navigator.pop(context);
                }
              },
              child: const Text('Save Note'),
            ),
          ],
        ),
      ),
    );
  }
}
