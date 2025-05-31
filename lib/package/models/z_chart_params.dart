import 'package:z_charts/package/models/z_data_model.dart';

class ZChartParams extends ZDataModel {
  dynamic pageId;
  DateTime fromDate;
  DateTime toDate;
  String periodType;
  String chartType;
  String timeUnit;

  static ZChartParams empty() => ZChartParams(
    id: 1,
    periodType: 'this_month',
    pageId: '',
    timeUnit: 'day',
    chartType: 'line',
    fromDate: DateTime.now(),
    toDate: DateTime.now(),
  );

  ZChartParams({
    required super.id,
    required this.pageId,
    required this.fromDate,
    required this.toDate,
    required this.chartType,
    required this.timeUnit,
    required this.periodType,
  });

  @override
  ZChartParams fromJson(Map<String, dynamic> json, dynamic id) {
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

  @override
  Map<String, dynamic> toJson() {
    return {
      'pageId': pageId,
      'fromDate': fromDate,
      'toDate': toDate,
      'chartType': chartType,
      'timeUnit': timeUnit,
      'periodType': periodType,
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
