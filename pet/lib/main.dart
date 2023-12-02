import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:pet/features/tetris/features/game_field/presentation/game_field.widget.dart';
import 'package:pet/generated/codegen_loader.g.dart';
import 'package:pet/generated/locale_keys.g.dart';

import 'entities/locale.entity.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
        supportedLocales: [
          Locale(LocaleEnum.eng.value),
          Locale(LocaleEnum.ru.value)
        ],
        path: 'assets/translations',
        assetLoader: const CodegenLoader(),
        fallbackLocale: Locale(LocaleEnum.eng.value),
        child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(title: LocaleKeys.flutter_demo_home_page.tr()),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _setLocale() {
    final currentLanguage = context.locale.toLanguageTag();

    if (currentLanguage == LocaleEnum.ru.value) {
      context.setLocale(Locale(LocaleEnum.eng.value));
    } else {
      context.setLocale(Locale(LocaleEnum.ru.value));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: const GameField(width: 10, height: 15,),
    );
  }
}
