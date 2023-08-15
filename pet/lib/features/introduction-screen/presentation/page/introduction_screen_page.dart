import 'package:flutter/material.dart';

class IntroductionScreenPage extends StatelessWidget {
  const IntroductionScreenPage({
    super.key,
    required this.onButtonTap,
    required this.imgPath,
    required this.buttonText,
  });

  final VoidCallback onButtonTap;

  final String imgPath;
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          children: [
            const SizedBox(
              height: 64,
            ),
            Image.asset(imgPath),
            const SizedBox(
              height: 32,
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
                backgroundColor: Colors.blue,
              ),
              onPressed: onButtonTap,
              child: Text(
                buttonText,
                style: const TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            const SizedBox(
              height: 125,
            )
          ],
        ),
      ],
    );
  }
}
