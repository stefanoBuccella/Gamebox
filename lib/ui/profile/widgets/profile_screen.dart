import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme/app_colors.dart';
import '../view_model/user_view_model.dart';
import '../../search/widgets/game_search_screen.dart';
import '../../home/widgets/game_card.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

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
          actions: [
            IconButton(
              icon: const Icon(Icons.settings_outlined, color: AppColors.pureWhite),
              onPressed: () {},
            ),
          ],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(50), // Ridotta l'altezza complessiva
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              padding: const EdgeInsets.all(3),
              height: 40, // Altezza fissa per rendere il rettangolo più basso
              decoration: BoxDecoration(
                color: AppColors.gunmetal,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Theme(
                data: ThemeData(
                  highlightColor: Colors.transparent, // Rimuove l'effetto al clic
                  splashColor: Colors.transparent,    // Rimuove l'effetto splash
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
                  overlayColor: WidgetStateProperty.all(Colors.transparent), // Rimuove overlay grigio/bianco
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
        body: const TabBarView(
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
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              CircleAvatar(
                radius: 35,
                backgroundColor: AppColors.charcoal,
                child: Icon(Icons.person, size: 35, color: AppColors.pureWhite),
              ),
              SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'User Name',
                    style: TextStyle(
                      color: AppColors.pureWhite,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '@username',
                    style: TextStyle(color: AppColors.charcoal, fontSize: 14),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 32),
          _buildSectionHeader(context, 'TOP 3 GAMES'),
          const SizedBox(height: 16),
          _buildTop3Grid(context, isGames: true),
          const SizedBox(height: 32),
          _buildSectionHeader(context, 'TOP 3 TROPHIES'),
          const SizedBox(height: 16),
          _buildTop3Grid(context, isGames: false),
          const SizedBox(height: 24),
          Center(
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.gunmetal,
                  foregroundColor: AppColors.electricViolet,
                  splashFactory: NoSplash.splashFactory, // Rimuove l'effetto sfarfallio
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: const BorderSide(color: AppColors.charcoal, width: 0.5),
                  ),
                  elevation: 0,
                ).copyWith(
                  overlayColor: WidgetStateProperty.all(Colors.transparent), // Rimuove overlay al clic
                ),
                child: const Text(
                  'ALL TROPHIES',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.1,
                  ),
                ),
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

  Widget _buildTop3Grid(BuildContext context, {required bool isGames}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(3, (index) => _buildItemSlot(context, isGames)),
    );
  }

  Widget _buildItemSlot(BuildContext context, bool isGames) {
    final double width = (MediaQuery.of(context).size.width - 60) / 3;
    return GestureDetector(
      onTap: () => _handleSlotTap(context, isGames),
      child: Container(
        width: width,
        height: width * 1.4,
        decoration: BoxDecoration(
          color: AppColors.gunmetal.withOpacity(0.5),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.charcoal.withOpacity(0.5), width: 1),
        ),
        child: const Icon(Icons.add, color: AppColors.charcoal, size: 30),
      ),
    );
  }

  void _handleSlotTap(BuildContext context, bool isGames) {
    if (isGames) {
      final diary = context.read<UserViewModel>().diary;
      if (diary.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Aggiungi prima dei giochi al diario!')),
        );
      } else {
        showModalBottomSheet(
          context: context,
          backgroundColor: AppColors.gunmetal,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          builder: (context) {
            return Container(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: diary.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: diary[index].imageUrl != null 
                        ? Image.network(diary[index].imageUrl!, width: 40, height: 55, fit: BoxFit.cover)
                        : Container(width: 40, height: 55, color: AppColors.charcoal),
                    ),
                    title: Text(diary[index].title, style: const TextStyle(color: AppColors.pureWhite)),
                    onTap: () => Navigator.pop(context),
                  );
                },
              ),
            );
          },
        );
      }
    }
  }
}

class DiaryTab extends StatelessWidget {
  const DiaryTab({super.key});

  @override
  Widget build(BuildContext context) {
    final diary = context.watch<UserViewModel>().diary;
    return Scaffold(
      backgroundColor: AppColors.voidBlack,
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.electricViolet,
        child: const Icon(Icons.add, color: AppColors.pureWhite),
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const GameSearchScreen())),
      ),
      body: diary.isEmpty 
        ? const Center(child: Text('IL TUO DIARIO È VUOTO', style: TextStyle(color: AppColors.charcoal, fontWeight: FontWeight.bold)))
        : ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 12),
            itemCount: diary.length,
            itemBuilder: (context, index) => GameCard(game: diary[index]),
          ),
    );
  }
}

class ToPlayTab extends StatelessWidget {
  const ToPlayTab({super.key});

  @override
  Widget build(BuildContext context) {
    final toPlay = context.watch<UserViewModel>().toPlay;
    return Scaffold(
      backgroundColor: AppColors.voidBlack,
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.electricViolet,
        child: const Icon(Icons.add, color: AppColors.pureWhite),
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const GameSearchScreen())),
      ),
      body: toPlay.isEmpty 
        ? const Center(child: Text('LA TUA LISTA TO PLAY È VUOTA', style: TextStyle(color: AppColors.charcoal, fontWeight: FontWeight.bold)))
        : ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 12),
            itemCount: toPlay.length,
            itemBuilder: (context, index) => GameCard(game: toPlay[index]),
          ),
    );
  }
}

class ListsPlaceholderTab extends StatelessWidget {
  const ListsPlaceholderTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'LE TUE LISTE\n(PROSSIMO SPRINT)',
        textAlign: TextAlign.center,
        style: TextStyle(color: AppColors.charcoal, fontWeight: FontWeight.bold),
      ),
    );
  }
}
