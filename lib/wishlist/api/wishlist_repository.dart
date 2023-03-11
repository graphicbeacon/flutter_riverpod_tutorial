import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_example/wishlist/wishlist.dart';

final repositoryProvider = Provider.family<WishlistRepository, String>(
  (_, clientId) => WishlistRepository(clientId),
);

class WishlistRepository {
  WishlistRepository(this.clientId);

  final String clientId;

  Dio get _client => Dio(
        BaseOptions(
          baseUrl: 'https://api.boardgameatlas.com/api',
          queryParameters: {'client_id': clientId},
        ),
      );

  Future<List<BoardGame>> getBoardGames() async {
    final result = await _client.get('/search?limit=20');
    final games = result.data['games'];
    return games.map<BoardGame>((game) => BoardGame.fromJson(game)).toList();
  }
}
