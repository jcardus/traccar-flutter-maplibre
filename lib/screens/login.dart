import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../models/user.dart';


class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _Login();
}

class _Login extends State<Login> {
  String username = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Server',
                ),
                onChanged: (value) {
                  context.read<UserModel>().server = value;
                },
                initialValue: context.read<UserModel>().server,
              ),
              const Divider(),
              TextFormField(
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)!.userEmail,
                ),
                onChanged: (value) {
                  setState(() {
                    username = value;
                  });
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)!.userPassword,
                ),
                obscureText: true,
                onChanged: (value) {
                  setState(() {
                    password = value;
                  });
                },
              ),
              const SizedBox(
                height: 24,
              ),
              ElevatedButton(
                onPressed: () {
                  var user = context.read<UserModel>();
                  user.login(username, password).then((result) =>
                  {
                    if (result == 401) {
                      _showDialog(context, AppLocalizations.of(context)!.loginFailed)
                    } else {
                      context.pushReplacement('/')
                    }
                  });
                },
                child: Text(AppLocalizations.of(context)!.loginTitle),
              )
            ],
          ),
        ),
      ),
    );
  }
}

void _showDialog(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: const Text("OK"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
