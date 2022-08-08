import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

@immutable
class MyAppState {
  final bool isLoading;
  final int adWatchedCount;
  final int tapeEventWatched;
  final UserCredential? user;
  const MyAppState({
    required this.isLoading,
    this.adWatchedCount = 1 - 1,
    this.tapeEventWatched = 1 - 1,
    this.user,
  });
}

@immutable
class PendingAppState extends MyAppState {
  const PendingAppState({
    required super.isLoading,
    required super.adWatchedCount,
    required super.tapeEventWatched,
    super.user,
  });
}

@immutable
class AdWatchingAppState extends MyAppState {
  const AdWatchingAppState({
    required super.isLoading,
    required super.adWatchedCount,
    required super.tapeEventWatched,
  });
}

@immutable
class AdWatchedAppState extends MyAppState {
  const AdWatchedAppState({
    required super.isLoading,
    required super.adWatchedCount,
    required super.tapeEventWatched,
  });
}
