import 'package:flutter/material.dart';
import 'package:teen_gaule_thakali/data/dict_data.dart';

class WordDetail extends StatelessWidget {
  final String word;

  WordDetail({required this.word});

  @override
  Widget build(BuildContext context) {
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
              dictData[word] ?? 'Meaning not found',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}