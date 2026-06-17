import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../domain/models/game.dart';
import '../../core/theme/app_colors.dart';
import '../../profile/view_model/user_view_model.dart';
import 'review_dialog.dart';

class GameDetailScreen extends StatelessWidget {
  final Game game;
  const GameDetailScreen({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.voidBlack,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: game.imageUrl != null
                  ? Image.network(game.imageUrl!, fit: BoxFit.cover)
                  : Container(color: AppColors.charcoal),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(game.title, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppColors.pureWhite)),
                    const SizedBox(height: 8),
                    Text("${game.releaseYear ?? ''} ${game.platforms.join(' - ')}", style: const TextStyle(color: AppColors.charcoal)),
                    const SizedBox(height: 8),
                    Text(game.publisher ?? '', style: const TextStyle(color: AppColors.electricViolet, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 24),
                    
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: ElevatedButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (_) => ReviewDialog(game: game),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.electricViolet,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            ),
                            child: const Text('Add & Review the Game', 
                              textAlign: TextAlign.center,
                              style: TextStyle(color: AppColors.pureWhite, fontWeight: FontWeight.bold)),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          flex: 1,
                          child: Consumer<UserViewModel>(
                            builder: (context, userVM, child) {
                              final inToPlay = userVM.isInToPlay(game.id);
                              return ElevatedButton(
                                onPressed: () async {
                                  await userVM.toggleToPlay(game);
                                  if (context.mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(inToPlay ? 'Rimosso da To Play' : 'Aggiunto a To Play')),
                                    );
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: inToPlay ? Colors.redAccent : AppColors.cyberCyan,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                ),
                                child: Text(inToPlay ? 'REMOVE' : 'TO PLAY', 
                                  style: const TextStyle(color: AppColors.pureWhite, fontWeight: FontWeight.bold, fontSize: 12)),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Text(
                      game.summary ?? 'Nessuna descrizione disponibile per questo gioco.',
                      style: const TextStyle(color: AppColors.pureWhite),
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
