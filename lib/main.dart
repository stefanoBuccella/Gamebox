import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'data/repositories/game_repository.dart';
import 'data/repositories/user_repository.dart';
import 'data/services/supabase_service.dart';
import 'ui/auth/view_model/auth_view_model.dart';
import 'ui/home/view_model/home_view_model.dart';
import 'ui/profile/view_model/user_view_model.dart';
import 'ui/auth/widgets/login_screen.dart';
import 'ui/core/widgets/main_navigation_screen.dart';
import 'ui/core/theme/app_colors.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await dotenv.load(fileName: ".env");
  } catch (e) {
    debugPrint("ERRORE .ENV: $e");
  }

  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL'] ?? 'https://tybmqbtaecamowuuvhmi.supabase.co',
    anonKey: dotenv.env['SUPABASE_ANON_KEY'] ?? '',
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) => GameRepository()),
        Provider(create: (_) => SupabaseService()),
        ProxyProvider<SupabaseService, UserRepository>(
          update: (_, service, __) => UserRepository(service),
        ),
        
        ChangeNotifierProvider(
          create: (context) => AuthViewModel(context.read<UserRepository>()),
        ),
        ChangeNotifierProvider(
          create: (context) => HomeViewModel(context.read<GameRepository>()),
        ),
        ChangeNotifierProvider(
          create: (context) => UserViewModel(context.read<UserRepository>(), Supabase.instance.client),
        ),
      ],
      child: MaterialApp(
        title: 'GameBox',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          brightness: Brightness.dark,
          primaryColor: AppColors.electricViolet,
          scaffoldBackgroundColor: AppColors.voidBlack,
          inputDecorationTheme: const InputDecorationTheme(
            filled: true,
            fillColor: AppColors.gunmetal,
            border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12)), borderSide: BorderSide.none),
            hintStyle: TextStyle(color: AppColors.charcoal),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.electricViolet,
              foregroundColor: AppColors.pureWhite,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
        ),
        home: const AuthWrapper(),
      ),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AuthState>(
      stream: Supabase.instance.client.auth.onAuthStateChange,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }
        if (snapshot.data?.session != null) return const MainNavigationScreen();
        return const LoginScreen();
      },
    );
  }
}
