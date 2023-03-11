import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_example/wishlist/wishlist.dart';

class WishlistApp extends ConsumerStatefulWidget {
  const WishlistApp({required this.title, super.key});

  final String title;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _WishlistAppState();
}

class _WishlistAppState extends ConsumerState<WishlistApp> {
  void _launchWishlistedView() {
    Navigator.push(
      context,
      PageRouteBuilder(
          transitionsBuilder: (_, animation, __, child) {
            return SlideTransition(
              position: Tween(
                begin: const Offset(0, 1),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          },
          pageBuilder: (_, __, ___) => const WishlistedView()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(wishlistAsyncNotifierProvider);

    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: state.when(
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (error, stackTrace) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text('Problem loading games'),
              const SizedBox(height: 10),
              OutlinedButton(
                onPressed: () {
                  ref
                      .read(wishlistAsyncNotifierProvider.notifier)
                      .reloadGames();
                },
                child: const Text('Try again'),
              ),
            ],
          ),
        ),
        data: (data) => GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemCount: data.games.length,
          itemBuilder: (context, index) {
            final game = data.games[index];

            return Card(
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image.network(
                      game.imageUrl,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  Positioned.fill(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.blueGrey,
                          ],
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          game.name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: InkWell(
                      onTap: () {
                        final vm =
                            ref.read(wishlistAsyncNotifierProvider.notifier);

                        if (vm.isWishlisted(game.id)) {
                          vm.removeFromWishlist(game.id);
                        } else {
                          vm.addToWishlist(game.id);
                        }
                      },
                      child: Align(
                        child: Icon(
                          Icons.favorite,
                          color: data.wishlist.contains(game.id)
                              ? Colors.redAccent
                              : Colors.black38,
                          size: 60,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      floatingActionButton: state.value == null
          ? null
          : Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: FloatingActionButton(
                    onPressed: _launchWishlistedView,
                    tooltip: 'View Wishlist',
                    child: const Icon(Icons.auto_fix_high_outlined),
                  ),
                ),
                if (state.value?.wishlist.isNotEmpty == true)
                  Positioned(
                    right: -4,
                    bottom: 40,
                    child: CircleAvatar(
                      backgroundColor: Colors.tealAccent,
                      radius: 12,
                      child: Text(
                        state.value!.wishlist.length.toString(),
                      ),
                    ),
                  ),
              ],
            ),
    );
  }
}
