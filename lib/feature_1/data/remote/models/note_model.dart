import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../domain/entities/note_entity.dart';

class NoteModel extends NoteEntity {
  const NoteModel({
    final String? noteId,
    final String? note,
    final Timestamp? time,
    final String? uid,
  }) : super(
          noteId: noteId,
          note: note,
          time: time,
          uid: uid,
        );

  factory NoteModel.fromSnapshot(DocumentSnapshot documentSnapshot) {
    return NoteModel(
      noteId: documentSnapshot.get('noteId'),
      note: documentSnapshot.get('note'),
      time: documentSnapshot.get('time'),
      uid: documentSnapshot.get('uid'),
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      "uid": uid,
      "time": time,
      "note": note,
      "noteId": noteId,
    };
  }
}
