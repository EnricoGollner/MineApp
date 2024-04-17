import 'package:flutter/material.dart';
import 'package:mine_app/getters.dart';
import 'package:mine_app/src/Games/UserSection/data/models/request/user_model_request.dart';
import 'package:mine_app/src/Games/UserSection/data/repositories/authentication_repository.dart';
import 'package:mine_app/src/core/errors/failure.dart';

class AuthenticationController extends ChangeNotifier {
  Future<String> authenticate({required String username, required String password}) async {
    String? errorMessage;

    final ({Failure? error, bool? authenticated}) result = await getIt<AuthenticationRepository>().authenticate(
      UserModelRequest(username: username, password: password),
    );
    
    if (result.error != null) {
      errorMessage = result.error!.message;
    }

    return errorMessage ?? '';
  }
  
  Future<String> registerUser({required String username, required String password}) async {
    String? errorMessage;

    final ({Failure? error, bool? registered}) result = await getIt<AuthenticationRepository>().registerUser(username: username, password: password);
    if (result.error != null) {
      errorMessage = result.error!.message;
    }

    return errorMessage ?? '';
  }
}