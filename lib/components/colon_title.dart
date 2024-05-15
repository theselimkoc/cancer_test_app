import 'package:flutter/material.dart';

class ColonTitle extends StatelessWidget {
  const ColonTitle({super.key, required this.data});

  final String data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Text(
        data,
        style: Theme.of(context).textTheme.titleMedium,
      ),
    );
  }
}
