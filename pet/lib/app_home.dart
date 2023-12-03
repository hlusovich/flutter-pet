import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_box/core/domain/bloc/theme/theme.bloc.dart';
import 'package:game_box/core/domain/bloc/theme/theme.state.dart';
import 'package:game_box/core/presentation/entities/locale.entity.dart';

import 'features/tetris/presentation/tetris.widget.dart';

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
      child: Builder(
        builder: (context) {
          return BlocBuilder<ThemeBloc, ThemeState>(
            builder: (context, state) {
              return Scaffold(
                appBar: AppBar(
                  backgroundColor: state.theme.background,
                  title: Text(widget.title),
                ),
                body: const Tetris(),
              );
            },
          );
        },
      ),
    );
  }
}
