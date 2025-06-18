// only for test

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EMuseumItem {
  final int id;
  final String photo;
  final String titleNe;
  final String titleEn;
  final String descNe;
  final String descEn;

  EMuseumItem({
    required this.id,
    required this.photo,
    required this.titleNe,
    required this.titleEn,
    required this.descNe,
    required this.descEn,
  });

  factory EMuseumItem.fromJson(Map<String, dynamic> json) {
    return EMuseumItem(
      id: int.parse(json['e_museum_id'].toString()),
      photo: json['e_museum_photo'] ?? '',
      titleNe: json['title_ne'] ?? '',
      titleEn: json['title_en'] ?? '',
      descNe: json['desc_ne'] ?? '',
      descEn: json['desc_en'] ?? '',
    );
  }
}

class EMuseumScreen extends StatefulWidget {
  @override
  _EMuseumScreenState createState() => _EMuseumScreenState();
}

class _EMuseumScreenState extends State<EMuseumScreen> {
  List<EMuseumItem> items = [];
  bool isLoading = false;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    fetchItems();
  }

  Future<void> fetchItems() async {
    setState(() {
      isLoading = true;
      errorMessage = '';
    });

    try {
      final response = await http.post(
        Uri.parse('http://192.168.10.107/teen-gaule-thakali/actions/e_museum_actions.php'), // Adjust URL
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: {'action': 'E_MUSEUM_GET_DATA'},
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        if (jsonData['status'] == 'success') {
          setState(() {
            items = (jsonData['data'] as List)
                .map((item) => EMuseumItem.fromJson(item))
                .toList();
            isLoading = false;
          });
        } else {
          setState(() {
            errorMessage = jsonData['message'] ?? 'Failed to load data';
            isLoading = false;
          });
        }
      } else {
        setState(() {
          errorMessage = 'Server error: ${response.statusCode}';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Error: $e';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('E-Museum')),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : errorMessage.isNotEmpty
              ? Center(child: Text(errorMessage))
              : ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return Card(
                      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: ListTile(
                        leading: item.photo.isNotEmpty
                            ? Image.network(
                                item.photo,
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    Icon(Icons.error),
                              )
                            : Icon(Icons.image_not_supported),
                        title: Text(item.titleEn),
                        subtitle: Text(
                          item.descEn,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        onTap: () {
                          // Navigate to a detail screen or show more info
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Tapped: ${item.titleEn}')),
                          );
                        },
                      ),
                    );
                  },
                ),
    );
  }
}