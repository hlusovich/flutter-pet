import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';
import 'package:game_box/app_home.dart';
import 'package:game_box/features/tetris/presentation/tetris.widget.dart';
import 'package:game_box/generated/locale_keys.g.dart';
import 'package:game_box/routing/enums/routing.enum.dart';

final Map<String, Widget Function(BuildContext)> routes = {
  RoutingEnum.home.name: (context) => AppHome(title: LocaleKeys.flutter_demo_home_page.tr()),
  RoutingEnum.tetris.name: (context) => const Tetris(),
};