import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_example/wishlist/wishlist.dart';

part 'async_notifier.g.dart';

@riverpod
List<BoardGame> wishlistedGames(WishlistedGamesRef ref) {
  final state = ref.watch(wishlistAsyncNotifierProvider).value;

  if (state == null) {
    return [];
  }

  return state.wishlist
      .map<BoardGame>(
        (id) => state.games.singleWhere(
          (game) => game.id == id,
        ),
      )
      .toList();
}

@riverpod
class WishlistAsyncNotifier extends _$WishlistAsyncNotifier {
  WishlistRepository get _api => ref.read(repositoryProvider('8l3xEV0LlB'));

  @override
  Future<WishlistState> build() => _loadGames();

  Future<WishlistState> _loadGames() async {
    final response = await _api.getBoardGames();
    return WishlistState(games: response);
  }

  Future<void> reloadGames() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _loadGames());
  }

  void addToWishlist(String id) {
    state = AsyncValue.data(state.value!.copyWith(
      wishlist: {...state.value!.wishlist, id},
    ));
  }

  bool isWishlisted(String id) => state.value!.wishlist.contains(id);

  void removeFromWishlist(String id) {
    state = AsyncValue.data(state.value!.copyWith(
      wishlist: {...state.value!.wishlist..remove(id)},
    ));
  }
}
