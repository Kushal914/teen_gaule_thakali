// only for test

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:teen_gaule_thakali/person.dart';
import 'package:teen_gaule_thakali/providers/locale_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class TestView extends StatefulWidget {
  const TestView({super.key});

  @override
  State<TestView> createState() => _TestViewState();
}

class _TestViewState extends State<TestView> {List<Person> items = [];
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
        Uri.parse('http://192.168.10.107/teen-gaule-thakali/actions/people_actions.php'),
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: {'action': 'PEOPLE_GET_DATA'},
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        if (jsonData['status'] == 'success') {
          setState(() {
            items = (jsonData['data'] as List)
                .map((item) => Person.fromJson(item))
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

  // Function to launch phone call
  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    } else {
      // Handle the error (e.g., show a snackbar or dialog)
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not launch phone call for $phoneNumber')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final localeProvider = Provider.of<LocaleProvider>(context);
    final isEnglish = localeProvider.locale.languageCode == 'en';

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
              : Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'व्यक्ति सूचि:',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      // Access the key using the index
                      final person = items[index];
                      // final id = person.id;
                      final name = isEnglish ? person.nameEn : person.nameNe;
                      final address = isEnglish ? person.addressEn : person.addressNe;
                      final phoneNumber = person.phoneNo; // Phone number is at index 1
                      return ListTile(
                        title: Text(
                          '$name, $address',
                          style: const TextStyle(color: Colors.black, fontSize: 16),
                        ),
                        onTap: () {
                          _makePhoneCall(phoneNumber);
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