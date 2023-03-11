import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_example/wishlist/wishlist.dart';

final wishlistFutureProvider = FutureProvider<List<BoardGame>>((ref) {
  final repository = ref.read(repositoryProvider('8l3xEV0LlBc'));
  return repository.getBoardGames();
});
