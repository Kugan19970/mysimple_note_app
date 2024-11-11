import 'package:flutter/material.dart';
import 'package:my_simple_note/models/note_data_model.dart';
import 'package:provider/provider.dart';

import '../services/note_provider.dart';

class NoteScreen extends StatefulWidget {
  final NoteDataModel noteDataModel;

  const NoteScreen({
    super.key,
    required this.noteDataModel,
  });

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _contentController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final noteProvider = Provider.of<NoteProvider>(context, listen: false);

    if (widget.noteDataModel.id.isNotEmpty) {
      _titleController.text = widget.noteDataModel.title;
      _contentController.text = widget.noteDataModel.content;
    }
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
                onPressed: () async {
                  final newNote = NoteDataModel(
                    id: widget.noteDataModel.id.isEmpty
                        ? DateTime.now().toString()
                        : widget.noteDataModel.id,
                    title: _titleController.text,
                    content: _contentController.text,
                  );
                  await noteProvider.addOrUpdateNote(newNote);
                  Navigator.of(context).pop();
                },
                icon: Icon(Icons.save))
          ],
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              TextField(
                controller: _titleController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Title",
                  hintStyle: TextStyle(fontSize: 18, color: Colors.grey[500]),
                ),
              ),
              Expanded(
                child: TextField(
                  controller: _contentController,
                  decoration: InputDecoration(
                    hintText: "Note",
                    border: InputBorder.none,
                    hintStyle: TextStyle(fontSize: 18, color: Colors.grey[500]),
                  ),
                  maxLines: null,
                ),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
