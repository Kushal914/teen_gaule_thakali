import 'package:flutter/material.dart';
import 'package:teen_gaule_thakali/data/dict_data.dart';

class TestView extends StatelessWidget {
  final String word;

  const TestView({required this.word, super.key});

  @override
  Widget build(BuildContext context) {
    final meanings = dictData[word] is List<String> 
        ? dictData[word] as List<String> 
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
        ),
      ),
    );
  }
}