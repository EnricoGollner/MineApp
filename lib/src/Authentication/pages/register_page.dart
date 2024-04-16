import 'package:flutter/material.dart';
import 'package:mine_app/getters.dart';
import 'package:mine_app/src/Games/Mine/pages/widgets/box_snack_bar.dart';
import 'package:mine_app/src/Games/UserSection/controller/user_controller.dart';
import 'package:mine_app/src/shared/widgets/box_text_field.dart';
import 'package:mine_app/src/core/routes.dart';
import 'package:mine_app/src/core/theme/ui_helpers/ui_helpers.dart';
import 'package:mine_app/src/core/utils/validators.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _usernameTextController = TextEditingController();

  final TextEditingController _passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: UIPadding(
        useHorizontalPadding: true,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BoxTextField(
                label: 'Username',
                hintText: 'Type your username',
                controller: _usernameTextController,
                validatorFunction: Validators.isRequired,
              ),
              const SizedBox(height: 10),
              BoxTextField(
                label: 'Password',
                hintText: 'Type your password',
                controller: _passwordTextController,
                validatorFunction: Validators.isRequired,
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () async => await _validateRegister(),
                child: const Text('Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _validateRegister() async {
    await getIt<UserController>().registerUser(
      username: _usernameTextController.text,
      password: _passwordTextController.text,
    ).then((errorMessage) {
      errorMessage.isEmpty ? Navigator.popAndPushNamed(context, home) : showSnackBar(context, BoxSnackBar.error(message: errorMessage));
    });
  }
}
