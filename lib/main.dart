import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tailwind_palette/tailwind_palette.dart';

import 'router.dart';
import 'services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: '.env');

  registerServices();

  // Determine initial route based on shared file availability
  var initialLocation = '/';
  String? sharedFilePath;
  const platform = MethodChannel('shared_file_channel');
  try {
    final String? result = await platform.invokeMethod<String>('getSharedFile');
    if (result != null && result.trim().isNotEmpty) {
      initialLocation = '/scan_receipt';
      sharedFilePath = result;
    }
  } on PlatformException catch (e) {
    debugPrint('Error getting shared file on launch: $e');
  }

  final GoRouter appRouter = createRouter(
    initialLocation: initialLocation,
    initialExtra: sharedFilePath,
  );

  runApp(ProviderScope(child: MyApp(router: appRouter)));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.router});

  final GoRouter router;

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
        colorScheme: ColorScheme.fromSeed(
          seedColor: TailwindPalette.blue.shade900,
        ),
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
          // backgroundColor: Color(0xFF1E3A8A),
          backgroundColor: TailwindPalette.blue.shade900,
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
