import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:teen_gaule_thakali/providers/locale_provider.dart';


class ThreeVillage extends StatelessWidget {
  ThreeVillage({super.key});

  final Map<String, List> villageData = {
    '1': ['asset1.jpg', 'विवरण1', 'info1'],
    '2': ['asset2.jpg', 'विवरण2', 'info1'],
    '3': ['asset3.jpg', 'विवरण3', 'info1'],
  };

  @override
  Widget build(BuildContext context) {
    final localeProvider = Provider.of<LocaleProvider>(context);
    final isEnglish = localeProvider.locale.languageCode == 'en';

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.threeVillages),
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
      body: PageView.builder(
        itemCount: villageData.length,
        itemBuilder: (context, index) {
          final villageId = villageData.keys.elementAt(index);
          final villageInfo = villageData[villageId]!;
          final imageAsset = villageInfo[0];
          final description = isEnglish ? villageInfo[2] : villageInfo[1];

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/$imageAsset', // Assumes images are in assets folder
                height: 300,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => const Icon(
                  Icons.broken_image,
                  size: 100,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  description,
                  style: const TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}