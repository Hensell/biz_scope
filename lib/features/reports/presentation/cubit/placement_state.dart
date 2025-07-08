part of 'placement_cubit.dart';

@immutable
sealed class PlacementState {}

final class PlacementInitial extends PlacementState {}

final class PlacementLoading extends PlacementState {}

final class PlacementLoaded extends PlacementState {
  PlacementLoaded({
    required this.placements,
    required this.groupBy,
  });
  final List<Placement> placements;
  final PlacementGroupBy groupBy;
}

final class PlacementError extends PlacementState {
  PlacementError(this.message);
  final String message;
}
