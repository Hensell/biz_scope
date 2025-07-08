import 'dart:ui';

import 'package:biz_scope/app/view/app_router.dart';
import 'package:biz_scope/core/di/injection_container.dart';
import 'package:biz_scope/core/theme/app_theme.dart';
import 'package:biz_scope/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:biz_scope/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return InjectionContainer(
      child: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            title: 'BizScope',
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            themeMode: state.themeMode,
            locale: state.locale,
            routerConfig: appRouter,
            scrollBehavior: CustomScrollBehavior(),
          );
        },
      ),
    );
  }
}

class CustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
  };
}
