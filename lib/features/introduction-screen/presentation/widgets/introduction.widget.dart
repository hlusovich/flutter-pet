import 'dart:math';

import 'package:flutter/material.dart';
import 'package:game_box/core/presentation/shared/selection_dots/selection_dots.dart';

class Introduction extends StatefulWidget {
  static const _defaultBottomHeight = 130.0;
  static const _defaultAnimationDuration = 500;

  final Axis scrollDirection;
  final List<Widget> pages;
  final double bottomHeight;
  final int animationDuration;
  final int? selectedPage;
  final Color dotsColor;
  final Color dotsSelectedColor;

  const Introduction({
    super.key,
    required this.pages,
    this.scrollDirection = Axis.horizontal,
    this.selectedPage,
    this.bottomHeight = _defaultBottomHeight,
    this.dotsColor = Colors.grey,
    this.dotsSelectedColor = Colors.blue,
    this.animationDuration = _defaultAnimationDuration,
  });

  @override
  State<Introduction> createState() => IntroductionState();
}

class IntroductionState extends State<Introduction> {
  int _selectedPage = 0;
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();

    _selectedPage = min(widget.pages.length - 1, (widget.selectedPage ?? 0));
    _pageController = PageController(initialPage: _selectedPage);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _pageSelectHandler(int index) async {
    await _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void _pageSelect(int page) {
    if (_selectedPage != page) {
      setState(
        () {
          _selectedPage = page;
        },
      );
    }
  }

  void moveToNextPage() {
    if (_selectedPage < widget.pages.length - 1) {
      _pageSelectHandler(_selectedPage + 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height - widget.bottomHeight;

    return Column(
      children: [
        SizedBox(
          height: height,
          width: width,
          child: PageView(
            controller: _pageController,
            scrollDirection: widget.scrollDirection,
            onPageChanged: _pageSelect,
            children: widget.pages,
          ),
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SelectionDots(
                selectedDotIndex: _selectedPage,
                count: widget.pages.length,
                color: widget.dotsColor,
                activeColor: widget.dotsSelectedColor,
                onPressed: _pageSelectHandler,
                dotSelectDelayTime: widget.animationDuration,
              ),
            ],
          ),
        )
      ],
    );
  }
}
