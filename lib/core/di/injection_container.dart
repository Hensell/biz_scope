import 'package:biz_scope/features/home/data/sources/menu_data_options_source.dart';
import 'package:biz_scope/features/reports/data/sources/placement_data_source.dart';
import 'package:biz_scope/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InjectionContainer extends StatelessWidget {
  const InjectionContainer({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<MenuOptionsDataSource>(
          create: (_) => MenuOptionsDataSource(),
        ),
        RepositoryProvider<PlacementDataSource>(
          create: (_) => PlacementDataSource(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<SettingsCubit>(
            create: (_) => SettingsCubit(),
          ),
        ],
        child: child,
      ),
    );
  }
}
