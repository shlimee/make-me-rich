import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:make_me_rich/states.dart';
import 'package:make_me_rich/styles.dart';

import 'ad_helper.dart';
import 'events.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({
    Key? key,
    required Bloc bloc,
    required MyAppState appState,
  })  : _bloc = bloc,
        _appState = appState,
        super(key: key);

  final Bloc _bloc;
  final MyAppState _appState;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 15,
        ),
        if (_appState.user == null && !_appState.isLoading)
          OutlinedButton(
              onPressed: () {
                _bloc.add(LoginEvent());
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.g_mobiledata),
                  Text(
                    'Log in with Google',
                    style: TextStyle(fontSize: 19),
                  ),
                ],
              )),
        if (_appState.user == null && _appState.isLoading)
          const CircularProgressIndicator(),
        if (_appState.user != null)
          Text(
            "Welcome ${_appState.user?.displayName?.split(' ')[1]}!",
            style: Styles.h4,
          ),
        const SizedBox(
          height: 25,
        ),
        Opacity(
          opacity: _appState.user != null ? 1 : 0.3,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(children: [
                    const Center(child: Text('Ads impressions')),
                    Text(
                      _appState.adWatchedCount.toString(),
                      style: Styles.h2,
                    )
                  ]),
                  Column(children: const [
                    Center(child: Text('Your rank')),
                    Text(
                      '#12',
                      style: Styles.h2,
                    ),
                  ]),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(children: [
                    const Center(child: Text('You made me\napproximately')),
                    Text(
                      '\$${AdHelper.convertAdImpressionToRevenue(_appState.adWatchedCount)}',
                      style: Styles.h1,
                    ),
                  ]),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 55),
        OutlinedButton(
          onPressed: () {
            _bloc.add(AdWatchingEvent());
          },
          style: OutlinedButton.styleFrom(
            minimumSize: Size.fromHeight(44),
            backgroundColor: Colors.amber,
          ),
          child: const Text('Watch ad', style: TextStyle(color: Colors.black)),
        ),
        if (_appState.user != null)
          OutlinedButton(
            onPressed: () {
              _bloc.add(SignOutEvent());
            },
            style: OutlinedButton.styleFrom(
                minimumSize: const Size.fromHeight(44)),
            child: const Text('Sign out'),
          ),
        const SizedBox(
          height: 15,
        ),
      ],
    );
  }
}
