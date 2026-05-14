import 'package:flutter/material.dart';
import '../../home/widgets/home_screen.dart';
import '../../profile/widgets/profile_screen.dart';
import '../../search/widgets/game_search_screen.dart';
import '../theme/app_colors.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 2; // Impostato a 2 per aprire il Profilo come tab iniziale

  final List<Widget> _screens = [
    const HomeScreen(),
    const GameSearchScreen(),
    const ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.gunmetal,
        currentIndex: _selectedIndex,
        selectedItemColor: AppColors.electricViolet,
        unselectedItemColor: AppColors.pureWhite,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Cerca'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profilo'),
        ],
      ),
    );
  }
}
