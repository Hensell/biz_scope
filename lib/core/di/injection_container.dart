import 'package:biz_scope/features/chat/data/datasources/chat_local_datasource.dart';
import 'package:biz_scope/features/chat/data/datasources/chat_remote_datasource.dart';
import 'package:biz_scope/features/chat/data/repositories/chat_repository_impl.dart';
import 'package:biz_scope/features/chat/domain/usecases/get_local_messages.dart';
import 'package:biz_scope/features/chat/domain/usecases/send_message.dart';
import 'package:biz_scope/features/chat/presentation/providers/chat_provider.dart';
import 'package:biz_scope/features/home/data/sources/menu_data_options_source.dart';
import 'package:biz_scope/features/reports/data/sources/placement_data_source.dart';
import 'package:biz_scope/features/reports/data/sources/income_projection_report_data_source.dart';
import 'package:biz_scope/features/reports/presentation/cubit/income_projection_report_cubit.dart';
import 'package:biz_scope/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class InjectionContainer extends StatelessWidget {
  const InjectionContainer({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final localDatasource = ChatLocalDatasource();
    final remoteDatasource = ChatRemoteDatasource();
    final chatRepository = ChatRepositoryImpl(
      localDatasource: localDatasource,
      remoteDatasource: remoteDatasource,
    );

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<MenuOptionsDataSource>(
          create: (_) => MenuOptionsDataSource(),
        ),
        RepositoryProvider<PlacementDataSource>(
          create: (_) => PlacementDataSource(),
        ),
        RepositoryProvider<IncomeProjectionReportDataSource>(
          create: (_) => IncomeProjectionReportDataSource(),
        ),
      ],
      child: ChangeNotifierProvider(
        create: (_) => ChatProvider(
          getLocalMessagesUsecase: GetLocalMessages(chatRepository),
          sendMessageUsecase: SendMessage(chatRepository),
          repository: chatRepository,
        ),
        child: MultiBlocProvider(
          providers: [
            BlocProvider<SettingsCubit>(
              create: (_) => SettingsCubit(),
            ),
            BlocProvider<IncomeProjectionReportCubit>(
              create: (context) => IncomeProjectionReportCubit(
                dataSource:
                    RepositoryProvider.of<IncomeProjectionReportDataSource>(
                      context,
                    ),
              ),
            ),
          ],
          child: child,
        ),
      ),
    );
  }
}
