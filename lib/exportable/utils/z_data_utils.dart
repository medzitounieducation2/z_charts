import 'package:intl/intl.dart';
import 'package:z_charts/exportable/enums/z_time_unit_enum.dart';
import 'package:z_charts/exportable/models/z_params.dart';

class ZDataUtils {
  List<Map<String, dynamic>> build(
      List<Map<String, dynamic>> filteredData, ZParams setting) {
    // Apply time unit
    Map<String, Map<String, dynamic>> groupedData = {};

    for (var item in filteredData) {
      DateTime timestamp = item['timestamp'];
      double value = item['value'];

      String key;
      DateTime newTimestamp;

      TimeUnitEnum timeUnit = TimeUnitEnum.values.where((item) => item.name == setting.timeUnit).first;

      switch (timeUnit) {
        case TimeUnitEnum.HOUR:
          key = DateFormat('yyyy-MM-dd HH').format(timestamp);
          newTimestamp = DateTime(
              timestamp.year, timestamp.month, timestamp.day, timestamp.hour);
          break;
        case TimeUnitEnum.DAY:
          key = DateFormat('yyyy-MM-dd').format(timestamp);
          newTimestamp = DateTime(
              timestamp.year, timestamp.month, timestamp.day, 12, 0); // Midday
          break;
        case TimeUnitEnum.WEEK:
          DateTime monday =
              timestamp.subtract(Duration(days: timestamp.weekday - 1));
          key = DateFormat('yyyy-MM-dd').format(monday);
          newTimestamp = monday;
          break;
        case TimeUnitEnum.MONTH:
          key = '${timestamp.year}-${timestamp.month}';
          newTimestamp = DateTime(timestamp.year, timestamp.month, 1);
          break;
        case TimeUnitEnum.YEAR:
          key = '${timestamp.year}';
          newTimestamp = DateTime(timestamp.year, 1, 1);
          break;
      }

      if (groupedData.containsKey(key)) {
        groupedData[key]!['value'] += value;
      } else {
        groupedData[key] = {'timestamp': newTimestamp, 'value': value};
      }
    }
    return groupedData.values.toList();
  }
}
