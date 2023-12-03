import 'package:game_box/core/presentation/theme/constants/app_colors_const.dart';
import 'package:game_box/core/presentation/theme/interfaces/app_theme.interface.dart';

final class DarkTheme implements ITheme {
  @override
  final card = AppColors.bgLighter;
  @override
  final background = AppColors.bgDark;
  @override
  final text = AppColors.white;
  @override
  final buttons = AppColors.blue0;
  @override
  final buttonsSplash = AppColorsWithOpacity.blue_50;
}
