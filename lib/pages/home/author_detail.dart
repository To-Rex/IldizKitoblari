import 'package:flutter/material.dart';

class AuthorDetail extends StatelessWidget {
  const AuthorDetail({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Theme.of(context).colorScheme.background,
        child: const Center(
          child: Text('AuthorDetail'),
        ),
      ),
    );
  }
}