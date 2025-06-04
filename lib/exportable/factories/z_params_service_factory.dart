import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:z_charts/exportable/services/z_params_service.dart';

class ZParamsServiceFactory {
  static ZParamsService paramsService(BuildContext context) {
    return Provider.of<ZParamsService>(context, listen: false);
  }
}