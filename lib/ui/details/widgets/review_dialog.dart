import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../domain/models/game.dart';
import '../../core/theme/app_colors.dart';
import '../../profile/view_model/user_view_model.dart';

import '../../../domain/models/diary_entry.dart';

class ReviewDialog extends StatefulWidget {
  final Game game;
  final DiaryEntry? existingEntry;
  const ReviewDialog({super.key, required this.game, this.existingEntry});

  @override
  State<ReviewDialog> createState() => _ReviewDialogState();
}

class _ReviewDialogState extends State<ReviewDialog> {
  late double _rating;
  late TextEditingController _noteController;

  @override
  void initState() {
    super.initState();
    _rating = widget.existingEntry?.rating ?? 0;
    _noteController = TextEditingController(text: widget.existingEntry?.reviewText ?? '');
  }

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
                      return Icon(icon, color: AppColors.cyberCyan, size: 40);
                    }),
                  ),
                );
              },
            ),
            const SizedBox(height: 8),
            Text(_rating.toString(), style: const TextStyle(color: AppColors.cyberCyan, fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 16),
            TextField(
              controller: _noteController,
              maxLines: 4,
              style: const TextStyle(color: AppColors.pureWhite),
              decoration: const InputDecoration(
                hintText: 'Write a note...',
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
                  Navigator.pop(context, true);
                }
              },
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.cyberCyan),
              child: const Text('Save', style: TextStyle(color: AppColors.pureWhite)),
            ),
          ],
        ),
      ),
    );
  }
}
