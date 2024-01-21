import 'package:flutter/material.dart';
import '../services/messageDB.dart';
import '../services/auth.dart';

const List<String> list = <String>[
  'Prayer',
  'Praise',
  'New Visitor',
  'Salvation',
  'Volunteering',
  'Other'
];

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
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
String dropdownValue = list.first;
class _ChatFormState extends State<ChatForm> {

  String message = '';
  String? userEmail = CurrentUser.getUserEmail();
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    userEmail = CurrentUser.getUserEmail();
  }

  _saveForm() async{
    if (formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Sending Message')),
      );
      await AddToDB().addMessage(userEmail, dropdownValue, message).then((chat) =>
      {
        if(chat.isSuccessful){
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Message Sent.")),
          ),
          _reset()
        }
      }
      );
    }
  }
  _reset(){
    formKey.currentState?.reset();
    message="";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
        automaticallyImplyLeading: false,
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
                  child: const DropDownButton()),
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

class DropDownButton extends StatefulWidget {
  const DropDownButton({super.key});

  @override
  State<DropDownButton> createState() => _DropDownButtonState();
}

class _DropDownButtonState extends State<DropDownButton> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      elevation: 16,
      style: const TextStyle(color: Colors.black54),
      underline: Container(
        height: 3,
        color: Colors.black12,
      ),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
        });
      },
      items: list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
