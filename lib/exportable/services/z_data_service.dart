import 'package:z_charts/exportable/models/z_data.dart';

abstract class ZDataService<T extends ZData> {
  Future<T> addEntity(T entity);
  Future<void> updateEntity(dynamic id, T newValue);
  Future<List<T>> fetchEntitiesBetween(DateTime startDate, DateTime endDate);
  List<Map<String, dynamic>> adaptData(List<T> data);
}