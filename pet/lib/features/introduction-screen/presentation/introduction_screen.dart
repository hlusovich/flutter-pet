import 'package:flutter/material.dart';
import 'package:pet/features/introduction-screen/presentation/introduction.dart';
import 'package:pet/features/introduction-screen/presentation/page/introduction_screen_page.dart';

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
        IntroductionScreenPage(
          buttonText: 'Next',
          imgPath: 'assets/images/welcome.png',
          onButtonTap: _moveNext,
        ),
        IntroductionScreenPage(
          buttonText: 'Next',
          imgPath: 'assets/images/welcome2.png',
          onButtonTap: _moveNext,
        ),
        IntroductionScreenPage(
          buttonText: 'Start',
          imgPath: 'assets/images/welcome3.png',
          onButtonTap: _moveNext,
        ),
      ],
    );
  }
}
