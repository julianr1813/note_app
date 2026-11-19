import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:note_app/data/note_model.dart';
import 'package:note_app/providers/note_provider.dart';
class AddNoteScreen extends StatefulWidget {
  final Note? note;

  const AddNoteScreen({super.key, this.note});
  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();

}
class _AddNoteScreenState extends State<AddNoteScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _title;
  late final TextEditingController _description;

  @override
  void initState() {
    super.initState();
    _title = TextEditingController(text: widget.note?.title ?? ' ');
    _description = TextEditingController(text: widget.note?.description ?? ' ');
  }

  @override
  void dispose() {
    _title.dispose();
    _description.dispose();
    super.dispose();
  }

  void _saveNote() async {
    if (_formKey.currentState!.validate()) {
      final note = Note(
        id: widget.note?.id,
        title: _title.text,
        description: _description.text,
      );

      final provider = Provider.of<NoteProvider>(context, listen: false);
      if (widget.note == null){
        await provider.addNote(note);

      } else {
        await provider.updateNote(note);
      }
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _title,
                decoration: InputDecoration(labelText: 'Title')
              ),
              TextFormField(
                controller: _description,
                decoration: InputDecoration(labelText: 'Description')
              ),
              ElevatedButton(
                onPressed: _saveNote,
                child: const Text('Save')
              ),
            ],
          ),
        ),
      ),
    );
  }
}