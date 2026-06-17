import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: AppColors.voidBlack,
        appBar: AppBar(
          backgroundColor: AppColors.voidBlack,
          elevation: 0,
          title: const Text(
            'GAMEBOX',
            style: TextStyle(
              color: AppColors.pureWhite,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              padding: const EdgeInsets.all(3),
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.gunmetal,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Theme(
                data: ThemeData(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                ),
                child: TabBar(
                  isScrollable: false,
                  indicator: BoxDecoration(
                    color: AppColors.electricViolet,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  indicatorSize: TabBarIndicatorSize.tab,
                  labelColor: AppColors.pureWhite,
                  unselectedLabelColor: AppColors.charcoal,
                  dividerColor: Colors.transparent,
                  overlayColor: WidgetStateProperty.all(Colors.transparent),
                  labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
                  tabs: const [
                    Tab(text: 'POPULAR'),
                    Tab(text: 'LISTS'),
                    Tab(text: 'REVIEWS'),
                    Tab(text: 'MY FEED'),
                  ],
                ),
              ),
            ),
          ),
        ),
        body: const TabBarView(
          children: [
            PopularGamesTab(),
            PopularListsTab(),
            PopularReviewsTab(),
            MyFeedTab(),
          ],
        ),
      ),
    );
  }
}

class PopularGamesTab extends StatelessWidget {
  const PopularGamesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'GIOCHI POPOLARI\n(TRA AMICI)',
        textAlign: TextAlign.center,
        style: TextStyle(color: AppColors.charcoal, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class PopularListsTab extends StatelessWidget {
  const PopularListsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'LISTE POPOLARI\n(PIÙ UPVOTE)',
        textAlign: TextAlign.center,
        style: TextStyle(color: AppColors.charcoal, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class PopularReviewsTab extends StatelessWidget {
  const PopularReviewsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'REVIEW POPOLARI\n(PIÙ LIKE)',
        textAlign: TextAlign.center,
        style: TextStyle(color: AppColors.charcoal, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class MyFeedTab extends StatelessWidget {
  const MyFeedTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'LE MIE REVIEW\n(CRONOLOGIA)',
        textAlign: TextAlign.center,
        style: TextStyle(color: AppColors.charcoal, fontWeight: FontWeight.bold),
      ),
    );
  }
}
