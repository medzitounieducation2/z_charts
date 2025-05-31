import 'package:intl/intl.dart';
import 'package:z_charts/package/models/z_chart_params.dart';

class ZChartDataUtils {
  List<Map<String, dynamic>> build(
      List<Map<String, dynamic>> filteredData, ZChartParams setting) {
    // Apply time unit
    Map<String, Map<String, dynamic>> groupedData = {};

    for (var item in filteredData) {
      DateTime timestamp = item['timestamp'];
      double value = item['value'];

      String key;
      DateTime newTimestamp;

      switch (setting.timeUnit) {
        case 'hour':
          key = DateFormat('yyyy-MM-dd HH').format(timestamp);
          newTimestamp = DateTime(
              timestamp.year, timestamp.month, timestamp.day, timestamp.hour);
          break;
        case 'day':
          key = DateFormat('yyyy-MM-dd').format(timestamp);
          newTimestamp = DateTime(
              timestamp.year, timestamp.month, timestamp.day, 12, 0); // Midday
          break;
        case 'week':
          DateTime monday =
              timestamp.subtract(Duration(days: timestamp.weekday - 1));
          key = DateFormat('yyyy-MM-dd').format(monday);
          newTimestamp = monday;
          break;
        case 'month':
          key = '${timestamp.year}-${timestamp.month}';
          newTimestamp = DateTime(timestamp.year, timestamp.month, 1);
          break;
        case 'year':
          key = '${timestamp.year}';
          newTimestamp = DateTime(timestamp.year, 1, 1);
          break;
        default:
          throw ArgumentError('Invalid time unit: ${setting.timeUnit}');
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
