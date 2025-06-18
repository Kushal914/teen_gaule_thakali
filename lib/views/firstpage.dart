import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teen_gaule_thakali/providers/locale_provider.dart';
import 'package:teen_gaule_thakali/views/dictionary.dart';
import 'package:teen_gaule_thakali/views/e_museum_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:teen_gaule_thakali/views/people_info.dart';
import 'package:teen_gaule_thakali/views/test_view.dart';
import 'package:teen_gaule_thakali/views/three_village.dart';


class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    final localeProvider = Provider.of<LocaleProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.firstPage),
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
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: ((context) => EMuseumView())),
                );
              },
              child: Text(AppLocalizations.of(context)!.eMuseum),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: ((context) => Dictionary())),
                );
              },
              child: Text(AppLocalizations.of(context)!.dictionary),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: ((context) => TestView())),
                );
              },
              child: Text('Calendar'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: ((context) => ThreeVillage())),
                );
              },
              child: Text(AppLocalizations.of(context)!.threeVillages),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: ((context) => PeopleInfo())),
                );
              },
              child: Text(AppLocalizations.of(context)!.peopleInfo),
            ),
          ],
        ),
      ),
    );
  }
}