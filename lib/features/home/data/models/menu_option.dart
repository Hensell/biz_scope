class MenuOption {
  MenuOption({required this.label, required this.icon, required this.route});

  factory MenuOption.fromJson(Map<String, dynamic> json) => MenuOption(
    label: json['label'] as String,
    icon: json['icon'] as String,
    route: json['route'] as String,
  );
  final String label;
  final String icon;
  final String route;

  Map<String, dynamic> toJson() => {
    'label': label,
    'icon': icon,
    'route': route,
  };
}
