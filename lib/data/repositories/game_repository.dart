import '../../domain/models/game.dart';
import '../services/supabase_service.dart';

class GameRepository {
  Future<List<Game>> getHomeGames() async {
    // Simuliamo un ritardo di caricamento
    await Future.delayed(const Duration(milliseconds: 500));

    // Restituiamo una lista vuota per lo sprint attuale
    return [];
  }
}