import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'ad_helper.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Mobile Ads Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage();

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  BannerAd _ad;
  InterstitialAd _interstitialAd;
  bool isLoaded;

  @override
  void initState() {
    super.initState();

    _interstitialAd = InterstitialAd(
      adUnitId: AdHelper.interstitialAdUnitId,
      request: AdRequest(),
      listener: AdListener(
        onAdClosed: (ad) {
          print("Closed Ad");
        },
        onAdOpened: (ad) {
          print("Opened Ad");
        },
      ),
    );

    _interstitialAd.load();

    _ad = BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      request: AdRequest(),
      size: AdSize.banner,
      listener: AdListener(
        onAdLoaded: (_) {
          setState(
            () {
              isLoaded = true;
            },
          );
        },
        onAdFailedToLoad: (_, error) {
          print('Ad Failed to Load with Error: $error');
        },
      ),
    );

    _ad.load();
  }

  @override
  void dispose() {
    _ad?.dispose();
    _interstitialAd?.dispose();
    super.dispose();
  }

  Widget checkForAd() {
    if (isLoaded == true) {
      return Container(
        child: AdWidget(
          ad: _ad,
        ),
        width: _ad.size.width.toDouble(),
        height: _ad.size.height.toDouble(),
        alignment: Alignment.center,
      );
    } else {
      return CircularProgressIndicator();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/flutterbg.jpeg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Flutter Mobile Ads Demo',
                style: TextStyle(fontSize: 30),
              ),
              //checkForAd(),
              OutlinedButton(
                child: Text("Interstitial Ad"),
                onPressed: () {
                  _interstitialAd.show();
                },
              ),
              Text(
                'Most of our ads will go right above this text here',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
