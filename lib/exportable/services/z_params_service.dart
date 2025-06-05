import 'package:z_charts/exportable/models/z_params.dart';
import 'package:z_charts/exportable/services/z_data_service.dart';

abstract class ZParamsService<T extends ZParams> extends ZDataService<T> {
  Future<T?> getByPageId(dynamic pageId);

  @override
  List<Map<String, dynamic>> adaptData(List<T> data) {
    return [];
  }
  @override
  Future<List<T>> fetchEntitiesBetween(DateTime startDate, DateTime endDate) {
    return Future.value([]);
  }
}