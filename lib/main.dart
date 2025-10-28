import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tailwind_palette/tailwind_palette.dart';

import 'router.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final fontFamily = 'Lato';
    return MaterialApp.router(
      title: 'Cash Trail',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        fontFamily: fontFamily,
        textTheme: TextTheme(
          // title
          titleLarge: TextStyle(
            fontFamily: fontFamily,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          titleMedium: TextStyle(
            fontFamily: fontFamily,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          titleSmall: TextStyle(
            fontFamily: fontFamily,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),

          // body
          bodyLarge: TextStyle(fontFamily: fontFamily, fontSize: 18),
          bodyMedium: TextStyle(fontFamily: fontFamily, fontSize: 16),
          bodySmall: TextStyle(fontFamily: fontFamily, fontSize: 14),

          // label
          labelLarge: TextStyle(
            fontFamily: fontFamily,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          labelMedium: TextStyle(
            fontFamily: fontFamily,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          labelSmall: TextStyle(
            fontFamily: fontFamily,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.indigo,
            foregroundColor: Colors.white,
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            textStyle: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w800,
              fontFamily: fontFamily,
            ),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            side: BorderSide(width: 2, color: Colors.indigo),
            textStyle: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w800,
              fontFamily: fontFamily,
            ),
          ),
        ),
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: Colors.indigo,
          selectionColor: Colors.indigo.shade100,
          selectionHandleColor: Colors.indigo,
        ),
        chipTheme: ChipThemeData(
          padding: EdgeInsets.zero,
          labelStyle: textTheme.labelSmall,
        ),
        scaffoldBackgroundColor: TailwindPalette.slate.shade100,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.indigo,
          foregroundColor: Colors.white,
          // shadowColor: Colors.black.withValues(alpha: 1),
          // elevation: 2,
          titleTextStyle: textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontFamily: fontFamily,
          ),
        ),
      ),
      routerConfig: router,
    );
  }
}
