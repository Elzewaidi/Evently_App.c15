import 'package:eventlyapp/l10n/app_localizations.dart';
import 'package:eventlyapp/providers/app_languge_provider.dart';
import 'package:eventlyapp/providers/app_theme_provider.dart';
import 'package:eventlyapp/providers/event_list_provider.dart';
import 'package:eventlyapp/providers/location_provider.dart';
import 'package:eventlyapp/providers/user_provider.dart';
import 'package:eventlyapp/utils/themes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Tabs/map/map_tab.dart';
import 'UI/HomeScreen/add_event/add_event.dart';
import 'UI/HomeScreen/add_event/edit_event.dart';
import 'UI/HomeScreen/add_event/event_details.dart';
import 'UI/HomeScreen/home_screen.dart';
import 'UI/auth/login/login.dart';
import 'UI/auth/register/register.dart';
import 'firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  WidgetsFlutterBinding.ensureInitialized();
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
    print('Flutter Error: ${details.exception}');
  };
  //debugPaintSizeEnabled = false; // ضعها في main() أثناء التطوير

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(

    options: DefaultFirebaseOptions.currentPlatform,
  );
  //await FirebaseFirestore.instance.disableNetwork();//offline
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AppLangugeProvider()),
        ChangeNotifierProvider(create: (context) => AppThemeProvider()),
        ChangeNotifierProvider(create: (context) => EventListProvider()),
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => LocationProvider()),
      ],
      child: const MyApp(),
    ),
  );
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<AppLangugeProvider>(context);
    var themeProvider = Provider.of<AppThemeProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: LoginScreen.routeName,
      routes: {
        EventDetails.routeName: (context) => EventDetails(),
        Homescreen.routeName: (context) => Homescreen(),
        LoginScreen.routeName: (context) => LoginScreen(),
        RegisterScreen.routeName: (context) => RegisterScreen(),
        AddEvent.routeName: (context) => AddEvent(),
        EditEvent.routeName: (context) => EditEvent(),
        MapTap.routeName: (context) => MapTap(),
      },
      theme: AppTheme.lightTheme,
      themeMode: themeProvider.apptheme,
      darkTheme: AppTheme.darkTheme,
      locale: Locale(languageProvider.appLanguage),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }

}