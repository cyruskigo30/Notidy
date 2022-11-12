import 'package:flutter/material.dart';
import 'utils/routes/routes.dart';
import 'auth/screens/splash/splash_screen.dart';
import 'utils/theme/recipia_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    //todo craete theme

    //todo apply home widget
    return MaterialApp(
      //todo add theme
      // theme: theme,
      theme: RecipiaTheme.light(),
      darkTheme: RecipiaTheme.dark(),
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,

      ///todo style the title
      title: 'Notidy',
      initialRoute: SplashScreen.routeName,
      routes: routes,
    );
  }
}
