import 'package:z_charts/package/models/z_data_model.dart';

abstract class ZDataService<T extends ZDataModel> {
  Future<T> addEntity(T entity);
  Future<void> updateEntity(String docId, T newValue);
  Future<void> deleteEntity(T entity);
  Future<T?> getEntityById(String id);
  Future<List<T>> getEntities();
  Future<List<T>> fetchEntitiesBetween(DateTime startDate, DateTime endDate);
  Future<List<T>> fetchByIds(List<String> docIds);
  List<Map<String, dynamic>> adaptData(List<T> data);
}