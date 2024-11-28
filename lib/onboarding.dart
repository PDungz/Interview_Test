import 'package:flutter/material.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  late PageController _pageController;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 50),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.blue.withOpacity(0.12),
                Colors.purple.withOpacity(0.12),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: planet.length,
                  itemBuilder: (context, index) {
                    return OnBoardContent(
                      pageController: _pageController,
                      index: index,
                      imageUrl: planet[index].imageUrl,
                      title: planet[index].title,
                      description: planet[index].decoration,
                    );
                  },
                ),
              ),
              const SizedBox(height: 24),
              Align(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(
                  onPressed: () {
                    if (_pageController.page?.toInt() == planet.length - 1) {
                      // Hành động khi đến trang cuối
                    } else {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.ease,
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    backgroundColor: const Color(0xFFF4F4F4),
                    padding: const EdgeInsets.all(20),
                  ),
                  child: const Icon(Icons.arrow_forward, size: 30),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OnBoard {
  final String imageUrl;
  final String title;
  final String decoration;
  OnBoard({
    required this.imageUrl,
    required this.title,
    required this.decoration,
  });
}

final List<OnBoard> planet = [
  OnBoard(
    imageUrl: 'assets/images/earth.png',
    title: 'Welcome Earth',
    decoration: 'Explore our planet and its wonders.',
  ),
  OnBoard(
    imageUrl: 'assets/images/saturn.png',
    title: 'Welcome Saturn',
    decoration: 'Discover the beauty of Saturn.',
  ),
];

class OnBoardContent extends StatelessWidget {
  final PageController pageController;
  final int index;
  final String imageUrl;
  final String title;
  final String description;

  const OnBoardContent({
    super.key,
    required this.pageController,
    required this.index,
    required this.imageUrl,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return AnimatedBuilder(
          animation: pageController,
          builder: (context, child) {
            double value = 1.0;
            if (pageController.position.hasContentDimensions) {
              value = pageController.page! - index;
              value = (1 - value.abs()).clamp(0.8, 1.0); // Giới hạn scale
            }

            return Column(
              children: [
                const Spacer(),
                Transform.scale(
                  scale: value,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: MediaQuery.of(context).size.width * 0.5,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(fontWeight: FontWeight.bold, fontSize: 24),
                ),
                const SizedBox(height: 12),
                Text(
                  description,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium!,
                ),
                const Spacer(),
              ],
            );
          },
        );
      },
    );
  }
}
