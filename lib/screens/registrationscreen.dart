import '../services/auth.dart';
import './screens.dart';
import 'package:flutter/material.dart';

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
              const Padding(
                padding: EdgeInsets.only(
                  left: 10,
                  right: 10,
                  top: 80,
                  bottom: 30,
                ),
                child: Column(
                  children: [
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
  bool isLoading = false;
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
                labelText: 'Enter your email',
              ),
              // The validator receives the text that the user has entered.
              validator: (value) {
                if (value == null || value.isEmpty) {
                  final RegExp regex = RegExp(
                      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)| (\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
                  if (!regex.hasMatch(value!)) {
                    return 'Enter a valid email';
                  } else {
                    return null;
                  }
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
                  minimumSize: const Size.fromHeight(50),
                  backgroundColor: Colors.black,
                ),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      isLoading = true;
                    });
                    Authentication()
                        .userRegistration(username, confirmPass)
                        .then((auth) => {
                              setState(() {
                                isLoading = false;
                              }),
                              if (auth.isValid)
                                {
                                  Navigator.of(context).push(
                                      MaterialPageRoute<dynamic>(
                                          builder: (BuildContext context) {
                                    return MainApp(isAdmin: auth.isAdmin);
                                  }))
                                }
                              else
                                {
                                  showDialog<String>(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                      title: const Text('Registration Failed'),
                                      content: Text(auth.message),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context, 'OK'),
                                          child: const Text('OK'),
                                        ),
                                      ],
                                    ),
                                  )
                                },
                            });
                  }
                },
                child: isLoading
                    ? const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Loading...',
                            style: TextStyle(fontSize: 20),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        ],
                      )
                    : const Text('Register'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
