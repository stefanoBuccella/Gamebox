import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../domain/models/game.dart';
import '../../../domain/models/user_list.dart';
import '../../core/theme/app_colors.dart';
import '../view_model/user_view_model.dart';

class CreateListScreen extends StatefulWidget {
  final UserList? existingList;
  const CreateListScreen({super.key, this.existingList});

  @override
  State<CreateListScreen> createState() => _CreateListScreenState();
}

class _CreateListScreenState extends State<CreateListScreen> {
  late TextEditingController _titleController;
  late TextEditingController _descController;
  final _searchController = TextEditingController();
  late bool _isPublic;
  final List<Game> _selectedGames = [];
  String _searchQuery = "";

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.existingList?.title ?? "");
    _descController = TextEditingController(text: widget.existingList?.description ?? "");
    _isPublic = widget.existingList?.isPublic ?? true;
    if (widget.existingList != null) {
      _selectedGames.addAll(widget.existingList!.games);
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userVM = context.watch<UserViewModel>();
    
    final List<Game> allGames = [...userVM.diary.map((e) => e.game), ...userVM.toPlay];
    final Map<String, Game> uniqueGames = {for (var g in allGames) g.id: g};
    var sortedGames = uniqueGames.values.toList();
    sortedGames.sort((a, b) => a.title.toLowerCase().compareTo(b.title.toLowerCase()));

    if (_searchQuery.isNotEmpty) {
      sortedGames = sortedGames.where((g) => g.title.toLowerCase().contains(_searchQuery.toLowerCase())).toList();
    }
    
    return Scaffold(
      backgroundColor: AppColors.voidBlack,
      appBar: AppBar(
        backgroundColor: AppColors.voidBlack,
        title: Text(widget.existingList == null ? "CREATE NEW LIST" : "EDIT LIST", 
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        actions: [
          if (widget.existingList != null)
            IconButton(
              icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
              onPressed: () => _showDeleteConfirmation(context, userVM),
            ),
          TextButton(
            onPressed: (_titleController.text.trim().isEmpty || _selectedGames.isEmpty)
                ? null
                : () async {
                    try {
                      if (widget.existingList == null) {
                        await userVM.createList(
                          _titleController.text.trim(), 
                          _descController.text.trim(), 
                          _isPublic, 
                          _selectedGames
                        );
                      } else {
                        await userVM.updateList(
                          widget.existingList!.id,
                          _titleController.text.trim(), 
                          _descController.text.trim(), 
                          _isPublic, 
                          _selectedGames
                        );
                      }
                      if (mounted) Navigator.pop(context);
                    } catch (e) {
                      debugPrint("Save error: $e");
                    }
                  },
            child: Text("SAVE", style: TextStyle(
              color: (_titleController.text.trim().isEmpty || _selectedGames.isEmpty) 
                  ? AppColors.charcoal 
                  : AppColors.cyberCyan, 
              fontWeight: FontWeight.bold
            )),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _titleController,
              onChanged: (_) => setState(() {}),
              style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
              decoration: const InputDecoration(hintText: "List Title", border: InputBorder.none, filled: false),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _descController,
              style: const TextStyle(color: Colors.white70),
              decoration: const InputDecoration(hintText: "Description (optional)", border: InputBorder.none, filled: false),
              maxLines: 2,
            ),
            const SizedBox(height: 8),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text("Public List", style: TextStyle(color: Colors.white, fontSize: 14)),
              subtitle: const Text("Visible to everyone in Home", style: TextStyle(color: AppColors.charcoal, fontSize: 11)),
              value: _isPublic,
              activeColor: AppColors.cyberCyan,
              onChanged: (v) => setState(() => _isPublic = v),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("SELECT GAMES", style: TextStyle(color: AppColors.cyberCyan, fontWeight: FontWeight.bold, fontSize: 14)),
                Text("${_selectedGames.length} selected", style: const TextStyle(color: AppColors.charcoal, fontSize: 12)),
              ],
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _searchController,
              onChanged: (v) => setState(() => _searchQuery = v),
              style: const TextStyle(color: Colors.white, fontSize: 14),
              decoration: InputDecoration(
                hintText: "Search in your library...",
                prefixIcon: const Icon(Icons.search, color: AppColors.charcoal, size: 20),
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
              ),
            ),
            const SizedBox(height: 16),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: sortedGames.length,
              itemBuilder: (context, index) {
                final game = sortedGames[index];
                final isSelected = _selectedGames.any((g) => g.id == game.id);
                return CheckboxListTile(
                  contentPadding: EdgeInsets.zero,
                  secondary: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: game.imageUrl != null 
                        ? Image.network(game.imageUrl!, width: 35, height: 50, fit: BoxFit.cover)
                        : Container(width: 35, height: 50, color: AppColors.charcoal),
                  ),
                  title: Text(game.title, style: const TextStyle(color: Colors.white, fontSize: 14)),
                  value: isSelected,
                  activeColor: AppColors.cyberCyan,
                  onChanged: (v) {
                    setState(() {
                      if (v == true) {
                        _selectedGames.add(game);
                      } else {
                        _selectedGames.removeWhere((g) => g.id == game.id);
                      }
                    });
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context, UserViewModel userVM) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.gunmetal,
        title: const Text("Delete List", style: TextStyle(color: Colors.white)),
        content: const Text("Are you sure you want to permanently delete this list?", style: TextStyle(color: Colors.white70)),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("CANCEL")),
          TextButton(
            onPressed: () async {
              final navigator = Navigator.of(context);
              await userVM.deleteList(widget.existingList!.id);
              if (mounted) {
                navigator.pop();
                navigator.pop();
                if (navigator.canPop()) {
                  navigator.pop();
                }
              }
            },
            child: const Text("DELETE", style: TextStyle(color: Colors.redAccent)),
          ),
        ],
      ),
    );
  }
}
