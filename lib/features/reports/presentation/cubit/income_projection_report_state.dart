part of 'income_projection_report_cubit.dart';

@immutable
sealed class IncomeProjectionReportState {}

final class IncomeProjectionReportInitial extends IncomeProjectionReportState {}

final class IncomeProjectionReportLoading extends IncomeProjectionReportState {}

final class IncomeProjectionReportLoaded extends IncomeProjectionReportState {
  final IncomeProjectionReport report;

  IncomeProjectionReportLoaded({required this.report});
}

final class IncomeProjectionReportError extends IncomeProjectionReportState {
  final String message;

  IncomeProjectionReportError(this.message);
}
