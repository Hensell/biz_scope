import 'package:biz_scope/features/home/presentation/widgets/menu_section.dart';
import 'package:biz_scope/features/home/presentation/widgets/news_carousel.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        leading: const SizedBox(width: 48),
        centerTitle: true,
        title: const Text(
          'Grupo innovaton DESA 3',
          style: TextStyle(fontWeight: FontWeight.w700, letterSpacing: 0.2),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: IconButton(
              icon: Icon(
                Icons.settings,
                color: colorScheme.primary,
              ),
              tooltip: 'Ajustes',
              onPressed: () => context.go('/settings'),

              splashRadius: 24,
            ),
          ),
        ],
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
      ),
      body: Center(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 14),
          children: const [
            NewsCarousel(), // Modularizado
            SizedBox(height: 36),
            MenuSection(), // Modularizado
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
