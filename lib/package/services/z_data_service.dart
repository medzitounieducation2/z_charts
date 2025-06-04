import 'package:z_charts/package/models/z_data_model.dart';

abstract class ZDataService<T extends ZDataModel> {
  Future<T> addEntity(T entity);
  Future<void> updateEntity(dynamic id, T newValue);
  Future<List<T>> fetchEntitiesBetween(DateTime startDate, DateTime endDate);
  List<Map<String, dynamic>> adaptData(List<T> data);
}