import 'package:flutter/material.dart';

class QuotesPage extends StatelessWidget {
  const QuotesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quotes'),
      ),
      body: Center(
        child: Text('Quotes Page'),
      ),
    );
  }
}
