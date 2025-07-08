part of 'menu_options_cubit.dart';

@immutable
sealed class MenuOptionsState {}

final class MenuOptionsInitial extends MenuOptionsState {}

final class MenuOptionsLoading extends MenuOptionsState {}

final class MenuOptionsLoaded extends MenuOptionsState {
  MenuOptionsLoaded(this.options);
  final List<MenuOption> options;
}

final class MenuOptionsError extends MenuOptionsState {
  MenuOptionsError(this.message);
  final String message;
}
