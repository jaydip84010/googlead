import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await MobileAds.instance.initialize();
  // RequestConfiguration configuration =
  // RequestConfiguration(testDeviceIds: ["71C4E5B58F6EDD39D33737C347621A72"],tagForChildDirectedTreatment: TagForChildDirectedTreatment.unspecified);
  // MobileAds.instance.updateRequestConfiguration(configuration);
  runApp(MaterialApp(
    home: Googlead(),
    debugShowCheckedModeBanner: false,
  ));
}

class Googlead extends StatefulWidget {
  const Googlead({Key? key}) : super(key: key);

  @override
  State<Googlead> createState() => _GoogleadState();
}

class _GoogleadState extends State<Googlead> {
  NativeAd? _ad;
  bool isAdLoaded = false;

  @override
  void initState() {
    super.initState();
    _ad = NativeAd(
      adUnitId: 'ca-app-pub-3940256099942544/2247696110',
      factoryId: 'listTileMedium',
      request: AdRequest(),
      listener: NativeAdListener(
        // Called when an ad is successfully received.
        onAdLoaded: (Ad ad) {
          var _add = ad as NativeAd;
          print("**** AD ***** ${_add.responseInfo}");
          setState(() {
            _ad = _add;
            isAdLoaded = true;
          });
        },
        // Called when an ad request failed.
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          // Dispose the ad here to free resources.
          ad.dispose();
          print('Ad load failed (code=${error.code} message=${error.message})');
        },
        // Called when an ad opens an overlay that covers the screen.
        onAdOpened: (Ad ad) => print('Ad opened.'),
        // Called when an ad removes an overlay that covers the screen.
        onAdClosed: (Ad ad) => print('Ad closed.'),
        // Called when an impression occurs on the ad.
        onAdImpression: (Ad ad) => print('Ad impression.'),
        // Called when a click is recorded for a NativeAd.
        onAdClicked: (Ad ad) => print('Ad clicked.'),
      ),
    );

    _ad!.load();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _ad != null && isAdLoaded
            ? Container(
                height: 300.0,
                alignment: Alignment.center,
                child: AdWidget(ad: _ad!),
              )
            : Container(
                height: 200,width:300,color: Colors.green,
              ),
      ),
    );
  }
}
