import 'package:z_charts/exportable/enums/z_chart_type_enum.dart';
import 'package:z_charts/exportable/enums/z_period_type_emun.dart';
import 'package:z_charts/exportable/enums/z_time_unit_enum.dart';
import 'package:z_charts/exportable/models/z_data_model.dart';

class ZParams extends ZDataModel {
  dynamic pageId;
  DateTime fromDate;
  DateTime toDate;
  String periodType;
  String chartType;
  String timeUnit;

  static ZParams empty() => ZParams(
    id: null,
    periodType: PeriodTypeEnum.THIS_MONTH.name,
    pageId: '',
    timeUnit: TimeUnitEnum.DAY.name,
    chartType: ChartTypeEnum.LINE.name,
    fromDate: DateTime.now(),
    toDate: DateTime.now(),
  );

  ZParams({
    super.id,
    required this.pageId,
    required this.fromDate,
    required this.toDate,
    required this.chartType,
    required this.timeUnit,
    required this.periodType,
  });

  static ZParams clone(ZParams entity) {
    return ZParams(
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
