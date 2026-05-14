import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'data/repositories/game_repository.dart';
import 'ui/home/view_model/home_view_model.dart';
import 'ui/profile/view_model/user_view_model.dart';
import 'ui/core/widgets/main_navigation_screen.dart';
import 'ui/core/theme/app_colors.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) => GameRepository()),
        ChangeNotifierProvider(
          create: (context) => HomeViewModel(context.read<GameRepository>()),
        ),
        ChangeNotifierProvider(create: (_) => UserViewModel()),
      ],
      child: MaterialApp(
        title: 'GameBox V2', // Titolo cambiato per verifica
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          brightness: Brightness.dark,
          primaryColor: AppColors.electricViolet,
          scaffoldBackgroundColor: AppColors.voidBlack,
        ),
        home: const MainNavigationScreen(),
      ),
    );
  }
}
