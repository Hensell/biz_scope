import 'package:biz_scope/l10n/gen/app_localizations.dart';
import 'package:flutter/material.dart';

class BranchDropdown extends StatelessWidget {
  const BranchDropdown({
    required this.branches,
    required this.value,
    required this.onChanged,
    super.key,
  });
  final List<String> branches;
  final String value;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 12, top: 25),
      child: Column(
        children: [
          Text(
            '${l10n.branch}: ',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 10),
          SizedBox(
            width: 260,
            child: DropdownButtonFormField<String>(
              value: value,
              items: branches.map((b) {
                return DropdownMenuItem(
                  value: b,
                  child: Text(b),
                );
              }).toList(),
              onChanged: onChanged,
              decoration: InputDecoration(
                labelText: l10n.filterByBranch,
                border: const OutlineInputBorder(),
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 12,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
