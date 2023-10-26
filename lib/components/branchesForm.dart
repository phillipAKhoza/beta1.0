import 'package:flutter/material.dart';


class BranchesForm extends StatefulWidget {
  const BranchesForm({super.key});

  @override
  State<BranchesForm> createState() => _BranchesFormState();
}

class _BranchesFormState extends State<BranchesForm> {
  // late String _myActivity;
  // late String _myActivityResult;
  String church= "";
  String leaders="";
  String address="";
  List<String> paragraphs=[];
  List<String>? contacts;
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
                  hintText: 'church name',
                ),
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter church name here!';
                  } else {
                    church = value;
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
                  hintText: 'leaders',
                ),
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter leaders of the branch here!';
                  } else {
                    leaders = value;
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
                  hintText: 'address',
                ),
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter address here!';
                  } else {
                    address = value;
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
                  hintText: 'paragraphs',
                ),
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your paragraphs here!';
                  } else {
                    paragraphs.insert(0, value);
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
                  hintText: 'List/Links',
                ),
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your List/Links here!';
                  } else {
                    contacts?.insert(0, value);
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