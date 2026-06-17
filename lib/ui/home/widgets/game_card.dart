import 'package:flutter/material.dart';
import '../../../domain/models/game.dart';
import '../../core/theme/app_colors.dart';

class GameCard extends StatelessWidget {
  final Game game;
  const GameCard({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.gunmetal,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: game.imageUrl != null 
                ? Image.network(game.imageUrl!, width: 60, height: 80, fit: BoxFit.cover)
                : Container(width: 60, height: 80, color: AppColors.charcoal),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(game.title, style: const TextStyle(color: AppColors.pureWhite, fontWeight: FontWeight.bold)),
                Text(game.publisher ?? '', style: const TextStyle(color: AppColors.cyberCyan)),
              ],
            ),
          ),
          if (game.rating != null)
            Text("${game.rating!.toStringAsFixed(1)} ★", style: const TextStyle(color: AppColors.pureWhite)),
        ],
      ),
    );
  }
}