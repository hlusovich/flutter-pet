import 'package:game_box/core/presentation/theme/constants/app_colors_const.dart';
import 'package:game_box/core/presentation/theme/interfaces/app_theme.interface.dart';

class LightTheme implements ITheme {
  @override
  final card = AppColors.white;
  @override
  final background = AppColors.bgLight;
  @override
  final text = AppColors.grayLight;
  @override
  final buttons = AppColors.blue0;
  @override
  final buttonsSplash = AppColorsWithOpacity.blue_50;
}
