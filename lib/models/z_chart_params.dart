
class ZChartParams {
  dynamic id;
  String pageId;
  DateTime fromDate;
  DateTime toDate;
  String periodType;
  String chartType;
  String timeUnit;

  ZChartParams({this.id, required this.pageId, required this.fromDate, required this.toDate, required this.chartType, required this.timeUnit, required this.periodType});

  static ZChartParams fromJson(Map<String, dynamic> json, dynamic id) {
    return ZChartParams(
      id: id,
      pageId: json['pageId'],
      fromDate: json['fromDate'],
      toDate: json['toDate'],
      chartType: json['chartType'],
      timeUnit: json['timeUnit'],
        periodType: json['periodType'],
        );
  }

  static Map<String, dynamic> toJson(ZChartParams entity) {
    return {
      'pageId': entity.pageId,
      'fromDate': entity.fromDate,
      'toDate': entity.toDate,
      'chartType': entity.chartType,
      'timeUnit': entity.timeUnit,
      'periodType': entity.periodType
    };
  }

  static ZChartParams clone(ZChartParams entity) {
    return ZChartParams(
        id: entity.id,
        pageId: entity.pageId,
        fromDate: entity.fromDate,
        toDate: entity.toDate,
      periodType: entity.periodType,
      chartType: entity.chartType,
      timeUnit: entity.timeUnit,
    );
  }
}