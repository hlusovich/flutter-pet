import 'dart:ui';

import 'package:game_box/core/presentation/entities/locale.entity.dart';

abstract interface class LocalizationEvents {
  const LocalizationEvents();
}

final class LocalizationChange extends LocalizationEvents {
  final LocaleEnum locale;
  const LocalizationChange(this.locale);
}

final class LocalizationSetContextCallback extends LocalizationEvents {
  final VoidCallback?  contextCallback;
  const LocalizationSetContextCallback(this.contextCallback);
}
