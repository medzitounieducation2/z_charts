import 'package:z_charts/package/models/z_params.dart';
import 'package:z_charts/package/services/z_params_service.dart';

class SampleChartParamsService extends ZParamsService {
  List<ZParams> data = [];

  @override
  Future<ZParams> addEntity(ZParams entity) async {
    if (data.isEmpty) {
      entity.id = 0;
    } else {
      final ids = data.map((e) => e.id).toList();
      ids.sort();
      entity.id = ids.last + 1;
    }
    data.add(entity);
    return entity;
  }

  @override
  Future<List<ZParams>> fetchEntitiesBetween(DateTime startDate, DateTime endDate) async {
    return data.where((item) =>
    item.fromDate.isAfter(startDate) && item.fromDate.isBefore(endDate)
    ).toList();
  }

  @override
  Future<void> updateEntity(dynamic id, ZParams newValue) async {
    final index = data.indexWhere((item) => item.id == id);
    if (index != -1) {
      data[index] = newValue;
    }
  }

  @override
  List<Map<String, dynamic>> adaptData(List<ZParams> data) {
    return [];
  }

  @override
  Future<ZParams?> getByPageId(dynamic pageId) async {
    var found = data.where((item) => item.pageId == pageId);
    if(found.isEmpty) {
      return null;
    }
    return found.first;
  }
}