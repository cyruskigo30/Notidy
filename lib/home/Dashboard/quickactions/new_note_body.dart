import 'package:flutter/material.dart';
import 'package:notidy/utils/constants/constants.dart';

class NewNoteBody extends StatefulWidget {
  const NewNoteBody({super.key});

  @override
  State<NewNoteBody> createState() => _NewNoteBodyState();
}

class _NewNoteBodyState extends State<NewNoteBody> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(kMediumWidth),
      child: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Text('New Note Form'),
          ],
        ),
      )),
    );
  }
}
