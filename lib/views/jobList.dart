import 'package:flutter/material.dart';

class JobList extends StatelessWidget {
  const JobList({Key? key, required this.source}) : super(key: key);
  final String source;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Job List'),
      ),
      body: Image.network(
        source,
        fit: BoxFit.cover,
      ),
    );
  }
}
