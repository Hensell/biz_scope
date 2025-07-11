import 'package:biz_scope/features/chat/presentation/utils/show_chat_modal.dart';
import 'package:biz_scope/features/reports/data/models/income_projection_report.dart';
import 'package:biz_scope/features/reports/presentation/cubit/income_projection_report_cubit.dart';
import 'package:biz_scope/features/reports/presentation/widgets/projection_bar_chart.dart';
import 'package:biz_scope/l10n/gen/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IncomeProjectionReportView extends StatelessWidget {
  const IncomeProjectionReportView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      floatingActionButton: IconButton(
        onPressed: () => showChatModal(context),
        icon: const Icon(Icons.smart_toy_outlined),
        tooltip: 'Chat IA',
        splashRadius: 24,
      ),
      appBar: AppBar(
        title: Text(
          l10n.incomeProjectionReportTitle,
          style: const TextStyle(
            fontSize: 14, // más pequeño que el default
            fontWeight: FontWeight.w700,
            letterSpacing: 0.2,
          ),
          maxLines: 2, // permite dos líneas si el texto es largo
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        toolbarHeight: 54, // más bajito si quieres el AppBar más compacto
      ),

      body:
          BlocBuilder<IncomeProjectionReportCubit, IncomeProjectionReportState>(
            builder: (context, state) {
              if (state is IncomeProjectionReportLoading ||
                  state is IncomeProjectionReportInitial) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is IncomeProjectionReportError) {
                return Center(
                  child: Text(l10n.incomeProjectionReportError(state.message)),
                );
              }
              if (state is IncomeProjectionReportLoaded) {
                final report = state.report;
                return SingleChildScrollView(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title and Summary
                      Text(
                        l10n.incomeProjectionSummary,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 10),
                      _SummaryCard(
                        summary: report.projectionSummary,
                        l10n: l10n,
                      ),

                      const SizedBox(height: 28),
                      Text(
                        l10n.incomeProjectionBranchesByCategory,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 8),
                      Center(
                        child: ProjectionBarChart(
                          categories: report.projectionCategories,
                        ),
                      ),

                      const SizedBox(height: 32),
                      Text(
                        l10n.incomeProjectionBranchesList,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 8),
                      ...report.branches.map(
                        (b) => ListTile(
                          title: Text(b.name),
                          subtitle: Text(
                            l10n.incomeProjectionBranchCategory(b.category),
                          ),
                          trailing: Text(
                            l10n.incomeProjectionBranchPortfolio(
                              b.currentPortfolio.toStringAsFixed(0),
                            ),
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }
              return const SizedBox();
            },
          ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final ProjectionSummary summary;
  final AppLocalizations l10n;

  const _SummaryCard({
    required this.summary,
    required this.l10n,
  });

  @override
  Widget build(BuildContext context) {
    final styleLabel = Theme.of(
      context,
    ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600);
    final styleValue = Theme.of(
      context,
    ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold);

    return Card(
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    l10n.incomeProjectionCurrentPortfolio,
                    style: styleLabel,
                  ),
                ),
                Text(
                  '\$${summary.currentPortfolio.toStringAsFixed(0)}',
                  style: styleValue,
                ),
              ],
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                Expanded(
                  child: Text(
                    l10n.incomeProjectionProjectedPortfolio,
                    style: styleLabel,
                  ),
                ),
                Text(
                  '\$${summary.projectedPortfolio.toStringAsFixed(0)}',
                  style: styleValue,
                ),
              ],
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                Expanded(
                  child: Text(l10n.incomeProjectionDelta, style: styleLabel),
                ),
                Text(
                  '\$${summary.delta.toStringAsFixed(0)}',
                  style: styleValue,
                ),
              ],
            ),
            const Divider(height: 22, thickness: 1.1),
            Row(
              children: [
                Expanded(
                  child: Text(
                    l10n.incomeProjectionDiscountRate,
                    style: styleLabel,
                  ),
                ),
                Text(
                  '${(summary.discountRate * 100).toStringAsFixed(2)}%',
                  style: styleValue,
                ),
              ],
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                Expanded(
                  child: Text(
                    l10n.incomeProjectionPresentValue,
                    style: styleLabel,
                  ),
                ),
                Text(
                  '\$${summary.presentValue.toStringAsFixed(2)}',
                  style: styleValue,
                ),
              ],
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                Expanded(
                  child: Text(
                    l10n.incomeProjectionAnnualValue,
                    style: styleLabel,
                  ),
                ),
                Text(
                  '\$${summary.annualValue.toStringAsFixed(2)}',
                  style: styleValue,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
