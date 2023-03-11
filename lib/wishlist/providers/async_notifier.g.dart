// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'async_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$wishlistedGamesHash() => r'0a81cdf390faca8cb3e5ee0d6909d6ae0138dbbb';

/// See also [wishlistedGames].
@ProviderFor(wishlistedGames)
final wishlistedGamesProvider = AutoDisposeProvider<List<BoardGame>>.internal(
  wishlistedGames,
  name: r'wishlistedGamesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$wishlistedGamesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef WishlistedGamesRef = AutoDisposeProviderRef<List<BoardGame>>;
String _$wishlistAsyncNotifierHash() =>
    r'8a2e0950d4a0e0c4efc777c724893453e8dd2e80';

/// See also [WishlistAsyncNotifier].
@ProviderFor(WishlistAsyncNotifier)
final wishlistAsyncNotifierProvider = AutoDisposeAsyncNotifierProvider<
    WishlistAsyncNotifier, WishlistState>.internal(
  WishlistAsyncNotifier.new,
  name: r'wishlistAsyncNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$wishlistAsyncNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$WishlistAsyncNotifier = AutoDisposeAsyncNotifier<WishlistState>;
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
