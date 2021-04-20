import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_test_app/screans/splash.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Test App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: SplashScrean(),
      
    );
  }
}
