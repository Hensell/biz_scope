import 'package:biz_scope/features/home/home_feature.dart';
import 'package:biz_scope/features/home/presentation/views/under_construction_view.dart';
import 'package:biz_scope/features/reports/presentation/views/income_projection_report_page.dart';
import 'package:biz_scope/features/reports/presentation/views/placement_page.dart';
import 'package:biz_scope/features/settings/presentation/views/settings_view.dart';
import 'package:go_router/go_router.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(),

      routes: [
        GoRoute(
          path: '/colocaciones',
          builder: (context, state) => const PlacementPage(),
        ),
        GoRoute(
          path: '/proyecciones',
          builder: (context, state) => const IncomeProjectionReportPage(),
        ),
        GoRoute(
          path: '/cartera-riesgo',
          builder: (context, state) => const UnderConstructionView(),
        ),
        GoRoute(
          path: '/clientes-inactivos',
          builder: (context, state) => const UnderConstructionView(),
        ),
        GoRoute(
          path: '/rotacion-cartera',
          builder: (context, state) => const UnderConstructionView(),
        ),
        GoRoute(
          path: '/cumplimiento-metas',
          builder: (context, state) => const UnderConstructionView(),
        ),
        GoRoute(
          path: '/crecimiento-clientes',
          builder: (context, state) => const UnderConstructionView(),
        ),
        GoRoute(
          path: '/colocacion-promedio',
          builder: (context, state) => const UnderConstructionView(),
        ),
        GoRoute(
          path: '/plan-trabajo',
          builder: (context, state) => const UnderConstructionView(),
        ),
        GoRoute(
          path: '/transacciones-caja',
          builder: (context, state) => const UnderConstructionView(),
        ),
        GoRoute(
          path: '/resultados-arqueos',
          builder: (context, state) => const UnderConstructionView(),
        ),
        GoRoute(
          path: '/cuadre-cartera',
          builder: (context, state) => const UnderConstructionView(),
        ),
        GoRoute(
          path: '/clima-laboral',
          builder: (context, state) => const UnderConstructionView(),
        ),
        GoRoute(
          path: '/desembolsos',
          builder: (context, state) => const UnderConstructionView(),
        ),
        GoRoute(
          path: '/promociones',
          builder: (context, state) => const UnderConstructionView(),
        ),
        GoRoute(
          path: '/settings',
          builder: (context, state) => const SettingsView(),
        ),
      ],
    ),
  ],
);
