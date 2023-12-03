import 'package:flutter/material.dart';
import 'package:game_box/features/introduction-screen/presentation/widgets/introduction.widget.dart';

import 'widgets/introduction_screen_card.widget.dart';

class IntroductionScreen extends StatefulWidget {
  const IntroductionScreen({super.key});

  @override
  State<IntroductionScreen> createState() => _IntroductionScreenState();
}

class _IntroductionScreenState extends State<IntroductionScreen> {
  final _introductionScreenKey = GlobalKey<IntroductionState>();

  void _moveNext() {
    _introductionScreenKey.currentState?.moveToNextPage();
  }

  @override
  Widget build(BuildContext context) {
    return Introduction(
      key: _introductionScreenKey,
      pages: [
        IntroductionScreenCard(
          buttonText: 'Next',
          imgPath: 'assets/images/welcome.png',
          onButtonTap: _moveNext,
        ),
        IntroductionScreenCard(
          buttonText: 'Next',
          imgPath: 'assets/images/welcome2.png',
          onButtonTap: _moveNext,
        ),
        IntroductionScreenCard(
          buttonText: 'Start',
          imgPath: 'assets/images/welcome3.png',
          onButtonTap: _moveNext,
        ),
      ],
    );
  }
}
