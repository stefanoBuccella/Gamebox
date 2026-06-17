import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme/app_colors.dart';
import '../view_model/user_view_model.dart';
import '../../auth/view_model/auth_view_model.dart';
import '../../auth/widgets/login_screen.dart';
import '../../details/widgets/game_detail_screen.dart';
import '../../details/widgets/review_dialog.dart';
import '../../core/view_model/navigation_view_model.dart';
import '../../../domain/models/game.dart';
import '../../../domain/models/diary_entry.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userViewModel = context.watch<UserViewModel>();
    final isLoading = userViewModel.isLoading;

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
          actions: [
            IconButton(
              icon: const Icon(Icons.logout, color: AppColors.pureWhite),
              onPressed: () async {
                await context.read<AuthViewModel>().signOut();
                if (context.mounted) {
                  Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (_) => const LoginScreen()),
                    (route) => false,
                  );
                }
              },
            ),
          ],
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
                    Tab(text: 'PROFILE'),
                    Tab(text: 'DIARY'),
                    Tab(text: 'TO PLAY'),
                    Tab(text: 'LISTS'),
                  ],
                ),
              ),
            ),
          ),
        ),
        body: isLoading 
          ? const Center(child: CircularProgressIndicator(color: AppColors.electricViolet))
          : const TabBarView(
              children: [
                OverviewTab(),
                DiaryTab(),
                ToPlayTab(),
                ListsPlaceholderTab(),
              ],
            ),
      ),
    );
  }
}

class OverviewTab extends StatelessWidget {
  const OverviewTab({super.key});

  @override
  Widget build(BuildContext context) {
    final userViewModel = context.watch<UserViewModel>();
    final username = userViewModel.username ?? 'User';
    final top3 = userViewModel.top3Games;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 35,
                backgroundColor: AppColors.charcoal,
                child: Icon(Icons.person, size: 35, color: AppColors.pureWhite),
              ),
              const SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    username,
                    style: const TextStyle(
                      color: AppColors.pureWhite,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '@${username.toLowerCase().replaceAll(' ', '')}',
                    style: const TextStyle(color: AppColors.charcoal, fontSize: 14),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 32),
          _buildSectionHeader(context, 'TOP 3 GAMES'),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(3, (index) {
              final game = index < top3.length ? top3[index] : null;
              return _buildTop3Slot(context, game);
            }),
          ),
          const SizedBox(height: 32),
          _buildSectionHeader(context, 'TOP 3 TROPHIES'),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(3, (index) => _buildTrophySlot(context)),
          ),
          const SizedBox(height: 24),
          Center(
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.gunmetal,
                  foregroundColor: AppColors.electricViolet,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: const BorderSide(color: AppColors.charcoal, width: 0.5),
                  ),
                  elevation: 0,
                ),
                child: const Text('ALL TROPHIES', style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.1)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Text(
      title,
      style: const TextStyle(
        color: AppColors.pureWhite,
        fontSize: 16,
        fontWeight: FontWeight.w900,
        letterSpacing: 1.1,
      ),
    );
  }

  Widget _buildTop3Slot(BuildContext context, Game? game) {
    final double width = (MediaQuery.of(context).size.width - 60) / 3;
    final userVM = context.read<UserViewModel>();

    return GestureDetector(
      onTap: () {
        if (game == null) {
          _showDiarySelection(context);
        } else {
          _showRemoveOption(context, game);
        }
      },
      child: Container(
        width: width,
        height: width * 1.4,
        decoration: BoxDecoration(
          color: AppColors.gunmetal.withOpacity(0.5),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.charcoal.withOpacity(0.5), width: 1),
          image: game?.imageUrl != null 
              ? DecorationImage(image: NetworkImage(game!.imageUrl!), fit: BoxFit.cover)
              : null,
        ),
        child: game == null ? const Icon(Icons.add, color: AppColors.charcoal, size: 30) : null,
      ),
    );
  }

  Widget _buildTrophySlot(BuildContext context) {
    final double width = (MediaQuery.of(context).size.width - 60) / 3;
    return Container(
      width: width,
      height: width * 1.4,
      decoration: BoxDecoration(
        color: AppColors.gunmetal.withOpacity(0.5),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.charcoal.withOpacity(0.5), width: 1),
      ),
      child: const Icon(Icons.emoji_events_outlined, color: AppColors.charcoal, size: 30),
    );
  }

  void _showDiarySelection(BuildContext context) {
    final userVM = context.read<UserViewModel>();
    final diary = userVM.diary;

    if (diary.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Your diary is empty. Add a game first!')),
      );
      return;
    }

    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.gunmetal,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("SELECT FROM YOUR LIBRARY",
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 20),
              SizedBox(
                height: 180,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: diary.length,
                  itemBuilder: (context, index) {
                    final entry = diary[index];
                    return GestureDetector(
                      onTap: () {
                        userVM.addToTop3(entry.game);
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: 100,
                        margin: const EdgeInsets.only(right: 12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: entry.game.imageUrl != null 
                              ? DecorationImage(image: NetworkImage(entry.game.imageUrl!), fit: BoxFit.cover)
                              : null,
                          color: AppColors.charcoal,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showRemoveOption(BuildContext context, Game game) {
    final userVM = context.read<UserViewModel>();
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.gunmetal,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(game.title.toUpperCase(), 
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.push(context, MaterialPageRoute(builder: (_) => GameDetailScreen(game: game)));
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: AppColors.electricViolet),
                      child: const Text("VIEW DETAILS", style: TextStyle(color: Colors.white)),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        userVM.removeFromTop3(game.id);
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
                      child: const Text("REMOVE FROM TOP 3", style: TextStyle(color: Colors.white, fontSize: 11)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
            ],
          ),
        );
      },
    );
  }
}

