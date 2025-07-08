import 'package:biz_scope/features/reports/data/sources/placement_data_source.dart';
import 'package:biz_scope/features/reports/presentation/cubit/placement_cubit.dart';
import 'package:biz_scope/features/reports/presentation/views/placement_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlacementPage extends StatelessWidget {
  const PlacementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          PlacementCubit(dataSource: context.read<PlacementDataSource>())
            ..loadPlacements(),
      child: const PlacementView(),
    );
  }
}
