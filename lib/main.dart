import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teen_gaule_thakali/l10n/l10n.dart';
import 'package:teen_gaule_thakali/providers/locale_provider.dart';
import 'package:teen_gaule_thakali/views/firstpage.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => LocaleProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LocaleProvider>(
      builder: (context, localeProvider, child) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          supportedLocales: L10n.all,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          locale: localeProvider.locale,
          home: const FirstPage(),
        );
      },
    );
  }
}