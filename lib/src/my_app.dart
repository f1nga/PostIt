import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:wallapop/src/routes/pages.dart';
import 'utils/colors.dart';
import 'utils/font_styles.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Wallapop",
      theme: ThemeData(
        primarySwatch: primaryMaterialcolor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: FontStyles.textTheme,
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: tertiaryColor,
          selectionColor: tertiaryColor,
          selectionHandleColor: tertiaryColor,
        ),
        iconTheme: const IconThemeData(color: secondaryColor),
        appBarTheme: const AppBarTheme(
          color: backgroundColor,
          iconTheme: IconThemeData(
            color: secondaryColor,
          ),
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarBrightness: Brightness.light,
          ),
        ),
      ),
      initialRoute: Pages.initial,
      routes: Pages.routes,
    );
  }
}
