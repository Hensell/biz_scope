class ClassificationCriteria {
  factory ClassificationCriteria.fromJson(Map<String, dynamic> json) {
    bool parseBool(dynamic v) =>
        v is bool ? v : (v is String ? v.toLowerCase() == 'true' : false);
    String parseString(dynamic v) =>
        v is String ? v : (v != null ? v.toString() : '');

    return ClassificationCriteria(
      byPortfolio: parseBool(json['porCartera']),
      byClients: parseBool(json['porClientes']),
      byLocation: parseBool(json['porUbicacion']),
      detail: parseString(json['detalle']),
    );
  }

  ClassificationCriteria({
    required this.byPortfolio,
    required this.byClients,
    required this.byLocation,
    required this.detail,
  });
  final bool byPortfolio;
  final bool byClients;
  final bool byLocation;
  final String detail;
}

class BranchSummary {
  BranchSummary({
    required this.name,
    required this.currentPortfolio,
    required this.activeClients,
    required this.employees,
    required this.location,
    required this.category,
  });

  factory BranchSummary.fromJson(Map<String, dynamic> json) {
    String parseString(dynamic v) =>
        v is String ? v : (v != null ? v.toString() : '');
    return BranchSummary(
      name: parseString(json['nombre']),
      currentPortfolio: (json['carteraActual'] as num?)?.toDouble() ?? 0.0,
      activeClients: (json['clientesActivos'] as num?)?.toInt() ?? 0,
      employees: (json['empleados'] as num?)?.toInt() ?? 0,
      location: parseString(json['ubicacion']),
      category: parseString(json['categoria']),
    );
  }
  final String name;
  final double currentPortfolio;
  final int activeClients;
  final int employees;
  final String location;
  final String category;
}

class ProjectionSummary {
  ProjectionSummary({
    required this.currentPortfolio,
    required this.projectedPortfolio,
    required this.delta,
    required this.discountRate,
    required this.presentValue,
    required this.annualValue,
  });

  factory ProjectionSummary.fromJson(Map<String, dynamic> json) {
    return ProjectionSummary(
      currentPortfolio: (json['carteraActual'] as num?)?.toDouble() ?? 0.0,
      projectedPortfolio:
          (json['carteraProyectada'] as num?)?.toDouble() ?? 0.0,
      delta: (json['delta'] as num?)?.toDouble() ?? 0.0,
      discountRate: (json['tasaDescuento'] as num?)?.toDouble() ?? 0.0,
      presentValue: (json['valorPresente'] as num?)?.toDouble() ?? 0.0,
      annualValue: (json['valorAnual'] as num?)?.toDouble() ?? 0.0,
    );
  }
  final double currentPortfolio;
  final double projectedPortfolio;
  final double delta;
  final double discountRate;
  final double presentValue;
  final double annualValue;
}

class ProjectionCategory {
  ProjectionCategory({
    required this.type,
    required this.branches,
    required this.newClients,
    required this.projectedPlacement,
    required this.portfolioBalance,
  });

  factory ProjectionCategory.fromJson(Map<String, dynamic> json) {
    String parseString(dynamic v) =>
        v is String ? v : (v != null ? v.toString() : '');
    return ProjectionCategory(
      type: parseString(json['tipo']),
      branches: (json['sucursales'] as num?)?.toInt() ?? 0,
      newClients: (json['clientesNuevos'] as num?)?.toInt() ?? 0,
      projectedPlacement:
          (json['colocacionProyectada'] as num?)?.toDouble() ?? 0.0,
      portfolioBalance: (json['saldoCartera'] as num?)?.toDouble() ?? 0.0,
    );
  }
  final String type;
  final int branches;
  final int newClients;
  final double projectedPlacement;
  final double portfolioBalance;
}

class IncomeProjectionReport {
  IncomeProjectionReport({
    required this.criteria,
    required this.branches,
    required this.projectionSummary,
    required this.projectionCategories,
  });

  factory IncomeProjectionReport.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> parseMap(dynamic v) =>
        v is Map<String, dynamic> ? v : <String, dynamic>{};
    List<dynamic> parseList(dynamic v) => v is List ? v : <dynamic>[];

    final proj = json['proyeccionIngresos'];
    final summary = proj is Map<String, dynamic> ? proj['summary'] : null;
    final categories = proj is Map<String, dynamic> ? proj['categorias'] : null;

    return IncomeProjectionReport(
      criteria: ClassificationCriteria.fromJson(
        parseMap(json['criteriosClasificacion']),
      ),
      branches: parseList(
        json['sucursales'],
      ).map((e) => BranchSummary.fromJson(e as Map<String, dynamic>)).toList(),
      projectionSummary: ProjectionSummary.fromJson(
        parseMap(summary),
      ),
      projectionCategories: parseList(categories)
          .map((e) => ProjectionCategory.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
  final ClassificationCriteria criteria;
  final List<BranchSummary> branches;
  final ProjectionSummary projectionSummary;
  final List<ProjectionCategory> projectionCategories;
}
