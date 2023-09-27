import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DonateScreen extends StatelessWidget {
  const DonateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Donate'),
        automaticallyImplyLeading: false,
      ),
      body: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(50.0),
            child: AppBar(
              bottom: const TabBar(
                indicatorColor: Colors.black,
                tabs: [
                  Tab(
                    text: 'EFT',
                  ),
                  Tab(
                    text: 'APP PAY',
                  ),
                ],
              ),
            ),
          ),
          body: const TabBarView(
            children: [
              EFT(),
              AppPay(),
            ],
          ),
        ),
      ),
    );
  }
}

class EFT extends StatelessWidget {
  const EFT({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "BANK: FNB",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                      const Text(
                        "NAME: Main Account",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                      const Text(
                        "Account Type:Cheque",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                      ListTile(
                          title: const Text(
                            'Account Number: 62574351583',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                          ),
                          tileColor: Colors.grey[300],
                          trailing: const Icon(Icons.book),
                          onTap: () {
                            Clipboard.setData(
                                    const ClipboardData(text: '62574351583'))
                                .then((_) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content:
                                          Text("Account Number: 62574351583")));
                            });
                          }),
                      const Text(
                        "Brand Code: 250655",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "BANK: FNB",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                        const Text(
                          "NAME: Building Account Z",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                        const Text(
                          "Account Type: Money on Call",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                        // const Text("Account Number: 62732340724"),
                        ListTile(
                            title: const Text(
                              'Account Number: 62732340724',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                              ),
                            ),
                            tileColor: Colors.grey[300],
                            trailing: const Icon(Icons.book),
                            onTap: () {
                              Clipboard.setData(
                                      const ClipboardData(text: '62732340724'))
                                  .then((_) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            "Account Number: 62732340724")));
                              });
                            }),
                        const Text(
                          "Brand Code: 25065",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                      ]),
                ),
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "BANK: FNB",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                        const Text(
                          "NAME: Women’s Fellowship",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                        const Text(
                          "Account Type: Cheque",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                        // const Text("Account Number: 62732340576"),
                        ListTile(
                            title: const Text(
                              'Account Number: 62732340576',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                              ),
                            ),
                            tileColor: Colors.grey[300],
                            trailing: const Icon(Icons.book),
                            onTap: () {
                              Clipboard.setData(
                                      const ClipboardData(text: '62732340576'))
                                  .then((_) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            "Account Number: 62732340576")));
                              });
                            }),
                        const Text(
                          "Brand Code: 250655",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                      ]),
                ),
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "BANK: FNB",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                      const Text(
                        "NAME: Men’s Fellowship",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                      const Text(
                        "Account Type: Cheque",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                      // const Text("Account Number: 62732350103"),
                      ListTile(
                          title: const Text(
                            'Account Number: 62732350103',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                          ),
                          tileColor: Colors.grey[300],
                          trailing: const Icon(Icons.book),
                          onTap: () {
                            Clipboard.setData(
                                    const ClipboardData(text: '62732350103'))
                                .then((_) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content:
                                          Text("Account Number: 62732350103")));
                            });
                          }),
                      const Text(
                        "Brand Code: 250655",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "BANK: FNB",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                      const Text(
                        "NAME: Youth Account",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                      const Text(
                        "Account Type: Cheque",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                      // const Text("Account Number: 62732346582"),
                      ListTile(
                          title: const Text(
                            'Account Number: 62732346582',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                          ),
                          tileColor: Colors.grey[300],
                          trailing: const Icon(Icons.book),
                          onTap: () {
                            Clipboard.setData(const ClipboardData(
                              text: '62732346582',
                            )).then((_) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content:
                                          Text("Account Number: 62732346582")));
                            });
                          }),
                      const Text(
                        "Brand Code: 250655",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class AppPay extends StatefulWidget {
  const AppPay({super.key});

  @override
  State<AppPay> createState() => _AppPayState();
}

class _AppPayState extends State<AppPay> {
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
      body: Center(
        child: Center(
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
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla dolor augue, aliquet et diam pellentesque, maximus tincidunt massa. "),
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
                      hintText: 'Amount(R)',
                    ),
                    // The validator receives the text that the user has entered.
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your Amount here!';
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
                    child: const Text('Pay'),
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
