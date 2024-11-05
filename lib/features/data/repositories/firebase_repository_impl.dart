import 'package:notes_app/features/bussiness/entities/note_entity.dart';
import 'package:notes_app/features/bussiness/entities/user_entity.dart';
import 'package:notes_app/features/bussiness/repositories/firebase_repository.dart';
import 'package:notes_app/features/data/remote/firebase_remote_data_source.dart';

class FirebaseRepositoryImpl implements FirebaseRepository {
  final FirebaseRemoteDataSource remoteDataSource;

  FirebaseRepositoryImpl({required this.remoteDataSource});
  @override
  Future<void> addNote(NoteEntity note) => remoteDataSource.addNote(note);

  @override
  Future<void> deleteNote(NoteEntity note) => remoteDataSource.deleteNote(note);

  @override
  Future<void> getCreateCurrentUser(UserEntity user) =>
      remoteDataSource.getCreateCurrentUser(user);

  @override
  Future<String> getCurrentUid() async =>
      await remoteDataSource.getCurrentUid();

  @override
  Stream<List<NoteEntity>> getNotes(String uid) =>
      remoteDataSource.getNotes(uid);

  @override
  Future<bool> isSignIn() => remoteDataSource.isSignIn();

  @override
  Future<void> signIn(UserEntity user) => remoteDataSource.signIn(user);

  @override
  Future<void> signOut() => remoteDataSource.signOut();

  @override
  Future<void> signUp(UserEntity user) => remoteDataSource.signUp(user);

  @override
  Future<void> updateNote(NoteEntity notes) =>
      remoteDataSource.updateNote(notes);
}
