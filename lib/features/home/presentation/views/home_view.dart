import 'package:biz_scope/features/home/presentation/cubit/menu_options_cubit.dart';
import 'package:biz_scope/features/home/presentation/utils/icon_mapper.dart';
import 'package:biz_scope/features/home/presentation/utils/menu_l10n_extension.dart';
import 'package:biz_scope/features/home/presentation/widgets/menu_button.dart';
import 'package:biz_scope/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lazy_wrap/lazy_wrap.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        leading: const SizedBox(width: 48),
        centerTitle: true,
        title: Text(AppLocalizations.of(context).indicators),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: IconButton(
              icon: Icon(Icons.settings, color: colorScheme.primary),
              tooltip: AppLocalizations.of(context).settingsTooltip,
              onPressed: () => context.go('/settings'),
              splashRadius: 24,
            ),
          ),
        ],
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 350),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: isDark
                      ? [colorScheme.surface, colorScheme.surface]
                      : [
                          colorScheme.surface,
                          colorScheme.surface.withValues(alpha: 0.96),
                        ],
                ),
              ),
            ),
          ),
          BlocBuilder<MenuOptionsCubit, MenuOptionsState>(
            builder: (context, state) {
              if (state is MenuOptionsLoading || state is MenuOptionsInitial) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is MenuOptionsError) {
                return Center(
                  child: Text(
                    AppLocalizations.of(
                      context,
                    ).errorLoadingMenu(state.message),
                  ),
                );
              }
              if (state is MenuOptionsLoaded) {
                final options = state.options;
                return SingleChildScrollView(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 8,
                      ),
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        spacing: 10,
                        runSpacing: 16,
                        children: [
                          for (final item in options)
                            SizedBox(
                              width: 310,
                              height: 310,
                              child: MenuButton(
                                label: context.l10n.getLabel(item.label),
                                icon: Icon(
                                  iconFromString(item.icon),
                                  size: 54,
                                  color: colorScheme.primary,
                                ),
                                onTap: () => context.go(item.route),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                );
              }

              return Center(child: Text(AppLocalizations.of(context).noData));
            },
          ),
        ],
      ),
    );
  }
}
