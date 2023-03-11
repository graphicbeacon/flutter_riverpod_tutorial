import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_example/wishlist/wishlist.dart';

final wishlistStateProvider =
    StateNotifierProvider<WishlistStateNotifier, WishlistState>(
  (ref) => WishlistStateNotifier(ref),
);

@immutable
class WishlistState {
  const WishlistState({
    this.games = const [],
    this.wishlist = const {},
    this.loading = LoadingState.progress,
  });

  final List<BoardGame> games;
  final Set<String> wishlist;
  final LoadingState loading;

  WishlistState copyWith({
    List<BoardGame>? games,
    Set<String>? wishlist,
    LoadingState? loading,
  }) =>
      WishlistState(
        games: games ?? this.games,
        wishlist: wishlist ?? this.wishlist,
        loading: loading ?? this.loading,
      );
}

class WishlistStateNotifier extends StateNotifier<WishlistState> {
  WishlistStateNotifier(Ref ref)
      : _api = ref.read(repositoryProvider('8l3xEV0LlB')),
        super(const WishlistState());

  final WishlistRepository _api;

  Future<void> loadGames() async {
    try {
      final response = await _api.getBoardGames();

      state = state.copyWith(
        games: response,
        loading: LoadingState.success,
      );
    } catch (_) {
      state = state.copyWith(
        loading: LoadingState.error,
      );
    }
  }

  Future<void> reloadGames() async {
    state = state.copyWith(
      loading: LoadingState.progress,
    );
    loadGames();
  }
}
