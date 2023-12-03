import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_box/core/presentation/entities/locale.entity.dart';
import 'package:game_box/features/localization/domain/bloc/localization.events.dart';
import 'package:game_box/features/localization/domain/bloc/localization.state.dart';
import 'package:shared_preferences/shared_preferences.dart';

typedef contextCallbackType = Future<void> Function(Locale val);

class LocalizationBloc extends Bloc<LocalizationEvents, LocalizationState> {
  LocalizationBloc() : super(const LocalizationState()) {
    on<LocalizationChange>(onLocalizationChange);
    on<LocalizationSetContextCallback>(onLocalizationSetContextCallback);
  }

  void onLocalizationChange(LocalizationChange event, Emitter<LocalizationState> emit) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString('locale', event.locale.value);
    _setLocale(event.locale);
    emit(state.copyWith(locale: event.locale));
  }

  void onLocalizationSetContextCallback(LocalizationSetContextCallback event, Emitter<LocalizationState> emit) async {
    emit(state.copyWith(contextCallback: event.contextCallback));
  }

  void _setLocale(LocaleEnum locale) {
    final currentLanguage = state.locale?.value;

    if (currentLanguage != null) {
      state.contextCallback?.call(Locale(currentLanguage));
    }
  }
}
