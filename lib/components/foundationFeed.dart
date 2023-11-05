import 'package:flutter/material.dart';
import '../services/feedDb.dart';

class FoundationFeed extends StatefulWidget {
  const FoundationFeed({super.key,required this.screen});
  final String screen;
  @override
  State<FoundationFeed> createState() => _FoundationFeedState();
}

class _FoundationFeedState extends State<FoundationFeed> {
  // late String _myActivity;
  // late String _myActivityResult;
  // final title = TextEditingController();
  String title="";
  String image="";
  String? author;
  String date="";
  List<String> paragraphs=[];
  List<String>? links;

  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
  }
 _reset(){
   formKey.currentState?.reset();
    title="";
    author="";
    date="";
    paragraphs=[];
    links = null;
 }
  _saveForm() async{
    if(widget.screen == 'Feed'){
    if (formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Adding feed')),
      );

        await AddToDB().addFeed(title,image,author,date,paragraphs,links).then((feed) =>
       {
         if(feed.isSuccesful){
           ScaffoldMessenger.of(context).showSnackBar(
             const SnackBar(content: Text("Feed Added")),
          ),
          _reset()
         }
       }
       );
    }
    }
    else if(widget.screen == 'Foundation'){
      if (formKey.currentState!.validate()) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Adding feed')),
        );

        await AddToDB().addFoundation(title,image,author,date,paragraphs,links).then((feed) =>
        {
          if(feed.isSuccesful){
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Feed Added")),
            ),
            _reset()
          }
        }
        );
      }
    }
    else if(widget.screen == 'Notification'){
      if (formKey.currentState!.validate()) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Adding feed')),
        );

        await AddToDB().addNotification(title,image,author,date,paragraphs,links).then((feed) =>
        {
          if(feed.isSuccesful){
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Feed Added")),
            ),
            _reset()
          }
        }
        );
      }
    }
    else if(widget.screen == 'Event'){
      if (formKey.currentState!.validate()) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Adding feed')),
        );

        await AddToDB().addEvent(title,image,author,date,paragraphs,links).then((feed) =>
        {
          if(feed.isSuccesful){
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Feed Added")),
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
                  hintText: 'title',
                ),
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter title here!';
                  } else {
                    title = value;
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
                  hintText: 'Image link',
                ),
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter image link here!';
                  } else {
                    image = value;
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
                  hintText: 'author',
                ),
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter author here!';
                  } else {
                    author = value;
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
                  hintText: 'date',
                ),
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter date here!';
                  } else {
                    date = value;
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
                    // paragraphs.add(value.split(" " "));
                    paragraphs = value.split("'");
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
                  if (value == null) {
                    return 'Please enter your List/Links here!';
                  } else {
                    links = value.split(".");
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