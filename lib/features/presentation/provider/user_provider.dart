import 'package:flutter/material.dart';
import 'package:notes_app/features/bussiness/entities/user_entity.dart';
import 'package:notes_app/features/bussiness/usecases/get_create_current_user.dart';
import 'package:notes_app/features/bussiness/usecases/sign_in_usecase.dart';
import 'package:notes_app/features/bussiness/usecases/sign_up_usecase.dart';

class UserProvider extends ChangeNotifier {
  final SignInUsecase signInUsecase;
  final GetCreateCurrentUserUsecase getCreateCurrentUserUsecase;
  final SignUpUsecase signUpUsecase;

  UserProvider({
    required this.signInUsecase,
    required this.getCreateCurrentUserUsecase,
    required this.signUpUsecase,
  });
  bool _isSuceesul = false;
  bool _hasError = false;
  bool _isLoading = false;
  String? errorMsg;

  bool get isSucessful => _isSuceesul;
  bool get hasError => _hasError;
  bool get isLoading => _isLoading;

  Future<void> submitSignIn({required UserEntity user}) async {
    _isLoading = true;
    try {
      await signInUsecase.call(user);
      _isSuceesul = true;
      _isLoading = false;
    } catch (e) {
      _isSuceesul = false;
      _hasError = true;
      errorMsg = e.toString();
      _isLoading = false;
    }
    notifyListeners();
  }

  Future<void> submitSignUp({required UserEntity user}) async {
    _isLoading = true;
    try {
      await signUpUsecase.call(user);
      _isSuceesul = true;
      _isLoading = false;
    } catch (e) {
      _isSuceesul = false;
      _hasError = true;
      errorMsg = e.toString();
      _isLoading = false;
    }
    notifyListeners();
  }
}
