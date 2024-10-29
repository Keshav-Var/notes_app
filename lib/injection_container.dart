import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:notes_app/features/bussiness/repositories/firebase_repository.dart';
import 'package:notes_app/features/bussiness/usecases/add_note_usecase.dart';
import 'package:notes_app/features/bussiness/usecases/delete_note_usecase.dart';
import 'package:notes_app/features/bussiness/usecases/get_create_current_user.dart';
import 'package:notes_app/features/bussiness/usecases/get_current_uid.dart';
import 'package:notes_app/features/bussiness/usecases/get_notes_usecase.dart';
import 'package:notes_app/features/bussiness/usecases/is_sign_in_usecase.dart';
import 'package:notes_app/features/bussiness/usecases/sign_in_usecase.dart';
import 'package:notes_app/features/bussiness/usecases/sign_out_usecase.dart';
import 'package:notes_app/features/bussiness/usecases/sign_up_usecase.dart';
import 'package:notes_app/features/bussiness/usecases/update_note_usecase.dart';
import 'package:notes_app/features/data/remote/firebase_remote_data_source.dart';
import 'package:notes_app/features/data/remote/firebase_remote_data_source_impl.dart';
import 'package:notes_app/features/data/repositories/firebase_repository_impl.dart';
import 'package:notes_app/features/presentation/provider/note_provider.dart';
import 'package:notes_app/features/presentation/provider/authentication_provider.dart';
import 'package:notes_app/features/presentation/provider/user_provider.dart';

GetIt sl = GetIt.instance;
Future<void> init() async {
  //provider
  sl.registerFactory<NoteProvider>(
    () => NoteProvider(
      updateNoteUsecase: sl.call(),
      addNoteUseCase: sl.call(),
      deleteNoteUseCase: sl.call(),
      getNotesUsecase: sl.call(),
    ),
  );
  sl.registerFactory<AuthenticationProvider>(
    () => AuthenticationProvider(
      isSignInUsecase: sl.call(),
      getCurrentUid: sl.call(),
      signOutUsecase: sl.call(),
    ),
  );
  sl.registerFactory<UserProvider>(
    () => UserProvider(
      signInUsecase: sl.call(),
      getCreateCurrentUserUsecase: sl.call(),
      signUpUsecase: sl.call(),
    ),
  );

  //useCase
  sl.registerLazySingleton<AddNoteUseCase>(
      () => AddNoteUseCase(repository: sl.call()));
  sl.registerLazySingleton<DeleteNoteUseCase>(
      () => DeleteNoteUseCase(repository: sl.call()));
  sl.registerLazySingleton<GetCreateCurrentUserUsecase>(
      () => GetCreateCurrentUserUsecase(repository: sl.call()));
  sl.registerLazySingleton<GetCurrentUid>(
      () => GetCurrentUid(repository: sl.call()));
  sl.registerLazySingleton<GetNotesUsecase>(
      () => GetNotesUsecase(repository: sl.call()));
  sl.registerLazySingleton<IsSignInUsecase>(
      () => IsSignInUsecase(repository: sl.call()));
  sl.registerLazySingleton<SignInUsecase>(
      () => SignInUsecase(repository: sl.call()));
  sl.registerLazySingleton<SignOutUsecase>(
      () => SignOutUsecase(repository: sl.call()));
  sl.registerLazySingleton<SignUpUsecase>(
      () => SignUpUsecase(repository: sl.call()));
  sl.registerLazySingleton<UpdateNoteUsecase>(
      () => UpdateNoteUsecase(repository: sl.call()));

  //repository
  sl.registerLazySingleton<FirebaseRepository>(
      () => FirebaseRepositoryImpl(remoteDataSource: sl.call()));

  //data source
  sl.registerLazySingleton<FirebaseRemoteDataSource>(() =>
      FirebaseRemoteDataSourceImpl(auth: sl.call(), firestore: sl.call()));

  //External
  final auth = FirebaseAuth.instance;
  final fireStore = FirebaseFirestore.instance;

  sl.registerLazySingleton(() => auth);
  sl.registerLazySingleton(() => fireStore);
}
