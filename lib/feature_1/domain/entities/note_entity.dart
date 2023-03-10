import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class NoteEntity extends Equatable {
  final String? noteId;
  final String? note;
  final Timestamp? time;
  final String? uid;

  const NoteEntity({this.noteId, this.note, this.time, this.uid});

  @override
  // TODO: implement props
  List<Object?> get props => [note, noteId, time, uid];
}
