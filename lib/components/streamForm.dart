import 'package:flutter/material.dart';
import '../services/streamDB.dart';

const List<String> list = <String>[
  'Sermon',
  'Kids',
];
String dropdownValue = list.first;
class StreamForm extends StatefulWidget {
  const StreamForm({super.key, required this.screen});
  final String screen;
  @override
  State<StreamForm> createState() => _StreamFormState();
}

class _StreamFormState extends State<StreamForm> {
  String url= "";

  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
  }

  _reset(){
    formKey.currentState?.reset();
    url="";
  }

  _saveForm() async{
    if(dropdownValue == 'Sermon'){
      if (formKey.currentState!.validate()) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Adding Sermon Stream URL')),
        );
        await AddToDB().addSermonStream(url).then((stream) =>
        {
          if(stream.isSuccessful){
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Sermon Stream Added")),
            ),
            _reset()
          }
        }
        );
      }
    }
    else{
      if (formKey.currentState!.validate()) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Adding Kids Stream URL')),
        );

        await AddToDB().addKidsStream(url).then((ministry) =>
        {
          if(ministry.isSuccessful){
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Kids Stream Added")),
            ),
            _reset()
          }
        }
        );
      }
    }
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
            Container(
                padding: const EdgeInsets.all(16),
                child: const DropDownButton()),
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
                  hintText: 'Stream url',
                ),
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Stream url here!';
                  } else {
                    url = value;
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