part of 'settings_cubit.dart';

@immutable
class SettingsState {
  const SettingsState({required this.themeMode, required this.locale});

  factory SettingsState.fromMap(Map<String, dynamic> map) {
    return SettingsState(
      themeMode: ThemeMode
          .values[int.tryParse(map['themeMode']?.toString() ?? '0') ?? 0],
      locale: Locale(map['locale']?.toString() ?? 'es'),
    );
  }
  final ThemeMode themeMode;
  final Locale locale;

  SettingsState copyWith({ThemeMode? themeMode, Locale? locale}) {
    return SettingsState(
      themeMode: themeMode ?? this.themeMode,
      locale: locale ?? this.locale,
    );
  }

  Map<String, dynamic> toMap() {
    return {'themeMode': themeMode.index, 'locale': locale.languageCode};
  }
}
