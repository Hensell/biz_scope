import 'package:biz_scope/features/chat/presentation/utils/show_chat_modal.dart';
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
      floatingActionButton: IconButton(
        onPressed: () => showChatModal(context),
        icon: const Icon(Icons.smart_toy_outlined),
        tooltip: 'Chat IA',
        splashRadius: 24,
      ),
      appBar: AppBar(
        leading: const SizedBox(width: 48),
        centerTitle: true,
        toolbarHeight: 88, // Más alto de lo normal
        title: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Grupo innovaton',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 15,
                letterSpacing: 0.2,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 2),
            Text(
              'DESA 3',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 12,
                letterSpacing: 0.1,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: IconButton(
              icon: Icon(
                Icons.settings,
                color: Theme.of(context).colorScheme.primary,
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
