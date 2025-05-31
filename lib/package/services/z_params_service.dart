import 'package:z_charts/package/models/z_chart_params.dart';
import 'package:z_charts/package/services/z_data_service.dart';

abstract class ZParamsService extends ZDataService<ZChartParams> {
  Future<ZChartParams?> getByPageId(dynamic pageId);
}