import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// import 'package:notes_app/features/presentation/widgets/snake_bar.dart';

class Addnote extends StatefulWidget {
  const Addnote({super.key});

  @override
  State<Addnote> createState() => _AddnoteState();
}

class _AddnoteState extends State<Addnote> {
  TextEditingController noteTextController = TextEditingController();
  ScaffoldMessengerState scaffoldStateKey = ScaffoldMessengerState();

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
              onTap: _submitNewNote,
              child: Container(
                height: 45,
                width: double.infinity,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.deepOrange,
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
    // if (noteTextController.text.isEmpty) {
    //   snackBarError(scaffoldState: scaffoldStateKey, msg: "type something");
    //   return;
    // }
    // // BlocProvider.of<NoteCubit>(context).addNote(note: NoteEntity(
    // //   note: _noteTextController.text,
    // //   time: Timestamp.now(),
    // //   uid: widget.uid,
    // // ),);

    // Future.delayed(const Duration(seconds: 1), () {
    //   Navigator.pop(context);
    // });
  }
}
