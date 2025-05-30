import 'dart:math';

import 'package:z_charts/pages/product/product.dart';
import 'package:z_charts/services/z_data_service.dart';

class ProductService extends ZDataService<Product> {
  List<Product> data = [];

  buildItems(int count) {
    DateTime now = DateTime.now();
    data = List.generate(count, (index) {
      final random = Random();
      final value = random.nextDouble() * count + 10;
      final randomDay = random.nextInt(count);
      final randomHour = random.nextInt(24);
      final date = now.subtract(Duration(days: randomDay, hours: randomHour));
      var walking = Product(unit: 'step', value: value, timestamp: date, id: index);
      return walking;
    }).toList();
  }

  @override
  Future<Product> addEntity(Product entity) async {
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
  Future<void> deleteEntity(Product entity) async {
    data.removeWhere((item) => item.id == entity.id);
  }

  @override
  Future<List<Product>> fetchByIds(List<String> docIds) async {
    final ids = docIds.map(int.parse).toSet();
    return data.where((item) => ids.contains(item.id)).toList();
  }

  @override
  Future<List<Product>> fetchEntitiesBetween(DateTime startDate, DateTime endDate) async {
    return data.where((item) =>
    item.timestamp.isAfter(startDate) && item.timestamp.isBefore(endDate)
    ).toList();
  }

  @override
  Future<List<Product>> getEntities() async {
    return List.from(data);
  }

  @override
  Future<Product?> getEntityById(String id) async {
    final intId = int.tryParse(id);
    return data.firstWhere((item) => item.id == intId);
  }

  @override
  Future<void> updateEntity(String docId, Product newValue) async {
    final intId = int.tryParse(docId);
    final index = data.indexWhere((item) => item.id == intId);
    if (index != -1) {
      data[index] = newValue;
    }
  }
}