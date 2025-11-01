import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'core/global_keys.dart';
import 'features/cash_in/cash_in_widget.dart';
import 'features/cash_out/cash_out_widget.dart';
import 'features/dashboard/dashboard_screen.dart';
import 'features/scan_receipt/scan_receipt_screen.dart';

GoRouter createRouter({String initialLocation = '/', Object? initialExtra}) {
  // Store initial extra in closure for access in route builder
  final storedInitialExtra = initialExtra;

  final router = GoRouter(
    navigatorKey: globalNavigatorKey,
    initialLocation: initialLocation,
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return const DashboardScreen();
        },
      ),
      GoRoute(
        path: '/cash_in',
        builder: (BuildContext context, GoRouterState state) {
          return CashInWidget(data: state.extra as Map<String, dynamic>?);
        },
      ),
      GoRoute(
        path: '/cash_out',
        builder: (BuildContext context, GoRouterState state) {
          return CashOutWidget(data: state.extra as Map<String, dynamic>?);
        },
      ),
      GoRoute(
        path: '/scan_receipt',
        builder: (BuildContext context, GoRouterState state) {
          // Use state.extra if available (from navigation), otherwise use stored initial extra
          final sharedFilePath =
              state.extra as String? ?? storedInitialExtra as String?;
          return SharedFileScreen(sharedFilePath: sharedFilePath);
        },
      ),
    ],
  );

  return router;
}
