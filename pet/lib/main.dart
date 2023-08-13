import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:pet/generated/codegen_loader.g.dart';
import 'package:pet/generated/locale_keys.g.dart';
import 'package:pet/shared/flow_menu/entities/menu_item.entity.dart';
import 'package:pet/shared/flow_menu/enum/flow_menu.enum.dart';

import 'features/introduction-screen/presentation/introduction_screen.dart';
import 'shared/flow_menu/flow_menu.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
        supportedLocales: const [Locale('en'), Locale('ru')],
        path: 'assets/translations',
        assetLoader: const CodegenLoader(),
        fallbackLocale: const Locale('en'),
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
    if (context.locale.toLanguageTag() == 'ru') {
      context.setLocale(const Locale('en'));
    } else {
      context.setLocale(const Locale('ru'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: const CustomIntroductionScreen(),
    );
  }
}
