import 'package:flutter/material.dart';

class TechnicalScreen extends StatelessWidget {
  const TechnicalScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const SizedBox(
              height: 700,
              child: TechnicalForm(),
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

class TechnicalForm extends StatefulWidget {
  const TechnicalForm({super.key});

  @override
  State<TechnicalForm> createState() => _TechnicalFormState();
}

class _TechnicalFormState extends State<TechnicalForm> {
  // late String _myActivity;
  // late String _myActivityResult;
  String message = '';
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    // _myActivity = '';
    // _myActivityResult = '';
  }

  _saveForm() {
    // var form = formKey.currentState;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Support'),
      ),
      body: Center(
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: 16,
                  bottom: 10,
                ),
                child: Text(
                    "If you are experiencing any technical challenges with our app, please submit your feedback here. If this is related to your account, please include your name and email address so that we identify you."),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: 10,
                  bottom: 10,
                ),
                child: TextFormField(
                  textAlign: TextAlign.start,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    hintText: 'Email',
                  ),
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your Email here!';
                    } else {
                      message = value;
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: 10,
                  bottom: 10,
                ),
                child: TextFormField(
                  keyboardType: TextInputType.multiline,
                  maxLines: 3,
                  textAlign: TextAlign.start,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    hintText: 'Message',
                  ),
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your Message here!';
                    } else {
                      message = value;
                    }
                    return null;
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                  ),
                  onPressed: _saveForm,
                  child: const Text('Submit'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
