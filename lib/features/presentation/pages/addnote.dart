import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notes_app/features/bussiness/entities/note_entity.dart';
import 'package:notes_app/features/presentation/provider/note_provider.dart';
import 'package:notes_app/features/presentation/widgets/snake_bar.dart';
import 'package:provider/provider.dart';

class Addnote extends StatefulWidget {
  final String uid;
  const Addnote({super.key, required this.uid});

  @override
  State<Addnote> createState() => _AddnoteState();
}

class _AddnoteState extends State<Addnote> {
  TextEditingController noteTextController = TextEditingController();
  GlobalKey scaffoldStateKey = GlobalKey();
  bool isDisabled = false;

  @override
  void initState() {
    noteTextController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    noteTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldStateKey,
      appBar: AppBar(
        title: const Text("Note"),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${DateFormat("dd MMM hh:mm a").format(DateTime.now())} | ${noteTextController.text.length} Characters",
              style: TextStyle(
                fontSize: 14,
                color: Colors.black.withValues(alpha: .5),
              ),
            ),
            Expanded(
              child: Scrollbar(
                child: TextFormField(
                  controller: noteTextController,
                  maxLines: null,
                  decoration: const InputDecoration(
                      border: InputBorder.none, hintText: "start typing..."),
                ),
              ),
            ),
            InkWell(
              onTap: isDisabled ? null : _submitNewNote,
              child: Container(
                height: 45,
                width: double.infinity,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: isDisabled
                        ? Colors.deepOrange.withAlpha(100)
                        : Colors.deepOrange,
                    borderRadius: BorderRadius.circular(8)),
                child: const Text(
                  "Save",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _submitNewNote() {
    setState(() {
      isDisabled = true;
    });
    if (noteTextController.text.isEmpty) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(snackBar("type something"));
      setState(() {
        isDisabled = false;
      });
      return;
    }

    Provider.of<NoteProvider>(context, listen: false).addNote(
      NoteEntity(
        uid: widget.uid,
        note: noteTextController.text,
        time: Timestamp.now(),
      ),
    );
    Future.delayed(
      const Duration(seconds: 1),
      () {
        if (mounted) {
          Navigator.pop(context);
        }
      },
    );
  }
}
