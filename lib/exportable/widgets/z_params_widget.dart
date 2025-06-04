import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:z_charts/exportable/dialogs/date_picker.dart';
import 'package:z_charts/exportable/enums/chart_type_enum.dart';
import 'package:z_charts/exportable/enums/period_type_emun.dart';
import 'package:z_charts/exportable/enums/time_unit_enum.dart';
import 'package:z_charts/exportable/factories/z_params_service_factory.dart';
import 'package:z_charts/exportable/models/z_params.dart';
import 'package:z_charts/exportable/utils/period_dates_util.dart';

class ZParamsWidget extends StatefulWidget {
  final ZParams chartParams;
  final Function(ZParams) settingOutput;
  final Function(bool) closeOutput;

  const ZParamsWidget({
    super.key,
    required this.chartParams,
    required this.settingOutput,
    required this.closeOutput,
  });

  @override
  State<ZParamsWidget> createState() => _ZParamsWidgetState();
}

class _ZParamsWidgetState extends State<ZParamsWidget> {
  ZParams? params;

  @override
  void initState() {
    super.initState();
    params = ZParams.clone(widget.chartParams);
  }

  saveParams() {
    var service = ZParamsServiceFactory.paramsService(context);
    service.updateEntity(params!.id, params!).then((saved) {
      widget.closeOutput(false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: 200,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 0.0, 0.0, 0.0),
            child: Theme(
              data: Theme.of(
                context,
              ).copyWith(visualDensity: VisualDensity.compact),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Text(
                        'Parameters',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  Divider(),
                  Row(
                    children: [
                      Text(
                        'Period',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      TextButton(
                        onPressed:
                            () => datePicker(
                              context,
                              (dateTime) {
                                setState(() {
                                  params!.fromDate = dateTime;
                                  params!.periodType =
                                      PeriodTypeEnum.CUSTOM.name;
                                  widget.settingOutput(params!);
                                });
                              },
                              params!.fromDate,
                              null,
                              params!.toDate,
                            ),
                        style: TextButton.styleFrom(
                          minimumSize: const Size(40, 30),
                          // Width x Height
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          // Adjust padding for better control
                          tapTargetSize:
                              MaterialTapTargetSize
                                  .shrinkWrap, // Reduces touch target size
                        ),
                        child: Text(
                          DateFormat('yyyy-MM-dd').format(params!.fromDate),
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                      Text('-', style: TextStyle(fontSize: 12)),
                      TextButton(
                        onPressed:
                            () => datePicker(
                              context,
                              (dateTime) {
                                setState(() {
                                  params!.toDate = dateTime;
                                  params!.periodType =
                                      PeriodTypeEnum.CUSTOM.name;
                                  widget.settingOutput(params!);
                                });
                              },
                              params!.toDate,
                              params!.fromDate,
                              null,
                            ),
                        style: TextButton.styleFrom(
                          minimumSize: const Size(40, 30),
                          // Width x Height
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          // Adjust padding for better control
                          tapTargetSize:
                              MaterialTapTargetSize
                                  .shrinkWrap, // Reduces touch target size
                        ),
                        child: Text(
                          DateFormat('yyyy-MM-dd').format(params!.toDate),
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextButton(
                        onPressed: () {
                          setState(() {
                            params!.periodType = PeriodTypeEnum.THIS_YEAR.name;
                            var periodDates = getPeriodDatesUtil(
                              widget.chartParams.periodType,
                            );
                            if (periodDates != null) {
                              params!.fromDate = periodDates['fromDate']!;
                              params!.toDate = periodDates['toDate']!;
                            }
                            widget.settingOutput(params!);
                          });
                        },
                        style: TextButton.styleFrom(
                          minimumSize: Size(10, 10),
                          tapTargetSize:
                              MaterialTapTargetSize
                                  .shrinkWrap, // Shrink hit area
                          backgroundColor:
                              params!.periodType ==
                                      PeriodTypeEnum.THIS_YEAR.name
                                  ? Colors.blueGrey[200]
                                  : null,
                        ),
                        child: Text(
                          'This year',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            params!.periodType = PeriodTypeEnum.THIS_MONTH.name;
                            var periodDates = getPeriodDatesUtil(
                              widget.chartParams.periodType,
                            );
                            if (periodDates != null) {
                              params!.fromDate = periodDates['fromDate']!;
                              params!.toDate = periodDates['toDate']!;
                            }
                            widget.settingOutput(params!);
                          });
                        },
                        style: TextButton.styleFrom(
                          minimumSize: Size(10, 10),
                          tapTargetSize:
                              MaterialTapTargetSize
                                  .shrinkWrap, // Shrink hit area
                          backgroundColor:
                              params!.periodType ==
                                      PeriodTypeEnum.THIS_MONTH.name
                                  ? Colors.blueGrey[200]
                                  : null,
                        ),
                        child: Text(
                          'This month',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      TextButton(
                        onPressed: () {
                          setState(() {
                            params!.periodType = PeriodTypeEnum.THIS_WEEK.name;
                            var periodDates = getPeriodDatesUtil(
                              widget.chartParams.periodType,
                            );
                            if (periodDates != null) {
                              params!.fromDate = periodDates['fromDate']!;
                              params!.toDate = periodDates['toDate']!;
                            }
                            widget.settingOutput(params!);
                          });
                        },
                        style: TextButton.styleFrom(
                          // Remove minimum width/height
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          // Shrink hit area
                          // visualDensity: VisualDensity.compact, // Compact layout
                          minimumSize: Size(10, 10),
                          backgroundColor:
                              params!.periodType ==
                                      PeriodTypeEnum.THIS_WEEK.name
                                  ? Colors.blueGrey[200]
                                  : null,
                        ),
                        child: Text(
                          'This week',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Text(
                        'Chart Type',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        style: IconButton.styleFrom(
                          backgroundColor:
                              params!.chartType == ChartTypeEnum.BAR.name
                                  ? Colors.blueGrey[200]
                                  : null,
                        ),
                        icon: Icon(Icons.bar_chart),
                        onPressed: () {
                          setState(() {
                            params!.chartType = ChartTypeEnum.BAR.name;
                            widget.settingOutput(params!);
                          });
                        },
                      ),
                      IconButton(
                        style: IconButton.styleFrom(
                          backgroundColor:
                              params!.chartType == ChartTypeEnum.LINE.name
                                  ? Colors.blueGrey[200]
                                  : null,
                        ),
                        icon: Icon(Icons.stacked_line_chart),
                        onPressed: () {
                          setState(() {
                            params!.chartType = ChartTypeEnum.LINE.name;
                            widget.settingOutput(params!);
                          });
                        },
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Time Unit',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      TextButton(
                        onPressed: () {
                          setState(() {
                            params!.timeUnit = TimeUnitEnum.HOUR.name;
                            widget.settingOutput(params!);
                          });
                        },
                        style: TextButton.styleFrom(
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          backgroundColor:
                              params!.timeUnit == TimeUnitEnum.HOUR.name
                                  ? Colors.blueGrey[200]
                                  : null,
                          minimumSize: Size(10, 10),
                        ),
                        child: Text('Hour', style: TextStyle(fontSize: 12)),
                      ),
                      TextButton(
                        onPressed: () {
                          params!.timeUnit = TimeUnitEnum.DAY.name;
                          widget.settingOutput(params!);
                        },
                        style: TextButton.styleFrom(
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          backgroundColor:
                              params!.timeUnit == TimeUnitEnum.DAY.name
                                  ? Colors.blueGrey[200]
                                  : null,
                          minimumSize: Size(10, 10),
                        ),
                        child: Text('Day', style: TextStyle(fontSize: 12)),
                      ),
                      TextButton(
                        onPressed: () {
                          params!.timeUnit = TimeUnitEnum.WEEK.name;
                          widget.settingOutput(params!);
                        },
                        style: TextButton.styleFrom(
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          backgroundColor:
                              params!.timeUnit == TimeUnitEnum.WEEK.name
                                  ? Colors.blueGrey[200]
                                  : null,
                          minimumSize: Size(10, 10),
                        ),
                        child: Text('Week', style: TextStyle(fontSize: 12)),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      TextButton(
                        onPressed: () {
                          params!.timeUnit = TimeUnitEnum.MONTH.name;
                          widget.settingOutput(params!);
                        },
                        style: TextButton.styleFrom(
                          backgroundColor:
                              params!.timeUnit == TimeUnitEnum.MONTH.name
                                  ? Colors.blueGrey[200]
                                  : null,
                          minimumSize: Size(10, 10),
                        ),
                        child: Text('Month', style: TextStyle(fontSize: 12)),
                      ),
                      TextButton(
                        onPressed: () {
                          params!.timeUnit = TimeUnitEnum.YEAR.name;
                          widget.settingOutput(params!);
                        },
                        style: TextButton.styleFrom(
                          backgroundColor:
                              params!.timeUnit == TimeUnitEnum.YEAR.name
                                  ? Colors.blueGrey[200]
                                  : null,
                          minimumSize: Size(10, 10),
                        ),
                        child: Text('Year', style: TextStyle(fontSize: 12)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 3.0,
          right: 40.0,
          child: SizedBox(
            width: 32, // Smaller width
            height: 32, // Smaller height
            child: IconButton(
              onPressed: () {
                widget.closeOutput(false);
              },
              icon: Icon(
                Icons.cancel,
                size: 18, // Smaller icon size
              ),
              style: IconButton.styleFrom(
                backgroundColor: Colors.red[200],
                padding: EdgeInsets.zero, // Remove extra padding
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 3.0,
          right: 5.0,
          child: SizedBox(
            width: 32, // Smaller width
            height: 32, // Smaller height
            child: IconButton(
              onPressed: saveParams,
              icon: Icon(
                Icons.save,
                size: 18, // Smaller icon size
              ),
              style: IconButton.styleFrom(
                backgroundColor: Colors.green[200],
                padding: EdgeInsets.zero, // Remove extra padding
              ),
            ),
          ),
        ),
      ],
    );
  }
}
