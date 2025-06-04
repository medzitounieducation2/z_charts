import 'package:flutter/material.dart';

Future<void> zDatePicker(BuildContext context, Function callback, DateTime? initialDate, DateTime? firstDate, DateTime? lastDate) async {
  DateTime now = DateTime.now();

  // Pick a Date
  DateTime? pickedDate = await showDatePicker(
    context: context,
    initialDate: initialDate ?? DateTime.now(),
    firstDate: firstDate ?? DateTime(now.year - 10),
    lastDate: lastDate ?? DateTime(now.year + 10),
  );

  if (pickedDate == null) return; // User canceled

  // Combine date and time
  DateTime finalDateTime = DateTime(
    pickedDate.year,
    pickedDate.month,
    pickedDate.day,
  );

  callback(finalDateTime);
}
