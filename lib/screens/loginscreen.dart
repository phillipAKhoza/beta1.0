import 'package:flutter/material.dart';
import '../services/auth.dart';
import './screens.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    super.initState();
    if (CurrentUser.getUserUid() != null) {Navigator.popAndPushNamed(context, "/app");}
  }
  @override
  Widget build(BuildContext context) {
    Authentication().userAuth().then((user) => {
          if (user.isLoggedIn) {Navigator.popAndPushNamed(context, "/app")}
        });
    void _register() {
      Navigator.popAndPushNamed(context, "/register");
    }

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Flexible(
              child: Padding(
                padding: EdgeInsets.only(left: 10, right: 10, top: 50),
                child: Column(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    Text(
                      'UAFC',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, height: 1, fontSize: 80),
                    ),
                    Text(
                      'YOUR VIRTUAL HOME',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    )
                  ],
                ),
              ),
            ),
            // ignore: prefer_const_constructors
            const LoginButtonWithUserName(
              text: 'Sign in with Username',
              icon: Icons.person,
              color: Colors.black,
              // loginMethod: AuthService().googleLogin,
            ),
            const Flexible(
              child: LoginButton(
                text: 'Sign in with Google',
                icon: Icons.g_translate,
                color: Colors.blue,
                // loginMethod: AuthService().googleLogin,
              ),
            ),
            InkWell(
              onTap: _register,
              child: const Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  'Dont have an Accout? Signup',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  final Color color;
  final IconData icon;
  final String text;
  // final Function loginMethod;

  const LoginButton({
    Key? key,
    required this.text,
    required this.icon,
    required this.color,
    // required this.loginMethod
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: ElevatedButton.icon(
        icon: Icon(
          icon,
          color: Colors.white,
          size: 20,
        ),
        style: TextButton.styleFrom(
          padding: const EdgeInsets.all(24),
          backgroundColor: color,
        ),
        onPressed: () async{
          await Authentication().signInWithGoogle().then((auth) {

            if (auth.isValid)
            {
              Navigator.of(context).push(
                  MaterialPageRoute<dynamic>(
                      builder: (BuildContext context) {
                        return  const MainApp();
                      }));
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
              );
            }
          });
        },
        label: Text(text, textAlign: TextAlign.center),
      ),
    );
  }
}

class LoginButtonWithUserName extends StatelessWidget {
  final Color color;
  final IconData icon;
  final String text;

  const LoginButtonWithUserName({
    Key? key,
    required this.text,
    required this.icon,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: ElevatedButton.icon(
        icon: Icon(
          icon,
          color: Colors.white,
          size: 20,
        ),
        style: TextButton.styleFrom(
          padding: const EdgeInsets.all(24),
          backgroundColor: color,
        ),
        onPressed: () => {
          Navigator.popAndPushNamed(context, "/login_page"),
          // Navigator.of(context).push(
          //     MaterialPageRoute<dynamic>(
          //         builder: (BuildContext context) {
          //           return  const MainApp();
          //         }))
        },
        label: Text(text, textAlign: TextAlign.center),
      ),
    );
  }
}
