import 'dart:ui';

import 'package:game_box/core/presentation/entities/locale.entity.dart';
import 'package:game_box/features/localization/domain/bloc/localization.bloc.dart';

final class LocalizationState {
  final LocaleEnum? locale;
  final VoidCallback? contextCallback;

  const LocalizationState({this.locale, this.contextCallback});

  LocalizationState copyWith({
    VoidCallback? contextCallback,
    LocaleEnum? locale,
  }) {
    return LocalizationState(
      contextCallback: contextCallback ?? this.contextCallback,
      locale: locale ?? this.locale,
    );
  }
}
