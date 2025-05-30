import 'package:z_charts/models/z_data_model.dart';

class Product extends ZDataModel {
  String unit;
  num value;
  DateTime timestamp;

  static Product empty() =>
      Product(id: null, unit: 'step', value: 0, timestamp: DateTime.now());

  Product({
    required this.unit,
    required this.value,
    required this.timestamp,
    required super.id,
  });

  bool isFormValueValid() {
    return unit.isNotEmpty && value > 0;
  }

  void formValueClear() {
    unit = 'step';
    timestamp = DateTime.now();
    value = 0;
    id = null;
  }

  @override
  Product fromJson(Map<String, dynamic> dynamicData, dynamic id) {
    return Product(
      id: id,
      unit: dynamicData['unit'],
      value: dynamicData['value'],
      timestamp: dynamicData['timestamp'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {'unit': unit, 'value': value, 'timestamp': timestamp};
  }

  static Product clone(Product entity) {
    return Product(
      id: entity.id,
      unit: entity.unit,
      value: entity.value,
      timestamp: entity.timestamp,
    );
  }
}
