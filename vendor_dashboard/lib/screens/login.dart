import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vendor_dashboard/screens/home_screen.dart';
import 'package:vendor_dashboard/utils/styles.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final _auth = FirebaseAuth.instance;
  late String email;
  late String password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InputTextField(
              inputLabel: "Email",
              function: (value) => email = value,
              isPassword: false),
          InputTextField(
              inputLabel: "Password",
              function: (value) => password = value,
              isPassword: true),
          const SizedBox(
            height: 20,
          ),
          ActionButton(
              buttonLabel: "Log In",
              function: () async {
                try {
                  final user = await _auth.signInWithEmailAndPassword(
                      email: email, password: password);
                  if (user != null) {
                    Navigator.pushNamed(context, HomeScreen.route);
                  } else {
                  }
                } catch (e) {
                  print(e);

                }
              }),
        ],
      ),
    );
  }
}

class ActionButton extends StatelessWidget {
  final String buttonLabel;
  final void Function()? function;

  ActionButton({required this.buttonLabel, required this.function});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: function,
      child: Text(buttonLabel),
    );
  }
}

class InputTextField extends StatelessWidget {
  final String inputLabel;
  final Function(String)? function;
  final bool isPassword;

  InputTextField(
      {required this.inputLabel,
      required this.function,
      required this.isPassword});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: function,
      obscureText: isPassword,
      decoration: InputDecoration(
        hintText: inputLabel,
        border: outlineInputBorderStyle
        
      ),
    );
  }
}
