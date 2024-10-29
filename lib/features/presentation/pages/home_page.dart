import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notes_app/features/bussiness/entities/note_entity.dart';
import 'package:notes_app/features/presentation/pages/addnote.dart';
import 'package:notes_app/features/presentation/pages/updatenote.dart';
import 'package:notes_app/features/presentation/provider/authentication_provider.dart';
import 'package:notes_app/features/presentation/provider/note_provider.dart';
import 'package:notes_app/features/presentation/widgets/delete_pop_up.dart';
import 'package:notes_app/features/presentation/widgets/no_entity_widget.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   Provider.of<NoteProvider>(context).fetchNotes(widget.uid);
  // }

  @override
  Widget build(BuildContext context) {
    AuthenticationProvider authProvider =
        Provider.of<AuthenticationProvider>(context, listen: false);
    NoteProvider noteProvider =
        Provider.of<NoteProvider>(context, listen: false);

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
        actions: [
          IconButton(
            onPressed: () async {
              await authProvider.signOut();
            },
            icon: const Icon(
              Icons.logout_outlined,
              color: Colors.white,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => Addnote(uid: authProvider.uid!),
            ),
          );
        },
        backgroundColor: Colors.deepOrange,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: FutureBuilder<void>(
        future: noteProvider.fetchNotes(authProvider.uid!),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            // Use StreamBuilder to listen for the notes
            return StreamBuilder<List<NoteEntity>>(
              stream: noteProvider.noteStream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const NoEntityWidget();
                }
                return _bodyWidget(context, snapshot.data!);
              },
            );
          }
        },
      ),
    );
  }

  Widget _bodyWidget(BuildContext context, List<NoteEntity> note) {
    return Padding(
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
              dialogBuilder(context, note[item]);
            },
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return Updatenote(
                    index: item,
                    note: note[item],
                  );
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
                    height: 2,
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
    );
  }
}
