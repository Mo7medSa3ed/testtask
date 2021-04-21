import 'package:flutter/material.dart';
import 'package:flutter_test_app/provider/themes.dart';
import 'package:provider/provider.dart';

import 'package:flutter_test_app/screans/splash.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Themes>(
        create: (_) => Themes(ThemeData.dark()), child: MaterialAppWithTheme());
  }
}

class MaterialAppWithTheme extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<Themes>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Test App',
      theme: theme.getTheme(),
      home: SplashScrean(),
    );
  }
}
