import 'package:flutter/material.dart';
// import 'package:intelli_waste/services/auth.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    void _register() {
      Navigator.popAndPushNamed(context, "/register");
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
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
                onTap: _register,
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
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                ),
                onPressed: () async {
                  try {
                    // await AuthService().loginUsername(username, pass);
                    if (_formKey.currentState!.validate()) {
                      Navigator.popAndPushNamed(context, "/home");
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Loading')),
                      );
                    }
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(e.toString())),
                    );
                  }
                },
                child: const Text('LogIn'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
