import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:z_charts/package/dialogs/date_picker.dart';
import 'package:z_charts/package/enums/period_type_emun.dart';
import 'package:z_charts/package/models/z_params.dart';
import 'package:z_charts/package/utils/period_dates_util.dart';

class ZParamsWidget extends StatefulWidget {
  final ZParams chartParams;
  final Function(ZParams) settingOutput;

  const ZParamsWidget({
    super.key,
    required this.chartParams,
    required this.settingOutput,
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

  /*void _updateStateFromSettings(List<ChartSetting> settings) {
    var foundDefault = settings.firstWhere((obj) => obj.isDefault);
    var foundWelcome = settings.firstWhere((obj) => obj.isWelcome);

    setState(() {
      defaultSetting = foundDefault;
      welcomeSetting = foundWelcome;
      savedSetting = foundDefault;
      setting = ChartSetting.clone(foundDefault);
      pageSettings = settings;
      widget.settingOutput(setting!);
    });
  }

  void openSaveSettingDialog() {
    showDialog(
      context: context,
      builder:
          (context) => SaveSettingDialog(
            setting: setting!,
            defaultSetting: defaultSetting!,
            welcomeSetting: welcomeSetting!,
            settingSavedOutput: _settingSavedFromDialog,
          ),
    );
  }

  _settingSavedFromDialog(isUpdated) {
    initSettings();
  }

  selectSetting(name) {
    if (pageSettings!.isNotEmpty) {
      var found = pageSettings!.firstWhere((obj) => obj.name == name);
      setState(() {
        savedSetting = found;
        setting = ChartSetting.clone(found);
        widget.settingOutput(found);
      });
    }
  }*/

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Card(
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
                          style: TextStyle(fontSize: 10),
                        ),
                      ),
                      Text('-', style: TextStyle(fontSize: 10)),
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
                          style: TextStyle(fontSize: 10),
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
                          style: TextStyle(fontSize: 10),
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
                          style: TextStyle(fontSize: 10),
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
                          style: TextStyle(fontSize: 10),
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
                              params!.chartType == 'bar'
                                  ? Colors.blueGrey[200]
                                  : null,
                        ),
                        icon: Icon(Icons.bar_chart),
                        onPressed: () {
                          setState(() {
                            params!.chartType = 'bar';
                            widget.settingOutput(params!);
                          });
                        },
                      ),
                      IconButton(
                        style: IconButton.styleFrom(
                          backgroundColor:
                              params!.chartType == 'line'
                                  ? Colors.blueGrey[200]
                                  : null,
                        ),
                        icon: Icon(Icons.stacked_line_chart),
                        onPressed: () {
                          setState(() {
                            params!.chartType = 'line';
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
                            params!.timeUnit = 'hour';
                            widget.settingOutput(params!);
                          });
                        },
                        style: TextButton.styleFrom(
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          backgroundColor:
                              params!.timeUnit == 'hour'
                                  ? Colors.blueGrey[200]
                                  : null,
                          minimumSize: Size(10, 10),
                        ),
                        child: Text('Hour', style: TextStyle(fontSize: 10)),
                      ),
                      TextButton(
                        onPressed: () {
                          params!.timeUnit = 'day';
                          widget.settingOutput(params!);
                        },
                        style: TextButton.styleFrom(
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          backgroundColor:
                              params!.timeUnit == 'day'
                                  ? Colors.blueGrey[200]
                                  : null,
                          minimumSize: Size(10, 10),
                        ),
                        child: Text('Day', style: TextStyle(fontSize: 10)),
                      ),
                      TextButton(
                        onPressed: () {
                          params!.timeUnit = 'week';
                          widget.settingOutput(params!);
                        },
                        style: TextButton.styleFrom(
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          backgroundColor:
                              params!.timeUnit == 'week'
                                  ? Colors.blueGrey[200]
                                  : null,
                          minimumSize: Size(10, 10),
                        ),
                        child: Text('Week', style: TextStyle(fontSize: 10)),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      TextButton(
                        onPressed: () {
                          params!.timeUnit = 'month';
                          widget.settingOutput(params!);
                        },
                        style: TextButton.styleFrom(
                          backgroundColor:
                              params!.timeUnit == 'month'
                                  ? Colors.blueGrey[200]
                                  : null,
                          minimumSize: Size(10, 10),
                        ),
                        child: Text('Month', style: TextStyle(fontSize: 10)),
                      ),
                      TextButton(
                        onPressed: () {
                          params!.timeUnit = 'year';
                          widget.settingOutput(params!);
                        },
                        style: TextButton.styleFrom(
                          backgroundColor:
                              params!.timeUnit == 'year'
                                  ? Colors.blueGrey[200]
                                  : null,
                          minimumSize: Size(10, 10),
                        ),
                        child: Text('Year', style: TextStyle(fontSize: 10)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  /*Positioned(
              bottom: 10.0,
              right: 5.0,
              child: buildFloatingActionButton()
            ),*/

  /*Widget buildFloatingActionButton() {
    return SpeedDial(
      buttonSize: Size(45.0, 45.0),
      icon: Icons.menu,
      activeIcon: Icons.close,
      backgroundColor:  Colors.blueGrey,
      foregroundColor: Colors.white,
      children: [
        SpeedDialChild(
          child: Icon(Icons.save),
          label: 'Save',
          backgroundColor:
              isSettingModified(setting, savedSetting) ? Colors.green[200] : Colors.grey,
          onTap: () {
            if (isSettingModified(setting, savedSetting)) {
              openSaveSettingDialog();
            }
          },
        ),
        SpeedDialChild(
          child: Icon(Icons.delete),
          label: 'Delete',
          backgroundColor: Colors.red[200],
          onTap: () {
            confirmationDialog(
              context,
              ConfirmationConfig(
                title: "Confirm Deletion",
                question: "Are you sure you want to delete this item?",
                actionColor: Colors.redAccent,
              ),
              () {
                Provider.of<ChartSettingService>(
                  context,
                  listen: false,
                ).deleteEntity(setting!.docId!).then((value) {
                  initSettings();
                });
              },
            );
          },
        ),
      ],
    );
  }*/
}
