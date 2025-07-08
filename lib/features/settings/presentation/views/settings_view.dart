import 'dart:ui';
import 'package:biz_scope/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:biz_scope/l10n/gen/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    final cubit = context.read<SettingsCubit>();
    final state = context.watch<SettingsCubit>().state;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).settings),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Stack(
        children: [
          // Background gradient
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    colorScheme.primary.withValues(alpha: 0.13),
                    colorScheme.secondary.withValues(alpha: 0.09),
                    colorScheme.surfaceContainer.withValues(alpha: 0.3),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
          ),
          // Blurred overlay
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
              child: Container(
                color: Colors.transparent,
              ),
            ),
          ),
          // Settings content
          Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Card
                  Container(
                    width: 410,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 34,
                    ),
                    margin: const EdgeInsets.only(top: 80, bottom: 32),
                    decoration: BoxDecoration(
                      color: colorScheme.surface.withValues(alpha: 0.6),
                      borderRadius: BorderRadius.circular(28),
                      boxShadow: [
                        BoxShadow(
                          color: colorScheme.primary.withValues(alpha: 0.12),
                          blurRadius: 22,
                          offset: const Offset(0, 7),
                        ),
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.09),
                          blurRadius: 12,
                          offset: const Offset(0, 3),
                        ),
                      ],
                      border: Border.all(
                        color: colorScheme.outline.withValues(alpha: 0.11),
                        width: 1.5,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Tema
                        Text(
                          localizations.chooseTheme,
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: colorScheme.onSurface,
                              ),
                        ),
                        const SizedBox(height: 18),
                        Row(
                          children: [
                            _AnimatedOptionCard(
                              icon: Icons.light_mode,
                              label: AppLocalizations.of(context).light,
                              selected: state.themeMode == ThemeMode.light,
                              onTap: () => cubit.changeTheme(ThemeMode.light),
                            ),
                            const SizedBox(width: 18),
                            _AnimatedOptionCard(
                              icon: Icons.dark_mode,
                              label: AppLocalizations.of(context).dark,
                              selected: state.themeMode == ThemeMode.dark,
                              onTap: () => cubit.changeTheme(ThemeMode.dark),
                            ),
                            const SizedBox(width: 18),
                            _AnimatedOptionCard(
                              icon: Icons.brightness_auto,
                              label: AppLocalizations.of(context).system,
                              selected: state.themeMode == ThemeMode.system,
                              onTap: () => cubit.changeTheme(ThemeMode.system),
                            ),
                          ],
                        ),
                        const SizedBox(height: 38),
                        Text(
                          localizations.chooseLanguage,
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: colorScheme.onSurface,
                              ),
                        ),
                        const SizedBox(height: 18),
                        Row(
                          children: [
                            _AnimatedOptionCard(
                              icon: Icons.language,
                              label: 'Español',
                              selected: state.locale.languageCode == 'es',
                              onTap: () =>
                                  cubit.changeLocale(const Locale('es')),
                            ),
                            const SizedBox(width: 18),
                            _AnimatedOptionCard(
                              icon: Icons.language,
                              label: 'English',
                              selected: state.locale.languageCode == 'en',
                              onTap: () =>
                                  cubit.changeLocale(const Locale('en')),
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                        Divider(
                          height: 32,
                          thickness: 1.3,
                          color: colorScheme.outline.withValues(alpha: 0.09),
                        ),
                        const SizedBox(height: 16),
                        const Center(
                          child: TextButton(
                            onPressed: _launchURL,
                            child: Text('Made by @Henselldev'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

final Uri _url = Uri.parse('https://hensell.dev');

Future<void> _launchURL() async {
  if (!await launchUrl(_url, mode: LaunchMode.externalApplication)) {
    throw Exception('No se pudo abrir $_url');
  }
}

class _AnimatedOptionCard extends StatelessWidget {
  const _AnimatedOptionCard({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 170),
          curve: Curves.easeOutCubic,
          height: 96,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: selected
                ? colorScheme.primary.withValues(alpha: 0.16)
                : colorScheme.surfaceContainerHighest.withValues(alpha: 0.8),
            boxShadow: selected
                ? [
                    BoxShadow(
                      color: colorScheme.primary.withValues(alpha: 0.18),
                      blurRadius: 16,
                      offset: const Offset(0, 5),
                    ),
                  ]
                : [],
            border: Border.all(
              color: selected
                  ? colorScheme.primary
                  : colorScheme.outline.withValues(alpha: 0.12),
              width: selected ? 2.4 : 1.2,
            ),
          ),
          child: Stack(
            children: [
              // Selection ripple
              if (selected)
                Positioned.fill(
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 180),
                    opacity: selected ? 0.12 : 0,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: colorScheme.primary,
                      ),
                    ),
                  ),
                ),
              // Content
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 180),
                      curve: Curves.easeOut,
                      decoration: selected
                          ? BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: colorScheme.primary.withValues(
                                    alpha: 0.16,
                                  ),
                                  blurRadius: 13,
                                  spreadRadius: 1.3,
                                ),
                              ],
                            )
                          : null,
                      child: Icon(
                        icon,
                        color: selected
                            ? colorScheme.primary
                            : colorScheme.onSurface.withValues(alpha: 0.55),
                        size: 32,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      label,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: selected
                            ? colorScheme.primary
                            : theme.textTheme.bodyMedium?.color,
                        letterSpacing: 0.2,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
