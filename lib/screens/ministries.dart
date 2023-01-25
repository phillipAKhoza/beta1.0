import 'package:flutter/material.dart';

class Ministryscreen extends StatelessWidget {
  const Ministryscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Church Ministry'),
        automaticallyImplyLeading: false,
      ),
      body: const Center(
        child: Text("WAITING FOR DATA"),
      ),
    );
  }
}
