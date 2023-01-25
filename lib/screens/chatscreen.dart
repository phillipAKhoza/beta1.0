import 'package:flutter/material.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const SizedBox(
              height: 500,
              child: ChatForm(),
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

class ChatForm extends StatefulWidget {
  const ChatForm({super.key});

  @override
  State<ChatForm> createState() => _ChatFormState();
}

class _ChatFormState extends State<ChatForm> {
  late String _myActivity;
  late String _myActivityResult;
  String message = '';
  final formKey = new GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    _myActivity = '';
    _myActivityResult = '';
  }

  _saveForm() {
    var form = formKey.currentState;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
      ),
      body: Center(
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(16),
                child: DropDownFormField(
                  titleText: 'Type of Message',
                  hintText: 'Please choose one',
                  value: _myActivity,
                  onSaved: (value) {
                    setState(() {
                      _myActivity = value;
                    });
                  },
                  onChanged: (value) {
                    setState(() {
                      _myActivity = value;
                    });
                  },
                  dataSource: const [
                    {
                      "display": "Prayer",
                      "value": "Prayer",
                    },
                    {
                      "display": "Praise",
                      "value": "Praise",
                    },
                    {
                      "display": "New Visitor",
                      "value": "New Visitor",
                    },
                    {
                      "display": "Salvation",
                      "value": "Salvation",
                    },
                    {
                      "display": "Volunteering",
                      "value": "Volunteering",
                    },
                    {
                      "display": "Dedication",
                      "value": "Dedicatione",
                    },
                    {
                      "display": "Other",
                      "value": "Other",
                    },
                  ],
                  textField: 'display',
                  valueField: 'value',
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
