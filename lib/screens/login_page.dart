import 'package:flutter/material.dart';
import './screens.dart';
import '../services/auth.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    void register() {
      Navigator.popAndPushNamed(context, "/register");
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
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
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 90),
                  ),
                  Text(
                    'LOGIN',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  )
                ],
              ),
            ),
            const LoginForm(),
            // Flexible(
            //   child: Padding(
            //     padding: const EdgeInsets.only(
            //       left: 10,
            //       right: 10,
            //       top: 20,
            //       bottom: 50,
            //     ),
            //     child: InkWell(
            //       onTap: _register,
            //       child: const Align(
            //         alignment: Alignment.bottomCenter,
            //         child: Text(
            //           'Dont have an Accout? Signup',
            //           style: TextStyle(color: Colors.blue),
            //         ),
            //       ),
            //     ),
            //   ),
            // )
            Padding(
              padding: const EdgeInsets.only(
                left: 10,
                right: 10,
                top: 30,
                bottom: 10,
              ),
              child: InkWell(
                onTap: register,
                child: const Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    'Dont have an Accout? Signup',
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
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  String username = '';
  String pass = '';
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.only(
          left: 30,
          right: 30,
          bottom: 20,
          top: 0,
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
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    minimumSize: const Size.fromHeight(50)),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      isLoading = true;
                    });
                    Authentication()
                        .signInWithEmaiAndPassword(username, pass)
                        .then((auth) => {
                              setState(() {
                                isLoading = false;
                              }),
                              if (auth.isValid)
                                {
                                  Navigator.of(context).push(
                                      MaterialPageRoute<dynamic>(
                                          builder: (BuildContext context) {
                                    return  MainApp(isAdmin: auth.isAdmin);
                                  }))
                                }
                              else
                                {
                                  showDialog<String>(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                      title: const Text('Login Failed'),
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
                    : const Text('LogIn'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
