import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'features/cash_out/cash_out_widget.dart';
import 'features/kitchen_sink/kitchen_sink.dart';
import 'features/ledger/ledger_screen.dart';

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const LedgerScreen();
      },
    ),
  ],
);
