import 'package:asl_notes/feature_1/domain/entities/user_entity.dart';
import 'package:asl_notes/feature_1/domain/repositories/firebase_repository.dart';

class SignUpUseCase{
  final FirebaseRepository repository;
  SignUpUseCase({required this.repository});

  Future<void> call(UserEntity user)async{
    return repository.signUp(user);
  }
}