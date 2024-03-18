import 'dart:math';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:zenFilter/internetConnect/internetNotConnected.dart';
import 'package:zenFilter/internetConnect/adblocker.dart';

class CheckInternetConnectionWidget extends StatelessWidget {
  final AsyncSnapshot<ConnectivityResult> snapshot;
  final Widget widget;

  const CheckInternetConnectionWidget({
    Key? key,
    required this.snapshot,
    required this.widget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (snapshot.connectionState) {
      case ConnectionState.active:
        final state = snapshot.data!;
        switch (state) {
          case ConnectivityResult.none:
            return Center(child: Text('Not connected', style: TextStyle(fontFamily: 'Montserrat')));
          default:
            return widget;
        }
      default:
        return Container();
    }
  }
}

class InternetConnectivityScreen extends StatelessWidget {
  InternetConnectivityScreen({Key? key}) : super(key: key);

  final List<Color> colors = [
    Colors.redAccent,
    Colors.purple,
    Colors.pinkAccent,
    Colors.black,
    Colors.teal,
    Colors.green,
    Colors.grey
  ];
  final Random random = Random();

  @override
  Widget build(BuildContext context) {
    Connectivity connectivity = Connectivity();
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder<ConnectivityResult>(
          stream: connectivity.onConnectivityChanged,
          builder: (_, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              final state = snapshot.data!;
              if (state != ConnectivityResult.none) {
                return AdBlocker();
              }
            }
            if (snapshot.connectionState == ConnectionState.active) {
              final state = snapshot.data!;
              if (state == ConnectivityResult.none) {
                return NoInternetScreen();
              }
            }
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: CheckInternetConnectionWidget(
                snapshot: snapshot,
                widget: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: 120,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Container(
                              color: colors[random.nextInt(7)],
                              height: 100,
                              child: Center(child: Text(index.toString(), style: TextStyle(fontFamily: 'Montserrat'))),
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
