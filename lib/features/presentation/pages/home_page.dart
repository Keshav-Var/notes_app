import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notes_app/features/bussiness/entities/note_entity.dart';
import 'package:notes_app/features/presentation/pages/addnote.dart';
import 'package:notes_app/features/presentation/pages/updatenote.dart';
import 'package:notes_app/features/presentation/widgets/delete_pop_up.dart';
import 'package:notes_app/features/presentation/widgets/no_entity_widget.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final List<NoteEntity> note = [
    NoteEntity(
      uid: '2',
      noteId: '11',
      note: "Hello World",
      time: Timestamp.now(),
    ),
    NoteEntity(
      uid: '2',
      noteId: '11',
      note: "Hello World",
      time: Timestamp.now(),
    ),
    NoteEntity(
      uid: '2',
      noteId: '11',
      note: "Hello World",
      time: Timestamp.now(),
    ),
  ];
  final notes = const NoteEntity();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        centerTitle: true,
        title: const Text(
          "Notes",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const Addnote(),
            ),
          );
        },
        backgroundColor: Colors.deepOrange,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: note.isEmpty
          ? const NoEntityWidget()
          : Padding(
              padding: const EdgeInsets.all(8),
              child: GridView.builder(
                itemCount: note.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemBuilder: (context, item) {
                  return GestureDetector(
                    onLongPress: () {
                      dialogBuilder(context);
                    },
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const Updatenote();
                        },
                      ),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withValues(alpha: .2),
                                blurRadius: 2,
                                spreadRadius: 2,
                                offset: const Offset(0, 1.5))
                          ]),
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.all(6),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${note[item].note}",
                            maxLines: 6,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Text(
                            DateFormat("dd MMM yyy hh:mm a").format(
                              note[item].time!.toDate(),
                            ),
                            style: const TextStyle(fontSize: 10),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