class DiaryTab extends StatelessWidget {
  const DiaryTab({super.key});

  @override
  Widget build(BuildContext context) {
    final diary = context.watch<UserViewModel>().diary;
    if (diary.isEmpty) {
      return _buildEmptyState(context, "YOUR DIARY IS EMPTY");
    }
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 0.7,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: diary.length + 1,
      itemBuilder: (context, index) {
        if (index == 0) return _buildAddButton(context);
        final entry = diary[index - 1];
        return GestureDetector(
          onTap: () => _showReviewDetails(context, entry),
          child: Stack(
            children: [
              Positioned.fill(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: entry.game.imageUrl != null 
                      ? Image.network(entry.game.imageUrl!, fit: BoxFit.cover)
                      : Container(color: AppColors.charcoal),
                ),
              ),
              Positioned(
                bottom: 4,
                right: 4,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: AppColors.cyberCyan,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    entry.rating.toString(),
                    style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showReviewDetails(BuildContext context, DiaryEntry entry) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.gunmetal,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: entry.game.imageUrl != null 
                        ? Image.network(entry.game.imageUrl!, width: 60, height: 80, fit: BoxFit.cover)
                        : Container(width: 60, height: 80, color: AppColors.charcoal),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(entry.game.title.toUpperCase(), style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
                        const SizedBox(height: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.star, color: AppColors.cyberCyan, size: 16),
                                const SizedBox(width: 4),
                                Text(entry.rating.toString(), style: const TextStyle(color: AppColors.cyberCyan, fontWeight: FontWeight.bold)),
                              ],
                            ),
                            Row(
                              children: [
                                const Icon(Icons.favorite, color: Colors.redAccent, size: 16),
                                const SizedBox(width: 4),
                                Text("${entry.likesCount}", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Text("YOUR REVIEW:", style: TextStyle(color: AppColors.charcoal, fontSize: 12, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text(entry.reviewText.isEmpty ? "No notes added." : entry.reviewText, style: const TextStyle(color: Colors.white)),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        showDialog(
                          context: context,
                          builder: (_) => ReviewDialog(game: entry.game, existingEntry: entry),
                        );
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: AppColors.cyberCyan),
                      child: const Text("EDIT REVIEW", style: TextStyle(color: Colors.white, fontSize: 12)),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        context.read<UserViewModel>().deleteFromDiary(entry.game.id);
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
                      child: const Text("REMOVE", style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class ToPlayTab extends StatelessWidget {
  const ToPlayTab({super.key});

  @override
  Widget build(BuildContext context) {
    final toPlay = context.watch<UserViewModel>().toPlay;
    if (toPlay.isEmpty) {
      return _buildEmptyState(context, "YOUR TO PLAY LIST IS EMPTY");
    }
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 0.7,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: toPlay.length + 1,
      itemBuilder: (context, index) {
        if (index == 0) return _buildAddButton(context);
        final game = toPlay[index - 1];
        return GestureDetector(
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => GameDetailScreen(game: game))),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: game.imageUrl != null 
                ? Image.network(game.imageUrl!, fit: BoxFit.cover)
                : Container(color: AppColors.charcoal),
          ),
        );
      },
    );
  }
}

Widget _buildEmptyState(BuildContext context, String emptyMsg) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          emptyMsg,
          textAlign: TextAlign.center,
          style: const TextStyle(color: AppColors.charcoal, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        ElevatedButton.icon(
          onPressed: () => context.read<NavigationViewModel>().setIndex(1),
          icon: const Icon(Icons.search),
          label: const Text("SEARCH A GAME"),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.cyberCyan,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          ),
        ),
      ],
    ),
  );
}

Widget _buildAddButton(BuildContext context) {
  return GestureDetector(
    onTap: () => context.read<NavigationViewModel>().setIndex(1),
    child: Container(
      decoration: BoxDecoration(
        color: AppColors.gunmetal.withOpacity(0.5),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.charcoal.withOpacity(0.5), width: 1, style: BorderStyle.solid),
      ),
      child: const Icon(Icons.add, color: AppColors.charcoal, size: 30),
    ),
  );
}

class ListsPlaceholderTab extends StatelessWidget {
  const ListsPlaceholderTab({super.key});
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('YOUR LISTS\n(COMING SOON)', textAlign: TextAlign.center, style: TextStyle(color: AppColors.charcoal, fontWeight: FontWeight.bold)));
  }
}
