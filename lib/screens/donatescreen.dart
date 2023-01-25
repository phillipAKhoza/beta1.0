import 'package:flutter/material.dart';

class DonateScreen extends StatelessWidget {
  const DonateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Donate'),
        automaticallyImplyLeading: false,
      ),
      body: const Center(
        child: Text("Donate Screen"),
      ),
    );
  }
}
