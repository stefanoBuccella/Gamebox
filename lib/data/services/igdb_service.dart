import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class IgdbService {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: 'https://api.igdb.com/v4',
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
  ));
  
  String? get _clientId => dotenv.env['IGDB_CLIENT_ID'];
  String? get _clientSecret => dotenv.env['IGDB_CLIENT_SECRET'];
  
  String? _accessToken;

  Future<void> _authenticate() async {
    if (_clientId == null || _clientSecret == null || _clientId!.isEmpty || _clientSecret!.isEmpty) {
      debugPrint('ERRORE: Chiavi IGDB mancanti nel file .env');
      return;
    }

    try {
      debugPrint('Autenticazione IGDB in corso...');
      final response = await Dio().post(
        'https://id.twitch.tv/oauth2/token',
        queryParameters: {
          'client_id': _clientId,
          'client_secret': _clientSecret,
          'grant_type': 'client_credentials',
        },
      );
      _accessToken = response.data['access_token'];
      debugPrint('Autenticazione IGDB completata con successo');
    } catch (e) {
      debugPrint('Errore durante l\'autenticazione IGDB: $e');
    }
  }

  Future<List<dynamic>> searchGames(String query) async {
    debugPrint('Ricerca gioco: $query');
    
    if (_clientId == null || _clientId!.isEmpty) {
      debugPrint('Client ID mancante, utilizzo dati MOCK');
      return _getMockGames();
    }

    if (_accessToken == null) {
      await _authenticate();
    }

    if (_accessToken == null) {
      debugPrint('Access Token non disponibile, utilizzo dati MOCK');
      return _getMockGames();
    }

    try {
      final response = await _dio.post(
        '/games',
        data: 'search "$query"; fields name, summary, cover.url, involved_companies.company.name, platforms.name, total_rating, first_release_date; limit 10;',
        options: Options(
          headers: {
            'Client-ID': _clientId,
            'Authorization': 'Bearer $_accessToken',
          },
        ),
      );
      debugPrint('Risposta IGDB ricevuta: ${response.data.length} risultati');
      return response.data;
    } catch (e) {
      debugPrint('Errore durante la chiamata IGDB: $e');
      return _getMockGames();
    }
  }

  List<dynamic> _getMockGames() {
    return [
      {
        'id': 1,
        'name': 'The Last of Us Part II (Mock)',
        'cover': {'url': '//images.igdb.com/igdb/image/upload/t_thumb/co1r7h.jpg'},
        'summary': 'In questa intensa avventura, Ellie intraprende un viaggio brutale alla ricerca di vendetta.',
        'total_rating': 4.5 * 20,
        'platforms': [{'name': 'PS4'}]
      },
      {
        'id': 2,
        'name': 'Ghost of Tsushima (Mock)',
        'cover': {'url': '//images.igdb.com/igdb/image/upload/t_thumb/co27p1.jpg'},
        'summary': 'Un samurai deve scegliere tra il codice e la libertà per salvare la sua isola.',
        'total_rating': 4.0 * 20,
        'platforms': [{'name': 'PS4'}]
      }
    ];
  }
}
