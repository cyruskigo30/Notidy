import 'package:flutter/material.dart';
import 'package:notidy/auth/components/app_initializer.dart';
import 'utils/routes/routes.dart';
import 'utils/theme/notidy_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
      theme: NotidyTheme.light(),
      darkTheme: NotidyTheme.dark(),
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,

      ///todo style the title
      title: 'Notidy',
      initialRoute: AppInitializer.routeName,
      routes: routes,
    );
  }
}
