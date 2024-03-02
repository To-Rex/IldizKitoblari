import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Detail Page',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
          centerTitle: false,
          surfaceTintColor: Colors.transparent,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Theme.of(context).colorScheme.onBackground, size: 20),
            onPressed: () {
              Navigator.pop(context);
            },
          )),
      body: Expanded(
          child: Column(
            children: [
              Text('Detail Page'),
            ],
          )
      ),
    );
  }
}