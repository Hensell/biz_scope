import 'package:biz_scope/features/reports/data/models/income_projection_report.dart';
import 'package:biz_scope/features/reports/data/sources/income_projection_report_data_source.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'income_projection_report_state.dart';

class IncomeProjectionReportCubit extends Cubit<IncomeProjectionReportState> {
  final IncomeProjectionReportDataSource dataSource;

  IncomeProjectionReportCubit({required this.dataSource})
    : super(IncomeProjectionReportInitial());

  Future<void> loadReport() async {
    emit(IncomeProjectionReportLoading());
    try {
      final report = await dataSource.loadReport();
      emit(IncomeProjectionReportLoaded(report: report));
    } catch (e) {
      emit(IncomeProjectionReportError(e.toString()));
    }
  }
}
