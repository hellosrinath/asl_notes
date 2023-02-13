import 'package:asl_notes/feature_1/domain/repositories/firebase_repository.dart';

class GetCurrentUidUseCase{
  final FirebaseRepository repository;
  GetCurrentUidUseCase({required this.repository});

  Future<String> call()async{
    return repository.getCurrentUId();
  }
}