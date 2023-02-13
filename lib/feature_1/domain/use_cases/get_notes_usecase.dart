import 'package:asl_notes/feature_1/domain/entities/note_entity.dart';
import 'package:asl_notes/feature_1/domain/repositories/firebase_repository.dart';

class GetNotesUseCase {
  final FirebaseRepository repository;

  GetNotesUseCase({required this.repository});

  Stream<List<NoteEntity>> call(String uid) {
    return repository.getNotes(uid);
  }
}
