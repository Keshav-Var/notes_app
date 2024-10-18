import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:notes_app/features/bussiness/entities/note_entity.dart';

class NoteModel extends NoteEntity {
  const NoteModel({
    super.note,
    super.noteId,
    super.time,
    super.uid,
  });

  factory NoteModel.fromSnapshot(DocumentSnapshot snapshot) {
    return NoteModel(
      note: snapshot.get('note'),
      noteId: snapshot.get('noteId'),
      uid: snapshot.get('uid'),
      time: snapshot.get('time'),
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      "note": note,
      "noteId": noteId,
      "time": time,
      "uid": uid,
    };
  }
}
