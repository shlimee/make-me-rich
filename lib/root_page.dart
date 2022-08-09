import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:make_me_rich/app_bloc.dart';
import 'package:make_me_rich/home_screen.dart';
import 'package:make_me_rich/states.dart';
import 'package:make_me_rich/styles.dart';

import 'ad_helper.dart';
import 'dashboard.dart';
import 'events.dart';

class RootPage extends StatefulWidget {
  const RootPage({Key? key}) : super(key: key);

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  late Bloc _bloc;

  BannerAd? _bannerAd;

  int _currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<AppBloc>(context);
    BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      request: const AdRequest(),
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
                  getScreen(
                      index: _currentPageIndex, bloc: _bloc, state: appState),
                  if (_bannerAd != null)
                    Align(
                      alignment: Alignment.topCenter,
                      child: SizedBox(
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
          BottomNavigationBarItem(icon: Icon(Icons.info), label: 'About'),
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

  Widget getScreen({index: int, bloc: Bloc, state: MyAppState}) {
    List<Widget> widgets = [
      Dashboard(bloc: bloc, appState: state),
      HomeScreen(),
    ];
    return widgets[index];
  }
}
