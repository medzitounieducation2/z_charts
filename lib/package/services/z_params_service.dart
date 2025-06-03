import 'package:z_charts/package/models/z_params.dart';
import 'package:z_charts/package/services/z_data_service.dart';

abstract class ZParamsService extends ZDataService<ZParams> {
  Future<ZParams?> getByPageId(dynamic pageId);
}