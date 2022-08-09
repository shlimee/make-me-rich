import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

@immutable
class MyAppState {
  final bool isLoading;
  late int adWatchedCount;
  final int tapeEventWatched;
  late User? user;
  MyAppState({
    required this.isLoading,
    this.adWatchedCount = 1 - 1,
    this.tapeEventWatched = 1 - 1,
    this.user,
  });
}

@immutable
class PendingAppState extends MyAppState {
  PendingAppState({
    required super.isLoading,
    required super.adWatchedCount,
    required super.tapeEventWatched,
    super.user,
  });
}

@immutable
class AdWatchingAppState extends MyAppState {
  AdWatchingAppState({
    required super.isLoading,
    required super.adWatchedCount,
    required super.tapeEventWatched,
    super.user,
  });
}

@immutable
class AdWatchedAppState extends MyAppState {
  AdWatchedAppState({
    required super.isLoading,
    required super.adWatchedCount,
    required super.tapeEventWatched,
    super.user,
  });
}
