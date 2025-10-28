import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'core/global_keys.dart';
import 'features/kitchen_sink/kitchen_sink.dart';
import 'features/dashboard/dashboard_screen.dart';
import 'features/upi_payment/upi_payment_screen.dart';

final GoRouter router = GoRouter(
  navigatorKey: globalNavigatorKey,
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const DashboardScreen();
        // return const PhonePePaymentApp();
        // return const KitchenSink();
      },
    ),
  ],
);
