import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:make_me_rich/app_bloc.dart';
import 'package:make_me_rich/states.dart';
import 'package:make_me_rich/styles.dart';

import 'ad_helper.dart';
import 'events.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Bloc _bloc;

  BannerAd? _bannerAd;

  int _currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<AppBloc>(context);
    BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      request: AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            _bannerAd = ad as BannerAd;
            if (_bannerAd != null) _bloc.add(AdCreatedEvent());
          });
        },
        onPaidEvent: (a, b, c, d) {
          _bloc.add(AdWatchedEvent());
        },
        onAdImpression: (ad) {
          _bloc.add(AdWatchedEvent());
        },
        onAdFailedToLoad: (ad, err) {
          print('Failed to load a banner ad: ${err.message}');
          ad.dispose();
        },
      ),
    ).load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Make me Rich!')),
      floatingActionButton:
          FloatingActionButton(onPressed: () {}, child: const Icon(Icons.add)),
      body: BlocConsumer<AppBloc, MyAppState>(
          listener: (context, appState) {},
          builder: (context, appState) {
            return Center(
              child: Column(
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  if (appState.user == null)
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
                  if (appState.user != null)
                    Text(
                      "Welcome ${appState.user?.displayName?.split(' ')[1]}!",
                      style: Styles.h4,
                    ),
                  const SizedBox(
                    height: 25,
                  ),
                  Opacity(
                    opacity: appState.user != null ? 1 : 0.3,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(children: [
                              Center(child: Text('Ads impressions')),
                              Text(
                                appState.adWatchedCount.toString(),
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
                              Center(child: Text('You made me\napproximately')),
                              Text(
                                '\$${AdHelper.convertAdImpressionToRevenue(appState.adWatchedCount)}',
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
                    child: Text('Watch ad'),
                    style: OutlinedButton.styleFrom(
                        minimumSize: Size.fromHeight(44)),
                  ),
                  if (appState.user != null)
                    OutlinedButton(
                      onPressed: () {
                        _bloc.add(SignOutEvent());
                      },
                      child: const Text('Sign out'),
                      style: OutlinedButton.styleFrom(
                          minimumSize: const Size.fromHeight(44)),
                    ),
                  const SizedBox(
                    height: 15,
                  ),
                  if (_bannerAd != null)
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        width: _bannerAd!.size.width.toDouble(),
                        height: _bannerAd!.size.height.toDouble(),
                        child: AdWidget(ad: _bannerAd!),
                      ),
                    ),
                ],
              ),
            );
          }),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_box_rounded), label: 'Profile'),
        ],
        onTap: (ind) {
          setState(() {
            _currentPageIndex = ind;
          });
        },
        currentIndex: _currentPageIndex,
      ),
    );
  }
}
