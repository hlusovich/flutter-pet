import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_box/core/domain/bloc/theme/theme.bloc.dart';
import 'package:game_box/core/domain/bloc/theme/theme.events.dart';
import 'package:game_box/core/domain/bloc/theme/theme.state.dart';
import 'package:game_box/core/presentation/constants/icons.constants.dart';
import 'package:game_box/core/presentation/entities/locale.entity.dart';
import 'package:game_box/core/presentation/theme/enums/theme.enum.dart';
import 'package:game_box/features/introduction-screen/presentation/introduction_screen.widget.dart';
import 'package:game_box/features/localization/domain/bloc/localization.bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/presentation/shared/theme_modal/theme_modal.dart';
import 'features/localization/domain/bloc/localization.events.dart';

class AppHome extends StatefulWidget {
  final String title;

  const AppHome({
    required this.title,
    super.key,
  });

  @override
  State<AppHome> createState() => _AppHomeState();
}

class _AppHomeState extends State<AppHome> {
  final themeBlock = ThemeBloc();
  final localeBloc = LocalizationBloc();

  @override
  void initState() {
    super.initState();

    _init();
  }

  Future<void> _init() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final String? storageLocale = sharedPreferences.getString('locale');
    final locale =
        LocaleEnum.values.firstWhere((element) => element.value == storageLocale, orElse: () => LocaleEnum.eng);

    localeBloc.add(LocalizationChange(locale));
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: themeBlock),
        BlocProvider.value(value: localeBloc),
      ],
      child: Builder(
        builder: (context) {
          return BlocBuilder<ThemeBloc, ThemeState>(
            builder: (context, state) {
              return Scaffold(
                appBar: AppBar(
                  backgroundColor: state.theme.background,
                  title: Text(widget.title),
                  actions: [
                    Builder(builder: (context) {
                      return IconButton(
                        onPressed: () {
                          showModalWithSelect(context,
                              values: ThemeEnum.values.map((element) => element.name).toList(),
                              currentValue: themeBlock.theme.name,
                              title: 'Themes', onSelect: (String? value) {
                            if (value != themeBlock.theme.name) {
                              themeBlock.add(const ChangeTheme());
                            }
                            Navigator.of(context).pop();
                          });
                        },
                        icon: const Icon(
                          Icons.settings,
                          size: IconsConstants.l,
                        ),
                      );
                    })
                  ],
                ),
                body: IntroductionScreen(),
              );
            },
          );
        },
      ),
    );
  }
}
