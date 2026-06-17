import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../domain/models/game.dart';
import '../../core/theme/app_colors.dart';
import '../../profile/view_model/user_view_model.dart';

class ReviewDialog extends StatefulWidget {
  final Game game;
  const ReviewDialog({super.key, required this.game});

  @override
  State<ReviewDialog> createState() => _ReviewDialogState();
}

class _ReviewDialogState extends State<ReviewDialog> {
  double _rating = 0;
  final TextEditingController _noteController = TextEditingController();

  void _updateRating(Offset localPosition, double maxWidth) {
    final double percent = localPosition.dx / maxWidth;
    double newRating = (percent * 5 * 2).round() / 2;
    if (newRating < 0) newRating = 0;
    if (newRating > 5) newRating = 5;
    if (_rating != newRating) {
      setState(() => _rating = newRating);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.gunmetal,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Review ${widget.game.title}",
                textAlign: TextAlign.center,
                style: const TextStyle(color: AppColors.pureWhite, fontWeight: FontWeight.bold, fontSize: 18)),
            const SizedBox(height: 24),
            LayoutBuilder(
              builder: (context, constraints) {
                return GestureDetector(
                  onHorizontalDragUpdate: (details) => _updateRating(details.localPosition, constraints.maxWidth),
                  onTapDown: (details) => _updateRating(details.localPosition, constraints.maxWidth),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(5, (index) {
                      IconData icon;
                      if (_rating >= index + 1) {
                        icon = Icons.star;
                      } else if (_rating >= index + 0.5) {
                        icon = Icons.star_half;
                      } else {
                        icon = Icons.star_border;
                      }
                      return Icon(icon, color: AppColors.electricViolet, size: 40);
                    }),
                  ),
                );
              },
            ),
            const SizedBox(height: 8),
            Text(_rating.toString(), style: const TextStyle(color: AppColors.electricViolet, fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 16),
            TextField(
              controller: _noteController,
              maxLines: 4,
              style: const TextStyle(color: AppColors.pureWhite),
              decoration: const InputDecoration(
                hintText: 'Scrivi una nota...',
                hintStyle: TextStyle(color: AppColors.charcoal),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                await context.read<UserViewModel>().addToDiary(
                  widget.game,
                  _rating,
                  _noteController.text,
                );
                if (mounted) {
                  Navigator.pop(context);
                  Navigator.pop(context);
                }
              },
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.electricViolet),
              child: const Text('Salva', style: TextStyle(color: AppColors.pureWhite)),
            ),
          ],
        ),
      ),
    );
  }
}
