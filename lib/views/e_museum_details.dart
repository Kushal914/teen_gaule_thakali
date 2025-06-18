import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teen_gaule_thakali/e_museum_item.dart';
import 'package:teen_gaule_thakali/providers/locale_provider.dart';

class EMuseumDetails extends StatefulWidget {
  static const screenId = 'e_museum_details';
  const EMuseumDetails({
    super.key,
    required this.id,
    required this.item,
  });

  final String id;
  final EMuseumItem item;

  @override
  State<EMuseumDetails> createState() => _EMuseumDetailsState();
}

class _EMuseumDetailsState extends State<EMuseumDetails> {
  @override
  Widget build(BuildContext context) {
    final localeProvider = Provider.of<LocaleProvider>(context);
    final isEnglish = localeProvider.locale.languageCode == 'en';
    
    return Scaffold(
      appBar: AppBar(
        title: Text('E-Museum Details'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        actions: [
          Row(
            children: [
              Text(
                'ने',
                style: TextStyle(fontSize: 20),
              ),
              Switch(
                value: localeProvider.locale.languageCode == 'en',
                onChanged: (value) {
                  localeProvider.toggleLocale();
                },
                activeTrackColor: Colors.white70,
                activeColor: Colors.white,
                inactiveTrackColor: Colors.grey,
                inactiveThumbColor: Colors.grey[300],
              ),
              Text(
                'EN',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(width: 8),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    height: 450,
                    color: Colors.transparent,
                    child: Center(
                      child: widget.item.photo.isNotEmpty
                          ? Image.asset(
                              'assets/${widget.item.photo}',
                              width: double.infinity,
                              height: 450,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  Icon(Icons.error, size: 100),
                            )
                          : Icon(Icons.image_not_supported, size: 100),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          isEnglish? widget.item.titleEn.toUpperCase() : widget.item.titleNe,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          isEnglish? widget.item.descEn : widget.item.descNe,
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Description',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          widget.item.descEn,
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}