import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../domain/models/game.dart';
import '../../../domain/models/diary_entry.dart';
import '../../core/theme/app_colors.dart';
import '../../profile/view_model/user_view_model.dart';
import 'review_dialog.dart';

class GameDetailScreen extends StatefulWidget {
  final Game game;
  const GameDetailScreen({super.key, required this.game});

  @override
  State<GameDetailScreen> createState() => _GameDetailScreenState();
}

class _GameDetailScreenState extends State<GameDetailScreen> {
  String _reviewFilter = 'Popular';
  List<DiaryEntry> _allReviews = [];
  bool _isLoadingReviews = true;

  @override
  void initState() {
    super.initState();
    _loadReviews();
  }

  Future<void> _loadReviews() async {
    try {
      final reviews = await context.read<UserViewModel>().getGameReviews(widget.game.id);
      if (mounted) {
        setState(() {
          _allReviews = reviews;
          _isLoadingReviews = false;
        });
      }
    } catch (e) {
      debugPrint("Error loading reviews: $e");
      if (mounted) {
        setState(() {
          _isLoadingReviews = false;
        });
      }
    }
  }

  List<DiaryEntry> get _filteredReviews {
    final reviews = List<DiaryEntry>.from(_allReviews);
    if (_reviewFilter == 'Popular') {
      reviews.sort((a, b) => b.likesCount.compareTo(a.likesCount));
    } else if (_reviewFilter == 'Recent') {
      reviews.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    } else if (_reviewFilter == 'Old') {
      reviews.sort((a, b) => a.createdAt.compareTo(b.createdAt));
    }
    return reviews;
  }

  @override
  Widget build(BuildContext context) {
    final userVM = context.watch<UserViewModel>();
    final myEntry = userVM.diary.cast<DiaryEntry?>().firstWhere((d) => d?.game.id == widget.game.id, orElse: () => null);

    return Scaffold(
      backgroundColor: AppColors.voidBlack,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: widget.game.imageUrl != null
                  ? Image.network(widget.game.imageUrl!, fit: BoxFit.cover)
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
                    Text(widget.game.title, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppColors.pureWhite)),
                    const SizedBox(height: 8),
                    if (widget.game.genres.isNotEmpty) ...[
                      Text(widget.game.genres.join(', '), style: const TextStyle(color: AppColors.cyberCyan, fontSize: 14, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                    ],
                    Text("${widget.game.releaseYear ?? ''} ${widget.game.platforms.join(' - ')}", style: const TextStyle(color: AppColors.charcoal, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Text(widget.game.publisher ?? '', style: const TextStyle(color: AppColors.cyberCyan, fontWeight: FontWeight.w900)),
                    const SizedBox(height: 24),
                    
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Consumer<UserViewModel>(
                            builder: (context, userVM, child) {
                              if (userVM.isInDiary(widget.game.id)) {
                                return ElevatedButton(
                                  onPressed: null,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.charcoal,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                  ),
                                  child: const Text('ALREADY REVIEWED', 
                                    style: TextStyle(color: AppColors.pureWhite, fontWeight: FontWeight.bold)),
                                );
                              }
                              return ElevatedButton(
                                onPressed: () async {
                                  final result = await showDialog<bool>(
                                    context: context,
                                    builder: (_) => ReviewDialog(game: widget.game),
                                  );
                                  if (result == true) {
                                    _loadReviews();
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.cyberCyan,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                ),
                                child: const Text('Add & Review', 
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: AppColors.pureWhite, fontWeight: FontWeight.bold)),
                              );
                            },
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          flex: 1,
                          child: Consumer<UserViewModel>(
                            builder: (context, userVM, child) {
                              final inToPlay = userVM.isInToPlay(widget.game.id);
                              return ElevatedButton(
                                onPressed: () async {
                                  await userVM.toggleToPlay(widget.game);
                                  if (context.mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(inToPlay ? 'Removed from To Play' : 'Added to To Play')),
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
                      widget.game.summary ?? 'No description available for this game.',
                      style: const TextStyle(color: AppColors.pureWhite),
                    ),
                    
                    if (myEntry != null) ...[
                      const SizedBox(height: 32),
                      const Text("YOUR REVIEW", style: TextStyle(color: AppColors.cyberCyan, fontWeight: FontWeight.bold, fontSize: 18)),
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.gunmetal,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppColors.cyberCyan.withOpacity(0.3)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: List.generate(5, (i) => Icon(
                                    myEntry.rating > i ? (myEntry.rating > i + 0.5 ? Icons.star : Icons.star_half) : Icons.star_border,
                                    color: AppColors.cyberCyan, size: 20,
                                  )),
                                ),
                                Row(
                                  children: [
                                    const Icon(Icons.favorite, color: Colors.redAccent, size: 18),
                                    const SizedBox(width: 4),
                                    Text("${myEntry.likesCount}", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Text(myEntry.reviewText.isEmpty ? "No comments." : myEntry.reviewText, style: const TextStyle(color: Colors.white)),
                          ],
                        ),
                      ),
                    ],

                    const SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("REVIEWS", style: TextStyle(color: AppColors.pureWhite, fontWeight: FontWeight.bold, fontSize: 20)),
                        DropdownButton<String>(
                          value: _reviewFilter,
                          dropdownColor: AppColors.gunmetal,
                          style: const TextStyle(color: AppColors.cyberCyan, fontWeight: FontWeight.bold),
                          underline: Container(),
                          onChanged: (String? newValue) {
                            if (newValue != null) setState(() => _reviewFilter = newValue);
                          },
                          items: <String>['Popular', 'Recent', 'Old'].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(value: value, child: Text(value));
                          }).toList(),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    if (_isLoadingReviews)
                      const Center(child: CircularProgressIndicator(color: AppColors.cyberCyan))
                    else if (_filteredReviews.isEmpty)
                      const Center(child: Text("No reviews yet.", style: TextStyle(color: AppColors.charcoal)))
                    else
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _filteredReviews.length,
                        itemBuilder: (context, index) {
                          final review = _filteredReviews[index];
                          final isMe = review.username == userVM.username;
                          if (isMe) return const SizedBox.shrink();

                          return Container(
                            margin: const EdgeInsets.only(bottom: 16),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: AppColors.gunmetal,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("@${review.username ?? 'user'}", style: const TextStyle(color: AppColors.cyberCyan, fontWeight: FontWeight.bold)),
                                        Text(
                                          "${review.createdAt.day}/${review.createdAt.month}/${review.createdAt.year}",
                                          style: const TextStyle(color: AppColors.charcoal, fontSize: 11),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        IconButton(
                                          icon: Icon(review.isLikedByMe ? Icons.favorite : Icons.favorite_border, 
                                            color: review.isLikedByMe ? Colors.redAccent : AppColors.charcoal, size: 20),
                                          onPressed: () async {
                                            await userVM.toggleLike(review);
                                            await _loadReviews(); // Refresh local list
                                          },
                                        ),
                                        Text("${review.likesCount}", style: const TextStyle(color: Colors.white, fontSize: 12)),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: List.generate(5, (i) => Icon(
                                    review.rating > i ? (review.rating > i + 0.5 ? Icons.star : Icons.star_half) : Icons.star_border,
                                    color: AppColors.cyberCyan, size: 16,
                                  )),
                                ),
                                const SizedBox(height: 8),
                                Text(review.reviewText, style: const TextStyle(color: Colors.white70)),
                              ],
                            ),
                          );
                        },
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
