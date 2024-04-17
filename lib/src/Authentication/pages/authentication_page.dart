import 'package:flutter/material.dart';
import 'package:mine_app/getters.dart';
import 'package:mine_app/src/Games/UserSection/data/models/request/user_model_request.dart';
import 'package:mine_app/src/Games/UserSection/data/models/user_model.dart';
import 'package:mine_app/src/Games/UserSection/data/repositories/authentication_repository.dart';
import 'package:mine_app/src/core/routes.dart';
import 'package:mine_app/src/shared/widgets/box_text_field.dart';
import 'package:mine_app/src/core/theme/ui_helpers/ui_helpers.dart';
import 'package:mine_app/src/core/utils/validators.dart';

class AuthenticationPage extends StatefulWidget {
  const AuthenticationPage({super.key});

  @override
  State<AuthenticationPage> createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _usernameTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();

  bool _rememberUser = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Authentication'),
      ),
      body: Center(
        child: UIPadding(
          useHorizontalPadding: true,
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BoxTextField(
                  label: 'Username',
                  hintText: 'Type your username',
                  controller: _usernameTextController,
                  validatorFunction: Validators.isRequired,
                ),
                SizedBox(height: 10.s),
                BoxTextField(
                  isPassword: true,
                  label: 'Password',
                  hintText: 'Type your password',
                  controller: _passwordTextController,
                  validatorFunction: Validators.isRequired,
                ),
                SizedBox(height: 10.s),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Remember me'),
                    Switch(
                      value: _rememberUser,
                      onChanged: (newValue) => setState(() => _rememberUser = newValue),
                    ),
                  ],
                ),
                SizedBox(height: 10.s),
                ElevatedButton(
                  onPressed: () async => await _validateLogin(),
                  child: const Text('Login'),
                ),
                SizedBox(height: 5.s),
                ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, AppRoutes.register),
                  child: const Text('Register'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _saveUser() async {
    _rememberUser ? await getIt<AuthenticationRepository>().saveUserAuthentication(
      UserModel(
        username: _usernameTextController.text,
        password: _passwordTextController.text,
      ),
    ) : await getIt<AuthenticationRepository>().deleteUserAuthentication();
  }

  Future<void> _validateLogin() async {
    if (_formKey.currentState!.validate()) {
      await _saveUser();

      await getIt<AuthenticationRepository>().authenticate(
        UserModelRequest(
          username: _usernameTextController.text,
          password: _passwordTextController.text,
        ),
    ).then((value) {
      if (value) {
        Navigator.pushReplacementNamed(context, AppRoutes.home);
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
}
