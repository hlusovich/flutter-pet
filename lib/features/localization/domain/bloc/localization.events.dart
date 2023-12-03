import 'dart:ui';

import 'package:game_box/core/presentation/entities/locale.entity.dart';
import 'package:game_box/features/localization/domain/bloc/localization.bloc.dart';

abstract interface class LocalizationEvents {
  const LocalizationEvents();
}

final class LocalizationChange extends LocalizationEvents {
  final LocaleEnum locale;
  const LocalizationChange(this.locale);
}

final class LocalizationSetContextCallback extends LocalizationEvents {
  final contextCallbackType?  contextCallback;
  const LocalizationSetContextCallback(this.contextCallback);
}
