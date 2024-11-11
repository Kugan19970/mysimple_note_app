import 'package:flutter/material.dart';
import 'package:my_simple_note/models/note_data_model.dart';
import 'package:provider/provider.dart';

import '../services/note_provider.dart';

Widget buildNoteCard(BuildContext context,NoteDataModel note) {
  return Container(
    margin: const EdgeInsets.only(bottom: 15),
    padding: const EdgeInsets.only(top: 10, left: 16, right: 16, bottom: 10),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.grey.withOpacity(0.5)),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.4),
          spreadRadius: 1,
          blurRadius: 10,
          offset: const Offset(0, 10),
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(note.title, style: const TextStyle(fontSize: 18)),
            Text(
              note.content.split(' ').take(4).join(' '),
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
        IconButton(
          icon: Icon(
            Icons.delete,
            color: Colors.grey[500],
          ),
          onPressed: () {
            Provider.of<NoteProvider>(context, listen: false).delete(note.id);

          },
        ),
      ],
    ),
  );
}
