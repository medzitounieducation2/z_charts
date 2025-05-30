import 'package:z_charts/pages/walking/walking.dart';
import 'package:z_charts/services/z_charts_service.dart';

class WalkingChartsService extends ZChartsService<Walking>{
  @override
  List<Map<String, dynamic>> convertEntities(List<Walking> entities) {
    var result = entities.map((Walking entity) {
      var obj = {
        'value': entity.value.toDouble() / 10,
        'timestamp': entity.timestamp,
      };
      return obj;
    });
    return result.toList();
  }
}