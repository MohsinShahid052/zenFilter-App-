import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class AdBlocker extends StatefulWidget {
  const AdBlocker({Key? key}) : super(key: key);

  @override
  State<AdBlocker> createState() => _MyAppState();
}

class _MyAppState extends State<AdBlocker> {
  final GlobalKey webViewKey = GlobalKey();
  final List<ContentBlocker> contentBlockers = [];
  InAppWebViewController? webViewController;

  @override
  void initState() {
    super.initState();
    final adUrlFilters = [
      // Add your ad URL filters here
      ".*.doubleclick.net/.*",
      ".*.ads.pubmatic.com/.*",
      ".*.googlesyndication.com/.*",
      ".*.google-analytics.com/.*",
      ".*.adservice.google.*/.*",
      ".*.adbrite.com/.*",
      ".*.exponential.com/.*",
      ".*.quantserve.com/.*",
      ".*.scorecardresearch.com/.*",
      ".*.zedo.com/.*",
      ".*.adsafeprotected.com/.*",
      ".*.teads.tv/.*",
      ".*.outbrain.com/.*",
      ".*.googleadservices.com/.*",
      ".*.googlesyndication.com/.*",
      ".*daraz.*banner.*",
      // Facebook Audience Network URLs
      ".*.facebook.com/.*",
      ".*.fbcdn.net/.*",

      // Unity Ads URLs
      ".*.unity3d.com/.*",
      ".*.unityads.unity3d.com/.*",

      // AppLovin Max Ads URLs
      ".*.applovin.com/.*",
      ".*.aplovin.com/.*",

      //Youtube
      ".*.youtube.com*"
          ".*.sponsor.com/.*",
      ".*.sponsorads.com/.*",
    ];

    for (final adUrlFilter in adUrlFilters) {
      contentBlockers.add(ContentBlocker(
          trigger: ContentBlockerTrigger(
            urlFilter: adUrlFilter,
          ),
          action: ContentBlockerAction(
            type: ContentBlockerActionType.BLOCK,
          )));
    }

    contentBlockers.add(ContentBlocker(
        trigger: ContentBlockerTrigger(
          urlFilter: ".*",
        ),
        action: ContentBlockerAction(
            type: ContentBlockerActionType.CSS_DISPLAY_NONE,
            selector:
                ".banner, .video-ads, .banners, .ads, .ad, .advert, .popup-banner, .acceptable-ads, .acceptable-banner")));
  }

  @override
  Widget build(BuildContext context) {
    var scaffold = Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Stack(
                children: [
                  InAppWebView(
                    key: webViewKey,
                    initialUrlRequest: URLRequest(
                      url: WebUri(
                        'https://www.google.com/search?safe=active',
                      ),
                    ),
                    initialSettings: InAppWebViewSettings(
                      contentBlockers: contentBlockers,
                      javaScriptCanOpenWindowsAutomatically: false,
                    ),
                    onWebViewCreated: (controller) {
                      webViewController = controller;
                    },
                    onCreateWindow: (controller, createWindowRequest) async {
                      return false;
                    },
                    onLoadStop: (InAppWebViewController controller, Uri? url) async {
                      await controller.evaluateJavascript(source: """
                        (function() {
                          var elements = document.getElementsByClassName('G0jgYd-twKXnc-T5cp6c');
                          for(var i = 0; i < elements.length; i++) {
                            elements[i].style.display = 'none';
                          }
                        })();
                      """);
                    },
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Colors.white,
                    width: 2.0, // Customize the color and width as needed
                  ),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.blue, // Customize the color as needed
                      ),
                      onPressed: () async {
                        if (await webViewController?.canGoBack() ?? false) {
                          webViewController?.goBack();
                        }
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.arrow_forward,
                        color: Colors.blue, // Customize the color as needed
                      ),
                      onPressed: () async {
                        if (await webViewController?.canGoForward() ?? false) {
                          webViewController?.goForward();
                        }
                      },
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.refresh,
                        color: Colors.blue, // Customize the color as needed
                      ),
                      onPressed: () async {
                        webViewController?.reload();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
    return scaffold;
  }
}

