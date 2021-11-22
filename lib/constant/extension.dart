import 'package:jiffy/jiffy.dart';

extension JiffyExtensions on Jiffy {
  /// determines if Jiffy DateTime instance falls on today
  bool get isToday {
    var now = Jiffy();
    return this.isSame(now, Units.DAY);
  }

  /// determines if Jiffy DateTime instance falls on Yesterday or the previous day
  bool get isYesterday {
    var yesterday = Jiffy().subtract(days: 1);
    return this.isSame(yesterday, Units.DAY);
  }

  /// determines if Jiffy DateTime instance falls on the same week as current date
  bool get isThisWeek {
    var now = Jiffy();
    return this.isSame(now, Units.WEEK);
  }
}
