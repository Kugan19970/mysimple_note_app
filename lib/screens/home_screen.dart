import 'package:flutter/material.dart';
import 'package:my_simple_note/models/note_data_model.dart';
import 'package:my_simple_note/screens/note_screen.dart';
import 'package:my_simple_note/widgets/note_card_widget.dart';
import 'package:provider/provider.dart';

import '../services/note_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchTextFieldController =
      TextEditingController();
  String _serachingWord = '';

  @override
  void initState() {
    super.initState();
    Provider.of<NoteProvider>(context, listen: false).fetchNotes();
    _searchTextFieldController.addListener(() {
      setState(() {
        _serachingWord = _searchTextFieldController.text;
      });
    });
  }

  @override
  void dispose() {
    _searchTextFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              TextField(
                controller: _searchTextFieldController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[250],
                  hintText: 'Search',
                  hintStyle: const TextStyle(fontSize: 18),
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(36.0),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: Consumer<NoteProvider>(
                  builder: (context, noteProvider, child) {
                    final filteredNotes = noteProvider.notes.where((note) {
                      return note.title
                          .toLowerCase()
                          .contains(_serachingWord.toLowerCase());
                    }).toList();
                    return ListView.builder(
                      itemCount: filteredNotes.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (_) {
                              return NoteScreen(
                                  noteDataModel: filteredNotes[index]);
                            }));
                          },
                          child: buildNoteCard(context, filteredNotes[index]),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.4),
              spreadRadius: 1,
              blurRadius: 10,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        margin: const EdgeInsets.only(bottom: 30, right: 10),
        child: FloatingActionButton(
          shape: CircleBorder(),
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (_) {
              // move to chart choose screen
              return NoteScreen(
                noteDataModel: NoteDataModel(id: '', content: '', title: ''),
              );
            }));
          },
          child: const Icon(Icons.add, size: 32),
        ),
      ),
    );
  }
}
