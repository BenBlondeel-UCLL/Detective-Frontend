import 'package:intl/intl.dart';

class DateUtil {
  static const String dateFormat = 'yyyy-MM-dd';
  static const String timeFormat = 'HH:mm:ss';
  static const String dateTimeFormat = 'yyyy-MM-dd HH:mm:ss';
  static const String dateTimeWithMsFormat = 'yyyy-MM-dd HH:mm:ss.SSS';
  static const String dateTimeWithZoneFormat = 'yyyy-MM-dd HH:mm:ss Z';
  static String getDdMMyyyy(String dateTime) => DateFormat('dd/MM/yyyy').format(DateTime.parse(dateTime));
}