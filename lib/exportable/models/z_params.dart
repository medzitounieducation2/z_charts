import 'package:z_charts/exportable/models/z_data.dart';

abstract class ZParams extends ZData {
  get pageId;
  set pageId(value);

  DateTime get fromDate;
  set fromDate(DateTime value);

  DateTime get toDate;
  set toDate(DateTime value);

  String get periodType;
  set periodType(String value);

  String get chartType;
  set chartType(String value);

  String get timeUnit;
  set timeUnit(String value);
}
