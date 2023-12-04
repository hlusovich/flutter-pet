import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_box/core/domain/bloc/theme/theme.bloc.dart';
import 'package:game_box/core/presentation/constants/offset.constants.dart';
import 'package:game_box/core/presentation/theme/constants/app_colors_const.dart';

class ImageSelectItem extends StatelessWidget {
  final String imgPath;
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  const ImageSelectItem({
    required this.imgPath,
    required this.text,
    required this.isSelected,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: MouseRegion(
        cursor: isSelected ? SystemMouseCursors.basic : SystemMouseCursors.click,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: isSelected ? AppColors.blue0 : Colors.transparent, width: 2),
            color: context.read<ThemeBloc>().state.theme.card,
          ),
          child: Row(
            children: [
              const SizedBox(
                width: OffsetConstants.m + OffsetConstants.s,
                height: OffsetConstants.m + OffsetConstants.l,
              ),
              Container(
                height: 32,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.grey,
                ),
                child: Image.asset(
                  imgPath,
                ),
              ),
              Expanded(
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: context.read<ThemeBloc>().state.theme.text, fontSize: 24),
                ),
              ),
              const SizedBox(
                width: OffsetConstants.m + OffsetConstants.s,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
