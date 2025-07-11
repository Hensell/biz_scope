import 'package:biz_scope/features/home/presentation/cubit/menu_options_cubit.dart';
import 'package:biz_scope/features/home/presentation/utils/icon_mapper.dart';
import 'package:biz_scope/features/home/presentation/utils/menu_l10n_extension.dart';
import 'package:biz_scope/features/home/presentation/widgets/extra_menu_options.dart';
import 'package:biz_scope/features/home/presentation/widgets/menu_button.dart';
import 'package:biz_scope/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class MenuSection extends StatelessWidget {
  const MenuSection({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return BlocBuilder<MenuOptionsCubit, MenuOptionsState>(
      builder: (context, state) {
        if (state is MenuOptionsLoading || state is MenuOptionsInitial) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is MenuOptionsError) {
          return Center(child: Text("Error: ${state.message}"));
        }
        if (state is MenuOptionsLoaded) {
          final options = state.options;

          final mainOptions = options.take(2).toList();
          final extraOptions = options.skip(2).toList();

          return Center(
            child: Container(
              padding: const EdgeInsets.all(35),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.black.withValues(alpha: 0.1),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 10,
                    runSpacing: 16,
                    children: [
                      for (final item in mainOptions)
                        MenuButton(
                          label: context.l10n.getLabel(item.label),
                          icon: Icon(
                            iconFromString(item.icon),
                            size: 44,
                            color: colorScheme.primary,
                          ),
                          onTap: () => context.go(item.route),
                        ),
                    ],
                  ),
                  if (extraOptions.isNotEmpty) ...[
                    const SizedBox(height: 14),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colorScheme.primary,
                        foregroundColor: colorScheme.onPrimary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 2,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                      ),
                      icon: const Icon(Icons.apps_rounded, size: 20),
                      label: const Text("Más opciones"),
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              ExtraMenuOptions(options: extraOptions),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          );
        }
        return const Center(child: Text('Sin datos'));
      },
    );
  }
}
