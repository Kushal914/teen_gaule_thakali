import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:teen_gaule_thakali/components/e_museum_card.dart';
import 'package:teen_gaule_thakali/e_museum_item.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:teen_gaule_thakali/providers/locale_provider.dart';

class EMuseumView extends StatefulWidget {
  const EMuseumView({super.key});

  @override
  State<EMuseumView> createState() => _EMuseumViewState();
}

class _EMuseumViewState extends State<EMuseumView> {List<EMuseumItem> items = [];
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
        Uri.parse('http://kushalthapa.thulo.eu.org/teen-gaule-thakali/actions/e_museum_actions.php'),
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
    final localeProvider = Provider.of<LocaleProvider>(context);
    // final isEnglish = localeProvider.locale.languageCode == 'en';

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.eMuseum),
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
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : errorMessage.isNotEmpty
              ? Center(child: Text(errorMessage))
              : GridView.builder(
                  physics: const ScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 2 / 2.8,
                    mainAxisExtent: 250,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return EMuseumCard(id: item.id.toString(), item: item);
                  },
                ),
    );
  }
}