import 'dart:ui';
import 'package:biz_scope/core/services/haptic_service.dart';
import 'package:flutter/material.dart';

class MenuButton extends StatefulWidget {
  const MenuButton({
    required this.label,
    required this.icon,
    required this.onTap,
    super.key,
  });

  final String label;
  final Widget icon;
  final VoidCallback onTap;

  @override
  State<MenuButton> createState() => _MenuButtonState();
}

class _MenuButtonState extends State<MenuButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    // Color y gradiente segun tema
    final borderColor = isDark
        ? colorScheme.primary.withValues(alpha: 0.28)
        : colorScheme.primary.withValues(alpha: 0.13);

    final backgroundGradient = isDark
        ? LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              colorScheme.surface.withValues(alpha: _isPressed ? 0.90 : 0.83),
              colorScheme.surface.withValues(alpha: _isPressed ? 0.93 : 0.89),
            ],
          )
        : LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              colorScheme.primary.withValues(alpha: _isPressed ? 0.13 : 0.16),
              colorScheme.secondary.withValues(alpha: _isPressed ? 0.10 : 0.15),
            ],
          );

    final textColor = isDark
        ? colorScheme.onSurface
        : colorScheme.primary; // Purple en light, lila en dark

    return GestureDetector(
      onTapDown: (_) {
        setState(() => _isPressed = true);
        HapticService.heavyImpact();
      },
      onTapUp: (_) {
        setState(() => _isPressed = false);
        widget.onTap();
      },
      onTapCancel: () => setState(() => _isPressed = false),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
          child: TweenAnimationBuilder(
            tween: Tween<double>(begin: 1, end: _isPressed ? 0.96 : 1),
            duration: const Duration(milliseconds: 70),
            builder: (context, scale, child) {
              return Transform.scale(scale: scale, child: child);
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 110),
              decoration: BoxDecoration(
                border: Border.all(
                  color: borderColor,
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(_isPressed ? 18 : 32),
                gradient: backgroundGradient,
                boxShadow: [
                  if (!_isPressed)
                    BoxShadow(
                      color: colorScheme.primary.withValues(alpha: 0.07),
                      blurRadius: 16,
                      offset: const Offset(0, 4),
                    ),
                ],
              ),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 18),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Opacity(
                    opacity: _isPressed ? 1 : 0.92,
                    child: widget.icon,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    widget.label,
                    style: theme.textTheme.titleLarge?.copyWith(
                      color: textColor,
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                      letterSpacing: 0.01,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
