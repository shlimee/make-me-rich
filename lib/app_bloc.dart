import 'dart:math';
import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart'
    show FirebaseAuth, GoogleAuthProvider, UserCredential;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:make_me_rich/events.dart';
import 'package:make_me_rich/firebase_options.dart';
import 'package:make_me_rich/states.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'ad_helper.dart';

class AppBloc extends Bloc<AppEvent, MyAppState> {
  RewardedAd? _rewardedAd;
  final db = FirebaseFirestore.instance;

  AppBloc()
      : super(const PendingAppState(
            isLoading: false, tapeEventWatched: 1 - 1, adWatchedCount: 1 - 1)) {
    on<LoginEvent>((event, emit) async {
      final userCredentials = await signInWithGoogle();
      if (userCredentials != null) {
        add(LoginSuccessfulEvent(credential: userCredentials));
      } else {
        add(LoginFailedEvent());
      }
    });
    on<LoginSuccessfulEvent>((event, emit) async {
      debugPrint('Login successful!');
      debugPrint(event.credential.user?.displayName);
      emit(PendingAppState(
          isLoading: false,
          adWatchedCount: state.adWatchedCount,
          tapeEventWatched: state.tapeEventWatched,
          user: event.credential));
    });
    on<LoginFailedEvent>((event, emit) async {
      debugPrint('Login failed!');
    });
    on<AdCreatedEvent>((event, emit) async {});
    on<AdClickedEvent>((event, emit) async {});
    on<AdWatchedEvent>((event, emit) async {
      debugPrint('Ad impression done!');

      int newAdWatchedCount = state.adWatchedCount + 1;
      debugPrint(state.adWatchedCount.toString());
      emit(AdWatchedAppState(
          isLoading: false,
          adWatchedCount: newAdWatchedCount,
          tapeEventWatched: state.tapeEventWatched));
      debugPrint(state.adWatchedCount.toString());
    });
    on<AdWatchingEvent>((event, emit) async {
      await _loadRewardedAd();
    });
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn(
      clientId: DefaultFirebaseOptions.currentPlatform.iosClientId,
    ).signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<void> _loadRewardedAd() async {
    await RewardedAd.load(
      adUnitId: AdHelper.rewardedAdUnitId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          ad.show(onUserEarnedReward: (a, b) {
            add(AdWatchedEvent());
          });
          ad.fullScreenContentCallback =
              FullScreenContentCallback(onAdDismissedFullScreenContent: (ad) {
            _rewardedAd = null;
          }, onAdImpression: (ad) {
            debugPrint('Ad hase been impressioned!');
          });
          ad.onPaidEvent = (a, b, c, d) => {add(AdWatchedEvent())};
          debugPrint(ad.toString());
          _rewardedAd = ad;
        },
        onAdFailedToLoad: (err) {
          print('Failed to load a rewarded ad: ${err.message}');
        },
      ),
    );
  }

  @override
  Future<void> close() async {
    _rewardedAd?.dispose();
    super.close();
  }
}
