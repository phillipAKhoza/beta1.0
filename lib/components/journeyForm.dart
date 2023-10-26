import 'package:flutter/material.dart';

class JourneyForm extends StatefulWidget {
  const JourneyForm({super.key});

  @override
  State<JourneyForm> createState() => _JourneyFormState();
}

class _JourneyFormState extends State<JourneyForm> {
  // late String _myActivity;
  // late String _myActivityResult;
  String topic= "";
  String scripture="";
  List<String> verses=[];
  List<String> dailyThoughts=[];
  List<String> reflect=[];
  List<String> prayer=[];
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

      body: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
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
                  hintText: 'topic',
                ),
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter topic here!';
                  } else {
                    topic = value;
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
                textAlign: TextAlign.start,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  hintText: 'scripture',
                ),
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter scripture here!';
                  } else {
                    scripture = value;
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
                textAlign: TextAlign.start,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  hintText: 'verses',
                ),
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter address here!';
                  } else {
                    verses = [value];
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                keyboardType: TextInputType.multiline,
                maxLines: 7,
                textAlign: TextAlign.start,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  hintText: 'dailyThoughts',
                ),
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter dailyThoughts here!';
                  } else {
                    dailyThoughts= [value];
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                keyboardType: TextInputType.multiline,
                maxLines: 7,
                textAlign: TextAlign.start,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  hintText: 'reflect',
                ),
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter reflect here!';
                  } else {
                    reflect= [value];
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                keyboardType: TextInputType.multiline,
                maxLines: 7,
                textAlign: TextAlign.start,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  hintText: 'prayer',
                ),
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter prayer here!';
                  } else {
                    prayer= [value];
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
    );
  }
}