
import 'package:z_charts/models/z_data_model.dart';

abstract class ZChartsService<T extends ZDataModel> {
  List<Map<String, dynamic>> convertEntities(List<T> entities);
}