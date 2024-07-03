import 'package:flutter/material.dart';

class ErrorView extends StatelessWidget {
  final String? message;

  const ErrorView({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/error.png',
            fit: BoxFit.cover,
            width: 200,
          ),
          Text(
            message ?? "Error",
            style: Theme.of(context).textTheme.bodyMedium,
          )
        ],
      ),
    );
  }
}
