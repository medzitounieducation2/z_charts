import 'package:z_charts/exportable/index.dart';

class SampleChartParams implements ZParams {
  int? key;

  @override
  String chartType;

  @override
  DateTime fromDate;

  @override
  DateTime toDate;

  @override
  var pageId;

  @override
  String periodType;

  @override
  String timeUnit;

  @override
  get id => key;

  @override
  set id(value) {}

  SampleChartParams({
    this.key,
    required this.chartType,
    required this.fromDate,
    required this.toDate,
    required this.periodType,
    required this.timeUnit,
    required this.pageId
  });

  static SampleChartParams empty() => SampleChartParams(
    key: null,
    periodType: PeriodTypeEnum.THIS_MONTH.name,
    pageId: '',
    timeUnit: TimeUnitEnum.DAY.name,
    chartType: ChartTypeEnum.LINE.name,
    fromDate: DateTime.now(),
    toDate: DateTime.now(),
  );

  static SampleChartParams clone(SampleChartParams entity) {
    return SampleChartParams(
      key: entity.key,
      pageId: entity.pageId,
      fromDate: entity.fromDate,
      toDate: entity.toDate,
      periodType: entity.periodType,
      chartType: entity.chartType,
      timeUnit: entity.timeUnit,
    );
  }
}
