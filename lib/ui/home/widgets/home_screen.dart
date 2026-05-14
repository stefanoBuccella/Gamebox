import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_model/home_view_model.dart';
import 'game_card.dart';
import '../../core/theme/app_colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Chiamiamo il caricamento dei dati non appena la view viene creata
    // Usiamo microtask per assicurarci che il context sia pronto
    Future.microtask(
      () => context.read<HomeViewModel>().fetchGames(),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Watch ascolta i cambiamenti nel ViewModel (isLoading, lista giochi)
    final viewModel = context.watch<HomeViewModel>();

    return Scaffold(
      backgroundColor: AppColors.voidBlack,
      appBar: AppBar(
        backgroundColor: AppColors.gunmetal,
        title: const Text(
          'GAMEBOX',
          style: TextStyle(
            color: AppColors.pureWhite,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: viewModel.isLoading
          ? const Center(
              child: CircularProgressIndicator(color: AppColors.electricViolet),
            )
          : ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 12),
              itemCount: viewModel.games.length,
              itemBuilder: (context, index) {
                final game = viewModel.games[index];
                // Richiamiamo il widget GameCard creato in precedenza
                return GameCard(game: game);
              },
            ),
    );  

  }
}