import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../domain/models/user_list.dart';
import '../../core/theme/app_colors.dart';
import '../../details/widgets/game_detail_screen.dart';
import '../view_model/user_view_model.dart';

import 'create_list_screen.dart';

class ListDetailScreen extends StatelessWidget {
  final UserList list;
  const ListDetailScreen({super.key, required this.list});

  @override
  Widget build(BuildContext context) {
    final userVM = context.watch<UserViewModel>();
    final isMe = userVM.username == list.username;
    
    return Scaffold(
      backgroundColor: AppColors.voidBlack,
      appBar: AppBar(
        backgroundColor: AppColors.voidBlack,
        title: Text(list.title, style: const TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          if (isMe)
            IconButton(
              icon: const Icon(Icons.edit_outlined, color: AppColors.cyberCyan),
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => CreateListScreen(existingList: list))),
            ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Created by @${list.username}", style: const TextStyle(color: AppColors.cyberCyan, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  Text(list.description ?? "No description provided.", style: const TextStyle(color: Colors.white70)),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      _buildVoteButton(
                        context, 
                        Icons.thumb_up, 
                        list.upvotesCount, 
                        list.myVote == 1, 
                        isMe ? null : () => userVM.voteList(list, 1)
                      ),
                      const SizedBox(width: 20),
                      _buildVoteButton(
                        context, 
                        Icons.thumb_down, 
                        list.downvotesCount, 
                        list.myVote == -1, 
                        isMe ? null : () => userVM.voteList(list, -1)
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Divider(color: AppColors.charcoal, thickness: 0.5),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: list.games.length,
              itemBuilder: (context, index) {
                final game = list.games[index];
                return ListTile(
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => GameDetailScreen(game: game))),
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: game.imageUrl != null 
                        ? Image.network(game.imageUrl!, width: 40, height: 55, fit: BoxFit.cover)
                        : Container(width: 40, height: 55, color: AppColors.charcoal),
                  ),
                  title: Text(game.title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  subtitle: Text(game.platforms.join(', '), style: const TextStyle(color: AppColors.charcoal, fontSize: 12)),
                  trailing: const Icon(Icons.chevron_right, color: AppColors.charcoal),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVoteButton(BuildContext context, IconData icon, int count, bool active, VoidCallback? onTap) {
    return InkWell(
      onTap: onTap,
      child: Opacity(
        opacity: onTap == null ? 0.3 : 1.0,
        child: Row(
          children: [
            Icon(icon, color: active ? AppColors.cyberCyan : AppColors.charcoal, size: 24),
            const SizedBox(width: 8),
            Text("$count", style: TextStyle(color: active ? AppColors.cyberCyan : Colors.white, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
