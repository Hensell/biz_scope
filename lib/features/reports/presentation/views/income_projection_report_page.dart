import 'package:biz_scope/features/reports/data/sources/income_projection_report_data_source.dart';
import 'package:biz_scope/features/reports/presentation/cubit/income_projection_report_cubit.dart';
import 'package:biz_scope/features/reports/presentation/views/income_projection_report_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IncomeProjectionReportPage extends StatelessWidget {
  const IncomeProjectionReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => IncomeProjectionReportCubit(
        dataSource: context.read<IncomeProjectionReportDataSource>(),
      )..loadReport(),
      child: const IncomeProjectionReportView(),
    );
  }
}
