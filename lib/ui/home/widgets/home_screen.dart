import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme/app_colors.dart';
import '../../profile/view_model/user_view_model.dart';
import '../../details/widgets/game_detail_screen.dart';

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
                    color: AppColors.cyberCyan,
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
        'POPULAR GAMES\n(AMONG FRIENDS)',
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
        'POPULAR LISTS\n(MOST UPVOTED)',
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
        'POPULAR REVIEWS\n(MOST LIKED)',
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
    final userVM = context.watch<UserViewModel>();
    final diary = userVM.diary;

    if (diary.isEmpty) {
      return const Center(
        child: Text(
          'NO REVIEWS YET',
          style: TextStyle(color: AppColors.charcoal, fontWeight: FontWeight.bold),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: diary.length,
      itemBuilder: (context, index) {
        final entry = diary[index];
        return Dismissible(
          key: Key('feed_${entry.game.id}'),
          direction: DismissDirection.endToStart,
          background: Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.redAccent,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.delete, color: Colors.white),
          ),
          onDismissed: (direction) {
            userVM.deleteFromDiary(entry.game.id);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('${entry.game.title} removed from diary')),
            );
          },
          child: Card(
            color: AppColors.gunmetal,
            margin: const EdgeInsets.only(bottom: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: InkWell(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => GameDetailScreen(game: entry.game))),
              borderRadius: BorderRadius.circular(12),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: entry.game.imageUrl != null 
                          ? Image.network(entry.game.imageUrl!, width: 70, height: 95, fit: BoxFit.cover)
                          : Container(width: 70, height: 95, color: AppColors.charcoal),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(entry.game.title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                          const SizedBox(height: 4),
                          Row(
                            children: List.generate(5, (starIndex) {
                              IconData icon;
                              if (entry.rating >= starIndex + 1) {
                                icon = Icons.star;
                              } else if (entry.rating >= starIndex + 0.5) {
                                icon = Icons.star_half;
                              } else {
                                icon = Icons.star_border;
                              }
                              return Icon(
                                icon,
                                color: AppColors.cyberCyan,
                                size: 16,
                              );
                            }),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            entry.reviewText.isEmpty ? "No comments." : entry.reviewText,
                            style: const TextStyle(color: Colors.white70, fontSize: 14),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${entry.createdAt.day}/${entry.createdAt.month}/${entry.createdAt.year}",
                                style: const TextStyle(color: AppColors.charcoal, fontSize: 12),
                              ),
                              Row(
                                children: [
                                  const Icon(Icons.favorite, color: Colors.redAccent, size: 16),
                                  const SizedBox(width: 4),
                                  Text("${entry.likesCount}", style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
