import 'package:z_charts/exportable/enums/period_type_emun.dart';

Map<String, DateTime>? getPeriodDatesUtil(String periodTypeStr) {
  final now = DateTime.now();
  PeriodTypeEnum periodType =
      PeriodTypeEnum.values.where((item) => item.name == periodTypeStr).first;
  switch (periodType) {
    case PeriodTypeEnum.THIS_YEAR:
      return {
        'fromDate': DateTime(now.year, 1, 1),
        'toDate': DateTime(now.year, 12, 31),
      };
    case PeriodTypeEnum.THIS_MONTH:
      return {
        'fromDate': DateTime(now.year, now.month, 1),
        'toDate': DateTime(now.year, now.month + 1, 0),
      };
    case PeriodTypeEnum.THIS_WEEK:
      final int currentWeekday =
          DateTime.now().weekday; // Monday = 1, Sunday = 7
      var fromDate = DateTime.now().subtract(
        Duration(days: currentWeekday - 1),
      ); // Go back to Monday
      var toDate = fromDate.add(
        const Duration(days: 6),
      ); // Sunday of the same week
      return {'fromDate': fromDate, 'toDate': toDate};
    case PeriodTypeEnum.CUSTOM:
      return null;
  }
}
