import 'package:biz_scope/features/chat/presentation/utils/show_chat_modal.dart';
import 'package:biz_scope/features/reports/presentation/cubit/placement_cubit.dart';
import 'package:biz_scope/features/reports/presentation/utils/placement_utils.dart';
import 'package:biz_scope/features/reports/presentation/widgets/branch_dropdown.dart';
import 'package:biz_scope/features/reports/presentation/widgets/group_by_section.dart';
import 'package:biz_scope/features/reports/presentation/widgets/order_section.dart';
import 'package:biz_scope/features/reports/presentation/widgets/placement_chart.dart';
import 'package:biz_scope/features/reports/presentation/widgets/placement_kpi_cards.dart';
import 'package:biz_scope/l10n/gen/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlacementView extends StatefulWidget {
  const PlacementView({super.key});
  @override
  State<PlacementView> createState() => _PlacementViewState();
}

class _PlacementViewState extends State<PlacementView> {
  PlacementOrder _order = PlacementOrder.fecha;
  String? _branch;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.placements),
        centerTitle: true,
      ),
      floatingActionButton: IconButton(
        onPressed: () => showChatModal(context),
        icon: const Icon(Icons.smart_toy_outlined),
        tooltip: 'Chat IA',
        splashRadius: 24,
      ),
      body: BlocBuilder<PlacementCubit, PlacementState>(
        builder: (context, state) {
          if (state is PlacementLoading || state is PlacementInitial) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is PlacementError) {
            return Center(child: Text(l10n.error(state.message)));
          }
          if (state is PlacementLoaded) {
            final placements = state.placements;
            final groupBy = state.groupBy;

            if (placements.isEmpty) {
              return Center(child: Text(l10n.noPlacementsYet));
            }

            final branches = getBranches(placements, l10n.allBranches);
            final filtered = groupBy == PlacementGroupBy.branch
                ? placements
                : filterByBranch(placements, _branch, l10n.allBranches);

            final kpis = getTopOfficerKpis(filtered, context);
            final grouped = groupPlacements(filtered, groupBy, _order, context);

            return Padding(
              padding: const EdgeInsets.all(16),
              child: ListView(
                children: [
                  // Filtro de sucursal
                  BranchDropdown(
                    branches: branches,
                    value: _branch ?? l10n.allBranches,
                    onChanged: (value) => setState(() {
                      _branch = value == l10n.allBranches ? null : value;
                    }),
                  ),
                  // KPIs
                  PlacementKpiCards(kpis: kpis),
                  // Agrupar por
                  GroupBySection(
                    groupBy: groupBy,
                    onChanged: (value) =>
                        context.read<PlacementCubit>().changeGrouping(value!),
                  ),
                  // Ordenar
                  OrderSection(
                    order: _order,
                    onChanged: (order) => setState(() => _order = order),
                  ),
                  // Gráfico
                  PlacementChart(
                    grouped: grouped,
                    groupBy: groupBy,
                  ),
                  // Tabla
                  /*PlacementDetailTable(
                    grouped: grouped,
                    groupBy: groupBy,
                  ),*/
                ],
              ),
            );
          }
          return Center(child: Text(l10n.noData));
        },
      ),
    );
  }
}
