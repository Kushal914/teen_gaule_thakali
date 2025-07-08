import 'package:flutter/material.dart';

class WordDetail extends StatelessWidget {
  final String word;
  final Map<String, dynamic> dictData;

  const WordDetail({required this.word, required this.dictData, super.key});

  @override
  Widget build(BuildContext context) {
    final meaning = dictData[word];
    final meanings = meaning is List<String>
        ? meaning
        : meaning is String
            ? [meaning, '']
            : ['Meaning not found', 'Meaning not found'];

    return Scaffold(
      appBar: AppBar(
        title: Text('शब्दको अर्थ'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              word,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 10),
            Text(
              meanings[0],
              style: const TextStyle(fontSize: 16),
            ),
            if (meanings[1].isNotEmpty) ...[
              const SizedBox(height: 4),
              Divider(
                color: Colors.black,
              ),
              const SizedBox(height: 4),
              Text(
                meanings[1],
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ],
        ),
      ),
    );
  }
}