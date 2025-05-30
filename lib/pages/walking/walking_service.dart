import 'dart:math';

import 'package:z_charts/pages/walking/walking.dart';
import 'package:z_charts/services/z_data_service.dart';

class WalkingService extends ZDataService<Walking> {
  List<Walking> data = [];
  int max = 50;
  WalkingService() {
    DateTime now = DateTime.now();
    data = List.generate(max, (index) {
      final random = Random();
      final value = random.nextDouble() * max + 10;
      final randomDay = random.nextInt(max);
      final randomHour = random.nextInt(24);
      final date = now.subtract(Duration(days: randomDay, hours: randomHour));
      var walking = Walking(unit: 'step', value: value, timestamp: date, id: index);
      return walking;
    }).toList();
  }

  @override
  Future<Walking> addEntity(Walking entity) async {
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
  Future<void> deleteEntity(Walking entity) async {
    data.removeWhere((item) => item.id == entity.id);
  }

  @override
  Future<List<Walking>> fetchByIds(List<String> docIds) async {
    final ids = docIds.map(int.parse).toSet();
    return data.where((item) => ids.contains(item.id)).toList();
  }

  @override
  Future<List<Walking>> fetchEntitiesBetween(DateTime startDate, DateTime endDate) async {
    return data.where((item) =>
    item.timestamp.isAfter(startDate) && item.timestamp.isBefore(endDate)
    ).toList();
  }

  @override
  Future<List<Walking>> getEntities() async {
    return List.from(data);
  }

  @override
  Future<Walking?> getEntityById(String id) async {
    final intId = int.tryParse(id);
    return data.firstWhere((item) => item.id == intId);
  }

  @override
  Future<void> updateEntity(String docId, Walking newValue) async {
    final intId = int.tryParse(docId);
    final index = data.indexWhere((item) => item.id == intId);
    if (index != -1) {
      data[index] = newValue;
    }
  }
}