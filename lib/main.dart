import 'package:eventlyapp/on_boarding/on_boarding_screen.dart';
import 'package:eventlyapp/on_boarding/on_boarding_screen1.dart';
import 'package:eventlyapp/providers/app_language_provider.dart';
import 'package:eventlyapp/providers/app_theme_provider.dart';
import 'package:eventlyapp/ui/add_event/add_event.dart';
import 'package:eventlyapp/ui/auth/Login/login_screen.dart';
import 'package:eventlyapp/ui/auth/Register/register_screen.dart';
import 'package:eventlyapp/ui/home_screen.dart';
import 'package:eventlyapp/utils/app_routes.dart';
import 'package:eventlyapp/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'l10n/app_localizations.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AppLanguageProvider()),
        ChangeNotifierProvider(create: (context) => AppThemeProvider()),
      ],

      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var langageProvider = Provider.of<AppLanguageProvider>(context);
    var themeProvider = Provider.of<AppThemeProvider>(context);

    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      debugShowCheckedModeBanner: false,
      locale: Locale(langageProvider.appLanguage),
      initialRoute: AppRoutes.homeRouteName,
      routes: {
        AppRoutes.homeRouteName: (context) => HomeScreen(),
        AppRoutes.onBoardingRouteName: (context) => OnboardingScreen(),
        AppRoutes.onBoardingScreen1RouteName: (context) => OnBoardingScreen1(),
        AppRoutes.loginRouteName: (context) => LoginScreen(),
        AppRoutes.registerRouteName: (context) => RegisterScreen(),
        AppRoutes.addEventRouteName: (context) => AddEvent(),
      },
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeProvider.appTheme,
    );
  }
}
