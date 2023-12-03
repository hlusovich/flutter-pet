import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_box/core/presentation/entities/locale.entity.dart';
import 'package:game_box/core/presentation/shared/image_select_item/image_select_item.dart';
import 'package:game_box/features/localization/domain/bloc/localization.bloc.dart';
import 'package:game_box/features/localization/domain/bloc/localization.events.dart';

class LocalizationList extends StatelessWidget {
  final LocaleEnum localization;

  const LocalizationList({super.key, required this.localization});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ImageSelectItem(
          imgPath: 'assets/images/english.png',
          text: 'English',
          isSelected: localization == LocaleEnum.eng,
          onTap: () {
            final localizationBloc = context.read<LocalizationBloc>();
            localizationBloc.add(LocalizationSetContextCallback(() => context.setLocale(Locale(LocaleEnum.eng.value))));
            localizationBloc.add(const LocalizationChange(LocaleEnum.eng));
          },
        ),
        const SizedBox(
          height: 16,
        ),
        ImageSelectItem(
          imgPath: 'assets/images/russia.png',
          text: 'Russian',
          isSelected: localization == LocaleEnum.ru,
          onTap: () {
            final localizationBloc = context.read<LocalizationBloc>();
            localizationBloc.add(LocalizationSetContextCallback(() => context.setLocale(Locale(LocaleEnum.ru.value))));
            localizationBloc.add(const LocalizationChange(LocaleEnum.ru));
          },
        ),
      ],
    );
  }
}
