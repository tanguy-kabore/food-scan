import 'package:flutter/material.dart';

import '../../../constants/images.dart';
import '../widgets/last_slide_widget.dart';
import '../widgets/slide_widget.dart';

class OnBoardScreen extends StatefulWidget {
  const OnBoardScreen({super.key});

  @override
  OnBoardScreenState createState() => OnBoardScreenState();
}

class OnBoardScreenState extends State<OnBoardScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, dynamic>> slides = [
    {
      'image': Images.onboard1,
      'title': 'Scan product',
      'description': 'Scan the product\'s barcode.',
    },
    {
      'image': Images.onboard2,
      'title': 'Analyse product',
      'description': 'Analyze the product composition with AI.',
    },
    {
      'image': Images.onboard3,
      'title': 'Share result',
      'description': 'Share the results with your loved ones.',
    }
  ];

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      if (_pageController.page != null) {
        setState(() {
          _currentPage = _pageController.page!.round();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: SafeArea(
          child: PageView.builder(
            controller: _pageController,
            itemCount: slides.length,
            itemBuilder: (BuildContext context, int index) {
              final isLastSlide = index == slides.length - 1;
              final slideData = slides[index];
              return isLastSlide
                  ? LastSlideWidget(
                      imagePath: slideData['image'],
                      title: slideData['title'],
                      description: slideData['description'],
                    )
                  : SlideWidget(
                      imagePath: slideData['image'],
                      title: slideData['title'],
                      description: slideData['description'],
                      onButtonPressed: () {
                        if (_currentPage < slides.length - 1) {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.easeInOut,
                          );
                        }
                      },
                      buttonIcon: Icons.arrow_forward,
                    );
            },
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
