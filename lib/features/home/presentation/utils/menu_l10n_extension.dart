import 'package:biz_scope/l10n/l10n.dart';

extension MenuL10nExtension on AppLocalizations {
  String getLabel(String key) {
    final labels = {
      'placements': placements,
      'delinquency': delinquency,
      'atRiskPortfolio': atRiskPortfolio,
      'inactiveClients': inactiveClients,
      'portfolioTurnover': portfolioTurnover,
      'goalAchievement': goalAchievement,
      'clientGrowth': clientGrowth,
      'averagePlacementPerOfficer': averagePlacementPerOfficer,
      'workPlan': workPlan,
      'cashTransactions': cashTransactions,
      'auditResults': auditResults,
      'portfolioBalancing': portfolioBalancing,
      'workplaceClimate': workplaceClimate,
      'disbursements': disbursements,
      'promotions': promotions,
    };
    return labels[key] ?? key;
  }
}
