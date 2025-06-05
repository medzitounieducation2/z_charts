import 'package:z_charts/exportable/models/z_params.dart';

abstract class ZParamsBuilder<T extends ZParams> {
  T getEmpty();
  T clone(T t);
}