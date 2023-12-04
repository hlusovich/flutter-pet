
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_box/core/domain/bloc/theme/theme.bloc.dart';
import 'package:game_box/core/presentation/constants/offset.constants.dart';

class IntroductionScreenCard extends StatelessWidget {
  final VoidCallback onButtonTap;
  final String imgPath;
  final String buttonText;
  final Widget? body;

  const IntroductionScreenCard({
    super.key,
    required this.onButtonTap,
    required this.imgPath,
    required this.buttonText,
    this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          children: [
            Container(
              constraints: const BoxConstraints(maxHeight: 400),
              child: Image.asset(
                imgPath,
              ),
            ),
            body ??
                const SizedBox(
                  height: 0,
                ),
            const SizedBox(
              height: OffsetConstants.l,
            ),
          ],
        ),
        Column(
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0),
                ),
                backgroundColor:  context.read<ThemeBloc>().state.theme.buttons,
              ),
              onPressed: onButtonTap,
              child: Text(
                buttonText,
                style: const TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
