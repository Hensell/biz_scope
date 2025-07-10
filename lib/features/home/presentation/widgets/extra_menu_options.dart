import 'package:biz_scope/features/home/presentation/utils/icon_mapper.dart';
import 'package:biz_scope/features/home/presentation/utils/menu_l10n_extension.dart';
import 'package:biz_scope/features/home/presentation/widgets/menu_button.dart';
import 'package:biz_scope/l10n/l10n.dart';
import 'package:flutter/material.dart';

class ExtraMenuOptions extends StatelessWidget {
  const ExtraMenuOptions({required this.options, super.key});
  final List<dynamic> options;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Otras opciones"),
        centerTitle: true,
        backgroundColor: colorScheme.surface,
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 18),
          child: SingleChildScrollView(
            child: Wrap(
              alignment: WrapAlignment.center,
              spacing: 16,
              runSpacing: 20,
              children: [
                for (final item in options)
                  SizedBox(
                    width: 270,
                    height: 210,
                    child: MenuButton(
                      label: context.l10n.getLabel(item.label.toString()),
                      icon: Icon(
                        iconFromString(item.icon.toString()),
                        size: 36,
                        color: colorScheme.primary,
                      ),
                      onTap: () {
                        // Todas las demás mandan a under construction
                        Navigator.pushNamed(context, '/under_construction');
                      },
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
