import 'package:flutter/material.dart';
import 'package:mine_app/getters.dart';
import 'package:mine_app/src/Games/UserSection/data/models/request/user_model_request.dart';
import 'package:mine_app/src/Games/UserSection/data/repositories/authentication_repository.dart';
import 'package:mine_app/src/shared/widgets/box_text_field.dart';
import 'package:mine_app/src/core/routes.dart';
import 'package:mine_app/src/core/theme/ui_helpers/ui_helpers.dart';
import 'package:mine_app/src/core/utils/validator.dart';

class AuthenticationPage extends StatefulWidget {
  const AuthenticationPage({super.key});

  @override
  State<AuthenticationPage> createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  final TextEditingController _usernameTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Authentication'),
      ),
      body: Center(
        child: UIPadding(
          useHorizontalPadding: true,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BoxTextField(
                label: 'Username',
                hintText: 'Type your username',
                controller: _usernameTextController,
                validatorFunction: Validator.isRequired,
              ),
              const SizedBox(height: 10),
              BoxTextField(
                label: 'Password',
                hintText: 'Type your password',
                controller: _passwordTextController,
                validatorFunction: Validator.isRequired,
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () async => await _validateLogin(),
                child: const Text('Login'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, register),
                child: const Text('Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _validateLogin() async {
    await getIt<AuthenticationRepository>().authenticate(
      UserModelRequest(
        username: _usernameTextController.text,
        password: _passwordTextController.text,
      ),
    ).then((value) {
      if (value) {
        Navigator.pushReplacementNamed(context, home);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Invalid username or password'),
          ),
        );
      }
    });
  }
}
