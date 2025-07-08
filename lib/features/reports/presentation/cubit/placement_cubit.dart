import 'package:biz_scope/features/reports/data/models/placement.dart';
import 'package:biz_scope/features/reports/data/sources/placement_data_source.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'placement_state.dart';

enum PlacementGroupBy { day, week, month, officer, branch }

class PlacementCubit extends Cubit<PlacementState> {
  PlacementCubit({required this.dataSource}) : super(PlacementInitial());

  final PlacementDataSource dataSource;
  PlacementGroupBy _groupBy = PlacementGroupBy.day;

  PlacementGroupBy get groupBy => _groupBy;

  Future<void> loadPlacements() async {
    emit(PlacementLoading());
    try {
      final placements = await dataSource.loadPlacements();
      emit(
        PlacementLoaded(
          placements: placements,
          groupBy: _groupBy,
        ),
      );
    } on Exception catch (e) {
      emit(PlacementError(e.toString()));
    }
  }

  void changeGrouping(PlacementGroupBy groupBy) {
    _groupBy = groupBy;
    if (state is PlacementLoaded) {
      emit(
        PlacementLoaded(
          placements: (state as PlacementLoaded).placements,
          groupBy: groupBy,
        ),
      );
    }
  }
}
