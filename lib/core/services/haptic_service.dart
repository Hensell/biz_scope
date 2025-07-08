import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

/// A cross-platform safe utility for triggering haptic feedback.
///
/// This class ensures haptic feedback only runs on platforms that support it,
/// and avoids runtime errors on unsupported platforms like Flutter Web.
class HapticService {
  /// Triggers a light impact vibration (e.g. for button presses).
  static void lightImpact() {
    if (!_isSupported) return;
    HapticFeedback.lightImpact();
  }

  /// Triggers a medium impact vibration.
  static void mediumImpact() {
    if (!_isSupported) return;
    HapticFeedback.mediumImpact();
  }

  /// Triggers a heavy impact vibration (e.g. for destructive actions).
  static void heavyImpact() {
    if (!_isSupported) return;
    HapticFeedback.heavyImpact();
  }

  /// Triggers a short click used for selection changes.
  static void selectionClick() {
    if (!_isSupported) return;
    HapticFeedback.selectionClick();
  }

  /// Generic vibration, rarely used.
  static void vibrate() {
    if (!_isSupported) return;
    HapticFeedback.vibrate();
  }

  /// Internal check for platform support.
  static bool get _isSupported => !kIsWeb;
}
