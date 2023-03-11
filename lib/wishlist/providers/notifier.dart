import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_example/wishlist/wishlist.dart';

final wishlistNotifierProvider =
    NotifierProvider<WishlistNotifier, WishlistState>(
  () => WishlistNotifier(),
);

class WishlistNotifier extends Notifier<WishlistState> {
  WishlistRepository get _api => ref.read(repositoryProvider('8l3xEV0LlB'));

  @override
  WishlistState build() => const WishlistState();

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
