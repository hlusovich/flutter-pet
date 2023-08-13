import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:pet/shared/selection_dots/selection_dots.dart';

class CustomIntroductionScreen extends StatefulWidget {
  const CustomIntroductionScreen({super.key});

  @override
  State<CustomIntroductionScreen> createState() =>
      _CustomIntroductionScreenState();
}

class _CustomIntroductionScreenState extends State<CustomIntroductionScreen> {
  final _introKey = GlobalKey<IntroductionScreenState>();

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      key: _introKey,
      pages: [
        PageViewModel(
          title: 'Development',
          bodyWidget: Column(
            children: [
              Image.asset('assets/images/output.png'),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SelectionDots(
                    color: Colors.red,
                    activeColor: Colors.purple,
                    count: 7,
                    selectedDotIndex: 2,
                  ),
                ],
              ),
              ElevatedButton(
                  onPressed: () {
                    _introKey.currentState?.next();
                  },
                  child: const Text('Start'))
            ],
          ),
        ),
        PageViewModel(
          title: 'Page Two',
          bodyWidget: Column(
            children: [
              ElevatedButton(
                  onPressed: () {
                    _introKey.currentState?.next();
                  },
                  child: const Text('Next'))
            ],
          ),
        ),
        PageViewModel(
          title: 'Page Three',
          bodyWidget: const Text('That\'s all folks'),
        )
      ],
      showNextButton: false,
      showDoneButton: false,
    );
  }
}
