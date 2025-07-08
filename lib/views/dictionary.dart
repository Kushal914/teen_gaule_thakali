import 'package:flutter/material.dart';
import 'package:teen_gaule_thakali/data/dict_data.dart';
import 'package:teen_gaule_thakali/dict_functions.dart';
import 'package:teen_gaule_thakali/views/word_detail.dart';

class Dictionary extends StatefulWidget {
  @override
  _DictionaryState createState() => _DictionaryState();
}

class _DictionaryState extends State<Dictionary> with SingleTickerProviderStateMixin {
  String _searchQuery = '';
  List<String> _filteredWords = [];
  late TabController _tabController;
  late Map<String, dynamic> _currentDictData;
  final dictNepaliToThakali = sortDict(dictData);
  final dictThakaliToNepali = sortDict(revertDict(dictData));
  

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _currentDictData = dictData;
    _filteredWords = _currentDictData.keys.toList();
    _tabController.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    setState(() {
      _currentDictData = _tabController.index == 0 ? dictNepaliToThakali : dictThakaliToNepali;
      _searchQuery = '';
      _filteredWords = _currentDictData.keys.toList();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _filterWords(String query) {
    setState(() {
      _searchQuery = query;
      if (query.isEmpty) {
        _filteredWords = _currentDictData.keys.toList();
      } else {
        _filteredWords = _currentDictData.keys
            .where((word) => word.toLowerCase().startsWith(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('नेपाली-थकाली शब्दकोश'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(child: Text(
                'नेपाली-थकाली',
                style: TextStyle(fontSize: 18),
              ),),
            Tab(child: Text(
                'थकाली-नेपाली',
                style: TextStyle(fontSize: 18),
              ),),
          ],
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          indicatorColor: Colors.white,
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: _filterWords,
              decoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: Icon(Icons.search),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: Icon(Icons.clear),
                        onPressed: () {
                          _filterWords('');
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'नतिजा:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredWords.length,
              itemBuilder: (context, index) {
                final word = _filteredWords[index];
                final meaning = _currentDictData[word];
                final displayText = meaning is List ? meaning.join(', ') : meaning;
                return ListTile(
                  title: Text(
                    word,
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WordDetail(
                          word: word,
                          dictData: _currentDictData,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}