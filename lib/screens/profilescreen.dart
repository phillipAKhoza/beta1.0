import 'package:flutter/material.dart';
import '../services/auth.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? userEmail = CurrentUser.getUserEmail();
  String? userUid = CurrentUser.getUserUid();
  late Future<UserResult> authDbCall;
  @override
  void initState() {
    super.initState();
    userEmail = CurrentUser.getUserEmail();
    userUid = CurrentUser.getUserUid();
    authDbCall = Authentication().userAuth();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Profile'),
        automaticallyImplyLeading: false,
      ),
      body: FutureBuilder<UserResult>(
        future: authDbCall, // a previously-obtained Future<String> or null
        builder: (BuildContext context, AsyncSnapshot<UserResult> snapshot) {
          List<Widget> children;
          if (snapshot.hasData) {
            children = <Widget>[
              SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 0, right: 0, top: 10, bottom: 30),
                      child: SizedBox(
                        height: 150,
                        child: Card(
                          child: Center(
                            child: ListTile(
                              leading: const FlutterLogo(size: 82.0),
                              title: Text(
                                userEmail!,
                                style: const TextStyle(
                                  fontSize: 25.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 450, child: PersonalInfoForm())
                  ],
                ),
              ),
            ];
          } else if (snapshot.hasError) {
            children = <Widget>[
              const Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 60,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text('Error: ${snapshot.error}'),
              ),
            ];
          } else {
            children = const <Widget>[
              SizedBox(
                width: 60,
                height: 60,
                child: CircularProgressIndicator(),
              ),
              Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text('Awaiting result...'),
              ),
            ];
          }
          return Column(
            children: children,
          );
        },
      ),
      // body:
    );
  }
}

enum Gender { male, female }

class PersonalInformation extends StatefulWidget {
  const PersonalInformation({super.key});

  @override
  State<PersonalInformation> createState() => _PersonalInformationState();
}

class _PersonalInformationState extends State<PersonalInformation> {
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
              child: PersonalInfoForm(),
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

class PersonalInfoForm extends StatefulWidget {
  const PersonalInfoForm({super.key});

  @override
  State<PersonalInfoForm> createState() => _PersonalInfoFormState();
}

class _PersonalInfoFormState extends State<PersonalInfoForm> {
  Gender? _character = Gender.male;
  // late String _myActivity;
  // late String _myActivityResult;
  String displayName = '';
  String name = '';
  String surname = '';
  String age = '';
  int phoneNumber = 0;
  String churchBracnh = "";
  final formKey = GlobalKey<FormState>();
  final TextEditingController _controller = TextEditingController();
  @override
  void initState() {
    super.initState();
    // _myActivity = '';
    // _myActivityResult = '';
    _controller.text =
        ' ${selectedDate.day} - ${selectedDate.month} - ${selectedDate.year}';
  }

  _saveForm() {
    // var form = formKey.currentState;
  }

  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1960, 1),
        lastDate: selectedDate);
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Form(
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
                      hintText: 'Name',
                    ),
                    // The validator receives the text that the user has entered.
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your Name';
                      } else {
                        name = value;
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
                      hintText: 'Surname',
                    ),
                    // The validator receives the text that the user has entered.
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your Surname';
                      } else {
                        surname = value;
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
                  child: InkWell(
                    onTap: () {
                      _selectDate(context);
                    },
                    child: IgnorePointer(
                      child: TextField(
                        // controller: _controller,
                        decoration: InputDecoration(
                          labelText:
                              ' ${selectedDate.day} - ${selectedDate.month} - ${selectedDate.year}',
                          hintText: 'Enter Date of Birth',
                          border: const UnderlineInputBorder(),
                          suffixIcon: const Icon(Icons.calendar_today_outlined),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 16,
                    right: 16,
                    top: 10,
                    bottom: 10,
                  ),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: ListTile(
                          title: const Text('Male'),
                          leading: Radio<Gender>(
                            value: Gender.male,
                            groupValue: _character,
                            onChanged: (Gender? value) {
                              setState(() {
                                _character = value;
                              });
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListTile(
                          title: const Text('Female'),
                          leading: Radio<Gender>(
                            value: Gender.female,
                            groupValue: _character,
                            onChanged: (Gender? value) {
                              setState(() {
                                _character = value;
                              });
                            },
                          ),
                        ),
                      ),
                    ],
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
                    keyboardType: TextInputType.number,

                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      hintText: 'Phone Number',
                    ),
                    // The validator receives the text that the user has entered.
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your Phone Number';
                      } else {
                        phoneNumber = int.parse(value);
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
                    child: const Text('Save'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
