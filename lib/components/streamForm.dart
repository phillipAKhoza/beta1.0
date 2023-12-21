import 'package:flutter/material.dart';
import '../services/streamDB.dart';

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
    if(widget.screen == 'Stream'){
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

