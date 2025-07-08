import 'package:flutter/material.dart';

IconData iconFromString(String icon) {
  switch (icon) {
    case 'show_chart':
      return Icons.show_chart;
    case 'trending_down':
      return Icons.trending_down;
    case 'warning':
      return Icons.warning;
    case 'person_off':
      return Icons.person_off;
    case 'sync':
      return Icons.sync;
    case 'verified':
      return Icons.verified;
    case 'person_add':
      return Icons.person_add;
    case 'bar_chart':
      return Icons.bar_chart;
    case 'assignment_turned_in':
      return Icons.assignment_turned_in;
    case 'attach_money':
      return Icons.attach_money;
    case 'checklist':
      return Icons.checklist;
    case 'account_balance_wallet':
      return Icons.account_balance_wallet;
    case 'wb_sunny':
      return Icons.wb_sunny;
    case 'monetization_on':
      return Icons.monetization_on;
    case 'campaign':
      return Icons.campaign;
    default:
      return Icons.help_outline;
  }
}
