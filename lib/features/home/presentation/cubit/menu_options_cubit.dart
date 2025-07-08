import 'package:biz_scope/features/home/data/models/menu_option.dart';
import 'package:biz_scope/features/home/data/sources/menu_data_options_source.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'menu_options_state.dart';

class MenuOptionsCubit extends Cubit<MenuOptionsState> {
  MenuOptionsCubit({required this.dataSource}) : super(MenuOptionsInitial());
  final MenuOptionsDataSource dataSource;

  Future<void> loadMenuOptions() async {
    emit(MenuOptionsLoading());
    try {
      final options = await dataSource.loadMenuOptions();
      emit(MenuOptionsLoaded(options));
    } on Exception catch (e) {
      emit(MenuOptionsError(e.toString()));
    }
  }
}
