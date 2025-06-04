import 'dart:math';

import 'package:z_charts/examples/sample_app/models/product.dart';
import 'package:z_charts/package/services/z_data_service.dart';

class ProductService extends ZDataService<Product> {
  List<Product> data = [];

  buildItems(int count, int mltp) {
    DateTime now = DateTime.now();
    data = List.generate(count, (index) {
      final random = Random();
      final value = (random.nextDouble() * 50 + 1) * mltp;
      final randomDay = random.nextInt(count);
      final randomHour = random.nextInt(24);
      final date = now.subtract(Duration(days: randomDay, hours: randomHour));
      var product = Product(unit: 'step', value: value, timestamp: date, id: index);
      return product;
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

  Future<void> deleteEntity(Product entity) async {
    data.removeWhere((item) => item.id == entity.id);
  }

  @override
  Future<List<Product>> fetchEntitiesBetween(DateTime startDate, DateTime endDate) async {
    return data.where((item) =>
    item.timestamp.isAfter(startDate) && item.timestamp.isBefore(endDate)
    ).toList();
  }

  Future<List<Product>> getEntities() async {
    return List.from(data);
  }

  Future<Product?> getEntityById(dynamic id) async {
    final intId = int.tryParse(id);
    return data.firstWhere((item) => item.id == intId);
  }

  @override
  Future<void> updateEntity(dynamic id, Product newValue) async {
    final intId = int.tryParse(id);
    final index = data.indexWhere((item) => item.id == intId);
    if (index != -1) {
      data[index] = newValue;
    }
  }

  @override
  List<Map<String, dynamic>> adaptData(List<Product> data) {
    return data.map((Product entity) {
      var obj = {
        'value': entity.value.toDouble(),
        'timestamp': entity.timestamp,
      };
      return obj;
    }).toList();
  }
}