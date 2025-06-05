import 'package:z_charts/exportable/models/z_data.dart';

class Product implements ZData {
  int? key;
  String unit;
  num value;
  DateTime timestamp;

  @override
  get id => key;

  @override
  set id(value) => key = value;

  static Product empty() =>
      Product(key: null, unit: 'step', value: 0, timestamp: DateTime.now());

  Product({
    required this.unit,
    required this.value,
    required this.timestamp,
    required this.key,
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

  static Product clone(Product entity) {
    return Product(
      key: entity.key,
      unit: entity.unit,
      value: entity.value,
      timestamp: entity.timestamp,
    );
  }
}
