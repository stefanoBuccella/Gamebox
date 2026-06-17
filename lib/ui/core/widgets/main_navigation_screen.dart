import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../home/widgets/home_screen.dart';
import '../../profile/widgets/profile_screen.dart';
import '../../search/widgets/game_search_screen.dart';
import '../theme/app_colors.dart';
import '../view_model/navigation_view_model.dart';

class MainNavigationScreen extends StatelessWidget {
  const MainNavigationScreen({super.key});

  final List<Widget> _screens = const [
    HomeScreen(),
    GameSearchScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final navVM = context.watch<NavigationViewModel>();

    return Scaffold(
      body: _screens[navVM.selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.gunmetal,
        currentIndex: navVM.selectedIndex,
        selectedItemColor: AppColors.cyberCyan,
        unselectedItemColor: AppColors.pureWhite,
        onTap: (index) => navVM.setIndex(index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
