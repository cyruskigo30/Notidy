import 'package:flutter/material.dart';
import 'package:notidy/home/Dashboard/quickactions/new_note_body.dart';

class NewNoteScreen extends StatelessWidget {
  const NewNoteScreen({super.key});
  static String routeName = '/new_note_screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'New Note',
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: const NewNoteBody(),
    );
  }
}
