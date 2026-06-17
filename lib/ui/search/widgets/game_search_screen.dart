import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../data/repositories/game_repository.dart';
import '../../core/theme/app_colors.dart';
import '../../home/widgets/game_card.dart';
import '../../details/widgets/game_detail_screen.dart';
import '../view_model/search_view_model.dart';

class GameSearchScreen extends StatefulWidget {
  const GameSearchScreen({super.key});

  @override
  State<GameSearchScreen> createState() => _GameSearchScreenState();
}

class _GameSearchScreenState extends State<GameSearchScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SearchViewModel(context.read<GameRepository>()),
      child: Consumer<SearchViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            backgroundColor: AppColors.voidBlack,
            appBar: AppBar(
              backgroundColor: AppColors.gunmetal,
              title: TextField(
                controller: _controller,
                style: const TextStyle(color: AppColors.pureWhite),
                decoration: const InputDecoration(
                  hintText: 'Search a game...',
                  hintStyle: TextStyle(color: AppColors.charcoal),
                  border: InputBorder.none,
                ),
                onSubmitted: (value) => viewModel.search(value),
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.search, color: AppColors.cyberCyan),
                  onPressed: () => viewModel.search(_controller.text),
                ),
              ],
            ),
            body: viewModel.isLoading
                ? const Center(child: CircularProgressIndicator(color: AppColors.cyberCyan))
                : viewModel.searchResults.isEmpty && _controller.text.isNotEmpty
                    ? const Center(
                        child: Text(
                          'No results found or connection error.\nCheck logs and internet connection.',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: AppColors.slateGray),
                        ),
                      )
                    : ListView.builder(
                        itemCount: viewModel.searchResults.length,
                        itemBuilder: (context, index) {
                      final game = viewModel.searchResults[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => GameDetailScreen(game: game),
                            ),
                          );
                        },
                        child: GameCard(game: game),
                      );
                    },
                  ),
          );
        },
      ),
    );
  }
}
