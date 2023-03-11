import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_example/wishlist/wishlist.dart';

final wishlistCNProvider = ChangeNotifierProvider(
  (ref) => WishlistChangeNotifier(ref),
);

enum LoadingState { progress, success, error }

class WishlistChangeNotifier extends ChangeNotifier {
  WishlistChangeNotifier(Ref ref)
      : _api = ref.read(repositoryProvider('8l3xEV0LlB'));

  final WishlistRepository _api;
  final games = <BoardGame>[];
  LoadingState loading = LoadingState.progress;

  void reloadGames() {
    loading = LoadingState.progress;
    notifyListeners();

    loadGames();
  }

  Future<void> loadGames() async {
    try {
      final response = await _api.getBoardGames();
      games.addAll(response);
      loading = LoadingState.success;
    } catch (_) {
      loading = LoadingState.error;
    }
    notifyListeners();
  }
}
