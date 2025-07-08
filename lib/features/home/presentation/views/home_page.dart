import 'package:biz_scope/features/home/data/sources/menu_data_options_source.dart';
import 'package:biz_scope/features/home/presentation/cubit/menu_options_cubit.dart';
import 'package:biz_scope/features/home/presentation/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          MenuOptionsCubit(dataSource: MenuOptionsDataSource())
            ..loadMenuOptions(),
      child: const HomeView(),
    );
  }
}
