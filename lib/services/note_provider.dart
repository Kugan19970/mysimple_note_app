import 'package:flutter/cupertino.dart';
import 'package:my_simple_note/models/note_data_model.dart';

import 'database_service.dart';

class NoteProvider extends ChangeNotifier{
  final DatabaseService _databaseService = DatabaseService.instance;

  List<NoteDataModel> _notes = [];

  List<NoteDataModel> get notes => _notes;


  Future<void> addOrUpdateNote(NoteDataModel note) async {
    final data = {
      'id': note.id,
      'title': note.title,
      'content': note.content,
    };
    await _databaseService.insert('note', data);
    print("Added note");
    await fetchNotes(); // Ensure notes are fetched after saving
  }

  Future<void> fetchNotes() async {
    _notes = await _databaseService.getNotes();
    print("Fetched notes");
    notifyListeners();
  }

  Future<void> delete(String id) async {
    await _databaseService.delete('note', id);
    print("Deleted note");
    await fetchNotes(); // Ensure notes are fetched after deleting
  }



}