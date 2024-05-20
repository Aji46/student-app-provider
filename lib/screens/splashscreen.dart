


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testt2/screens/homepage.dart';
import 'package:testt2/servises/splashprovider.dart';

class Screensplash extends StatelessWidget {
  const Screensplash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final splashProvider = Provider.of<SplashScreenProvider>(context);


    splashProvider.checkUserLoggedIn();

    Future.delayed(const Duration(seconds: 3), () {
      if (splashProvider.isLoggedIn) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) =>   Titlebar()));
      } else {
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => Titlebar())); 
      }
    });

    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/logo.png',
          height: 250,
        ),
      ),
    );
  }
}