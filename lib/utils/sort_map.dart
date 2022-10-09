import 'package:online_attendence_app/models/attendance.dart';

sortMap({required Attendance attendanceModel}) {
  return Map.fromEntries(attendanceModel.attendance!.entries.toList()
    ..sort((e1, e2) => e1.key.compareTo(e2.key)));
}
