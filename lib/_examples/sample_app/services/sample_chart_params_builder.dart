import 'package:z_charts/_examples/sample_app/models/sample_chart_params.dart';
import 'package:z_charts/exportable/services/z_params_builder.dart';

class SampleChartParamsBuilder implements ZParamsBuilder<SampleChartParams> {
  @override
  SampleChartParams clone(SampleChartParams t) {
    return SampleChartParams.clone(t);
  }

  @override
  SampleChartParams getEmpty() {
    return SampleChartParams.empty();
  }
}