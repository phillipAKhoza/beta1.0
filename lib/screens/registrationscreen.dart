import 'package:flutter/material.dart';
// import 'package:intelli_waste/services/auth.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void _loginpage() {
      Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
    }

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          reverse: true,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                  left: 10,
                  right: 10,
                  top: 80,
                  bottom: 30,
                ),
                child: Column(
                  children: const [
                    Text(
                      'UAFC',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 90),
                    ),
                    Text(
                      'REGISTER',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                    )
                  ],
                ),
              ),
              const RegistrationForm(),
              // Flexible(
              //   child: Padding(
              //     padding: const EdgeInsets.only(
              //       top: 0,
              //       bottom: 20,
              //     ),
              //     child: InkWell(
              //       onTap: _loginpage,
              //       child: const Align(
              //         alignment: Alignment.bottomCenter,
              //         child: Text(
              //           'Back to Login',
              //           style: TextStyle(color: Colors.blue),
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 30,
                  bottom: 10,
                ),
                child: InkWell(
                  onTap: _loginpage,
                  child: const Align(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      'Have an Account? Login',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom))
            ],
          ),
        ),
      ),
    );
  }
}

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({Key? key}) : super(key: key);

  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final _formKey = GlobalKey<FormState>();
  String username = '';
  String pass = '';
  String confirmPass = '';
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.only(
          left: 30,
          right: 30,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Enter your username',
              ),
              // The validator receives the text that the user has entered.
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your Username';
                } else {
                  username = value;
                }
                return null;
              },
            ),
            TextFormField(
              obscureText: true,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Enter your Password',
              ),
              // The validator receives the text that the user has entered.
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter Password';
                } else {
                  pass = value;
                }
                return null;
              },
            ),
            TextFormField(
              obscureText: true,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'confirm your password',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please confirm your password';
                } else if (pass != value) {
                  return 'Password does not match';
                } else {
                  confirmPass = value;
                }
                return null;
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                ),
                onPressed: () {},
                child: const Text('Register'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
