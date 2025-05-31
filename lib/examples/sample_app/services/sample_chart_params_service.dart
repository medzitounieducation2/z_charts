import 'package:z_charts/package/models/z_chart_params.dart';
import 'package:z_charts/package/services/z_params_service.dart';

class SampleChartParamsService extends ZParamsService {
  List<ZChartParams> data = [];

  @override
  Future<ZChartParams> addEntity(ZChartParams entity) async {
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
  Future<void> deleteEntity(ZChartParams entity) async {
    data.removeWhere((item) => item.id == entity.id);
  }

  @override
  Future<List<ZChartParams>> fetchEntitiesBetween(DateTime startDate, DateTime endDate) async {
    return data.where((item) =>
    item.fromDate.isAfter(startDate) && item.fromDate.isBefore(endDate)
    ).toList();
  }

  @override
  Future<List<ZChartParams>> getEntities() async {
    return List.from(data);
  }

  @override
  Future<ZChartParams?> getEntityById(dynamic id) async {
    final intId = int.tryParse(id);
    return data.firstWhere((item) => item.id == intId);
  }

  @override
  Future<void> updateEntity(dynamic id, ZChartParams newValue) async {
    final intId = int.tryParse(id);
    final index = data.indexWhere((item) => item.id == intId);
    if (index != -1) {
      data[index] = newValue;
    }
  }

  @override
  List<Map<String, dynamic>> adaptData(List<ZChartParams> data) {
    return [];
  }

  @override
  Future<ZChartParams?> getByPageId(dynamic pageId) async {
    var found = data.where((item) => item.pageId == pageId);
    if(found.isEmpty) {
      return null;
    }
    return found.first;
  }
}