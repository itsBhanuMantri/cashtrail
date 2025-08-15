import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'core/global_keys.dart';
import 'features/kitchen_sink/kitchen_sink.dart';
import 'features/ledger/ledger_screen.dart';

final GoRouter router = GoRouter(
  navigatorKey: globalNavigatorKey,
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const LedgerScreen();
        // return const KitchenSink();
      },
    ),
  ],
);
