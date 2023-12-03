import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_box/core/domain/bloc/theme/theme.bloc.dart';
import 'package:game_box/core/domain/bloc/theme/theme.state.dart';
import 'package:game_box/core/presentation/entities/locale.entity.dart';
import 'package:game_box/features/tetris/presentation/tetris.widget.dart';
import 'package:game_box/generated/codegen_loader.g.dart';
import 'package:game_box/generated/locale_keys.g.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
        supportedLocales: [Locale(LocaleEnum.eng.value), Locale(LocaleEnum.ru.value)],
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
      home: AppHome(title: LocaleKeys.flutter_demo_home_page.tr()),
    );
  }
}

class AppHome extends StatefulWidget {
  const AppHome({super.key, required this.title});

  final String title;

  @override
  State<AppHome> createState() => _AppHomeState();
}

class _AppHomeState extends State<AppHome> {
  final themeBlock = ThemeBloc();

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
    return BlocProvider.value(
      value: themeBlock,
      child: Builder(builder: (context) {
        return BlocBuilder<ThemeBloc, ThemeState>(builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: state.theme.background,
              title: Text(widget.title),
            ),
            body: const Tetris(),
          );
        });
      }),
    );
  }
}
