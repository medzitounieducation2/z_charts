import 'package:z_charts/pages/product/product.dart';
import 'package:z_charts/services/z_charts_service.dart';

class ProductChartsService extends ZChartsService<Product>{
  @override
  List<Map<String, dynamic>> convertEntities(List<Product> entities) {
    var result = entities.map((Product entity) {
      var obj = {
        'value': entity.value.toDouble() / 10,
        'timestamp': entity.timestamp,
      };
      return obj;
    });
    return result.toList();
  }
}