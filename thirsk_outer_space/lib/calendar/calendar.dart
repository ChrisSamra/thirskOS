/// This file contains all functions and classes related to the calendar system.

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:thirsk_outer_space/general/common_widgets.dart';
import 'package:thirsk_outer_space/strings/string_getter.dart';
import 'package:thirsk_outer_space/general/general_functions.dart';
import 'package:table_calendar/table_calendar.dart';
//import 'package:sprintf/sprintf.dart';

///The type of school day that affects whether students and staffs attend or not.
enum SchoolDayType{
  ///Both students and staffs attend school today
  schoolDay,
  ///No school for students, but staff needs to attend
  nonInstructional,
  ///No school for both students and staffs
  noSchool,
}
// ///The type of duration used in [EventDuration]
// enum DurationType{
//   ///A continuous duration of time. [EventDuration.argument1] specify the start time while [EventDuration.argument2] specify the end time, inclusively.
//   fromTo,
//   ///A single day. [EventDuration.argument1] specify the day of the event.
//   singleDay,
//   ///Weekly event. [EventDuration.argument1] provides a List<bool> of size 7, with the i-th specify whether the event apply to this weekday, starting from Monday.
//   weekly
// }
///The name for each day of the week, starting from monday as 1 and sunday as 7
List<String> weekName = ["","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday"];

/// A class to store a duration of an event. Select a mode and possibly two arguments.
///
/// Example:
/// ```
/// FromToDuration( DateTime(2019,1,1), DateTime(2019,1,15)); // From Jan 1 to Jan 15, 2019.
/// SingleDayDuration( DateTime(2019,3,15)); // On March 15, 2019.
/// EventDuration(DurationType.weekly, [false,true,false,false,false,false,false]); // Every Tuesday
/// ```
abstract class EventDuration{

  /// Check if [currentDate] is under this duration.
  bool isUnderDuration(DateTime currentDate);
  // {
  //   currentDate = new DateTime(currentDate.year,currentDate.month,currentDate.day);
  //   switch(type){
  //     case DurationType.fromTo:
  //       return !((argument1 as DateTime).isAfter(currentDate) || (argument2 as DateTime).isBefore(currentDate));
  //     case DurationType.singleDay:
  //       return (argument1 as DateTime).isAtSameMomentAs(currentDate);
  //     case DurationType.weekly:
  //       return (argument1 as List<bool>)[currentDate.weekday - 1];
  //     default:
  //       break;
  //   }
  //   return false;
  // }

  /// Get a list of Dates that falls under the duration.
  ///
  /// For weekly events, the list is from [startTime] to [endTime], since there's infinite amount of dates that happens weekly.
  /// Throws Error if [type] is weekly and either [startTime] and [endTime] is not specified.
  List<DateTime> getListOfDates([DateTime startTime, DateTime endTime]);
  // {
  //   switch(type){
  //     case DurationType.singleDay:
  //       return [argument1 as DateTime];
  //     case DurationType.fromTo:
  //       List<DateTime> dates = new List();
  //       for(var i = argument1 as DateTime; !(argument2 as DateTime).isBefore(i); i = i.add(Duration(days: 1))){
  //         dates.add(i);
  //         //print(i);
  //       }
  //       return dates;
  //     case DurationType.weekly:
  //       if(startTime == null || endTime == null || startTime.isAfter(endTime))
  //         throw ArgumentError("Type=weekly: startTime and endTime must be specified");
  //       //TODO: add logic to the return value when type=weekly
  //       continue defaultCase;
  //     defaultCase:
  //     default:
  //       break;
  //   }
  //   return [];
  // }
  // @override
  // String toString() {
  //   switch(type){
  //     case DurationType.singleDay:
  //       return "On " + argument1.toString();
  //     case DurationType.fromTo:
  //       return "From " + argument1.toString() + " To " + argument2.toString();
  //     case DurationType.weekly:
  //       String returnString = "";
  //       List tempList = (argument1 as List<bool>);
  //       for(var i = 0; i < tempList.length; i++){
  //         if(tempList[i]){
  //           if(returnString != ""){
  //             returnString += ",";
  //           }
  //           returnString += weekName[i + 1];
  //         }
  //       }
  //       return returnString == "" ? "Weekly(Unidentified)" : "Every " + returnString;
  //     default:
  //       return "Warning: Unidentified Duration Type";
  //   }
  // }
}
class SingleDayDuration extends EventDuration{
  DateTime date;
  SingleDayDuration(this.date);
  @override
  bool isUnderDuration(DateTime currentDate){
    currentDate = new DateTime(currentDate.year,currentDate.month,currentDate.day);
    return date.isAtSameMomentAs(currentDate);
  }
  @override
  List<DateTime> getListOfDates([DateTime startTime,DateTime endTime]){
    return [date];
  }
  @override
  String toString() {
    return "On " + date.toString();
  }
}
class FromToDuration extends EventDuration{
  DateTime startDate;
  DateTime endDate;
  FromToDuration(this.startDate,this.endDate);
  @override
  List<DateTime> getListOfDates([DateTime startTime, DateTime endTime]) {
    List<DateTime> dates = new List();
    for(var i = startDate; !endDate.isBefore(i); i = i.add(Duration(days: 1))){
      dates.add(i);
      //print(i);
    }
    return dates;
  }

  @override
  bool isUnderDuration(DateTime currentDate) {
    currentDate = new DateTime(currentDate.year,currentDate.month,currentDate.day);
    return !(startDate.isAfter(currentDate) || endDate.isBefore(currentDate));
  }
  @override
  String toString() {
    return "From " + startDate.toString() + " To " + endDate.toString();
  }
}
class WeeklyDuration extends EventDuration{
  List<bool> selectedWeekdays;
  WeeklyDuration(this.selectedWeekdays);
  @override
  bool isUnderDuration(DateTime currentDate){
    currentDate = new DateTime(currentDate.year,currentDate.month,currentDate.day);
    return selectedWeekdays[currentDate.weekday - 1];
  }

  @override
  List<DateTime> getListOfDates([DateTime startTime, DateTime endTime]) {
    // TODO: implement getListOfDates
    throw UnimplementedError();
  }
  @override
  String toString() {
    String returnString = "";
    for(var i = 0; i < selectedWeekdays.length; i++){
      if(selectedWeekdays[i]){
        if(returnString != ""){
          returnString += ",";
        }
        returnString += weekName[i + 1];
      }
    }
    return returnString == "" ? "Weekly(Unidentified)" : "Every " + returnString;
  }
}
/// An entry of a [SchoolDaySchedule], such as focus period or Period 1.
class ScheduleEntry implements Cloneable{
  /// When the current period starts. Must be before [endTime].
  TimeOfDay startTime;
  /// When the current period ends. Must be after [startTime].
  TimeOfDay endTime;
  /// The name of the schedule, such as "Focus".
  String title;
  /// The alternative name of the schedule. This title is used instead of [title] when
  /// [SchoolDaySchedule.alternativeCondition]
  String alternativeTitle;
  ScheduleEntry(this.startTime,this.endTime,this.title,[this.alternativeTitle]) {
    if(timeOfDayDifference(startTime, endTime) >= 0)
      throw ArgumentError("startTime must be earlier than endTime");
  }
  bool isUnderDuration(TimeOfDay now){
    return timeOfDayDifference(startTime, now) <= 0 && timeOfDayDifference(now, endTime) <= 0;
  }
  @override
  Object clone() {
    return ScheduleEntry(this.startTime, this.endTime, this.title, this.alternativeTitle);
  }
  @override
  String toString() {
    if(alternativeTitle != null)
      return "$title/$alternativeTitle: from $startTime to $endTime";
    else
      return "$title: from $startTime to $endTime";
  }
}
/// Condition checking logic based on a [DateTime].
typedef DateTimeCondition = bool Function(DateTime a);
/// A schedule of the a day of school.
class SchoolDaySchedule implements Cloneable{
  /// The default schedule of the current type of schedule.
  /// 
  /// This schedule should be valid, according to [checkValidSchedule].
  List<ScheduleEntry> schedule;
//  /// An alternative schedule of the current type, if [alternativeCondition] is true.
//  ///
//  /// This schedule should be valid, according to [checkValidSchedule].
//  ///
//  /// If null, then there is no alternative schedule. Only [schedule] will be used and [alternativeCondition] is useless.
//  List<ScheduleEntry> alternativeSchedule;
  /// If this is true, then [ScheduleEntry.alternativeTitle] should be used instead.
  ///
  /// If null, then [defaultAlternateCondition] is used.
  DateTimeCondition alternativeCondition;

  //static const int beforeSchool = -1;
  //static const int duringEmptyPeriod = -2;
  int get scheduleLength => schedule.length;

  /// The default [alternativeCondition] that is used.
  /// 
  /// Returns true when [a] is on an even day such as a Tuesday.
  static bool defaultAlternativeCondition(DateTime a){
    return a.weekday % 2 == 0;
  }
  /// Check if [schedule] is valid.
  ///
  /// A valid schedule is in order, i.e. [ScheduleEntry.startTime] of a later entry
  /// should be later than or equal to [ScheduleEntry.endTime] of the current entry.
  bool checkValidSchedule(List<ScheduleEntry> schedule){
    for(int i = 0; i < schedule.length - 1; i++){
      if(timeOfDayDifference(schedule[i].endTime,schedule[i + 1].startTime) > 0){
        return false;
      }
    }
    return true;
  }
  SchoolDaySchedule({
    @required this.schedule,
    //this.alternativeSchedule,
    this.alternativeCondition
  }) {
    if(!checkValidSchedule(schedule))
      throw ArgumentError("schedule must be valid(see documentation on checkValidSchedule)");
    //if((alternativeSchedule != null && !checkValidSchedule(alternativeSchedule)))
    //  throw ArgumentError("schedule must be valid(see documentation on checkValidSchedule)");
  }

  /// Get the index of the current period in the schedule based on [now].
  ///
  /// Precondition: [schedule] is valid.
  /// The validity of a schedule is specified under [checkValidSchedule].
  ///
  /// There are 3 possible types of return values:(n is the array size of [schedule])
  /// * Returns 0 ~ (n - 1) if [now] falls under a [ScheduleEntry];
  /// * Returns -n ~ -1 if [now] is before a [ScheduleEntry], but does not fall under any;
  ///   * ReturnVal + n is the index of the [ScheduleEntry] that [now] is immediately before.
  /// * Returns n if [now] is after all [ScheduleEntry];
  int getCurrentPeriod(TimeOfDay now){
    //var selectedSchedule = getSchedule(now);
    //assert(checkValidSchedule(selectedSchedule));
    //var currentTimeOfDay = TimeOfDay.fromDateTime(now);
    for(var i = 0; i < schedule.length; i++){
      // Check if the current time is before next period's start time. If true, then there is a break or school haven't started yet.
      if(timeOfDayDifference(now, schedule[i].startTime) < 0){
        return(i - schedule.length);
      }
      if(schedule[i].isUnderDuration(now))
        return i;
    }
    return scheduleLength;
  }
  /// Gets what text should be displayed based on [now] as the current time and [periodIndex] calculated
  /// in [getCurrentPeriod].
  /// 
  /// [now] is used to determine whether to use an alternative schedule title or not.
  /// 
  /// This function should only be used privately because the user can use [getCurrentPeriodText] instead
  String _getCurrentPeriodText(int periodIndex, DateTime now){

    var useAlternativeTitle = (alternativeCondition ?? defaultAlternativeCondition)(now);
    var currentTime = TimeOfDay.fromDateTime(now);
    if(periodIndex >= 0 && periodIndex < scheduleLength){
      return "${useAlternativeTitle && schedule[periodIndex].alternativeTitle != null ? schedule[periodIndex].alternativeTitle : schedule[periodIndex].title} "
          "${getString('calendar/schoolday/ends_in')} "
          "${timeOfDayDifference(schedule[periodIndex].endTime, currentTime)} "
          "${getString('calendar/schoolday/minutes')}";
    } else if(periodIndex >= -scheduleLength && periodIndex < 0){
      return "${useAlternativeTitle && schedule[periodIndex].alternativeTitle != null ? schedule[periodIndex + scheduleLength].alternativeTitle : schedule[periodIndex + scheduleLength].title} "
          "${getString('calendar/schoolday/starts_in')} "
          "${timeOfDayDifference(schedule[periodIndex + scheduleLength].startTime, currentTime)} "
          "${getString('calendar/schoolday/minutes')}";
    } else if(periodIndex == scheduleLength){
      return getString('calendar/schoolday/end_of_school');
    }
    throw ArgumentError("periodIndex must be between -scheduleLength and scheduleLength");
  }
  /// Display the current period text based on [now].
  /// 
  /// Example if this code is run on the default schedule:
  /// ```
  /// print(getCurrentPeriodText(DateTime.parse("2019-12-16 08:45:00")));
  /// // Output "Period 1 ends in 60 minute(s)"
  /// print(getCurrentPeriodText(DateTime.parse("2019-12-17 08:15:00")));
  /// // Output "Period 2 begins in 15 minute(s)" because schedule alternates on an even day.
  /// print(getCurrentPeriodText(DateTime.parse("2019-12-18 15:10:00")));
  /// // Output "School is over"
  /// ```
  String getCurrentPeriodText(DateTime now){
    return _getCurrentPeriodText(getCurrentPeriod(TimeOfDay.fromDateTime(now)), now);
  }
  /// Replaces all [ScheduleEntry] that has [ScheduleEntry.title] equal to [from]
  /// into [to].
  /// 
  /// Returns an new object as the return value so the original object is not modified.
  SchoolDaySchedule replaceScheduleName(String from, String to, [bool replaceAltName = false]){
    SchoolDaySchedule returnVal = this.clone();
    for(var i = 0; i < returnVal.schedule.length; i++){
      if(returnVal.schedule[i].title.compareTo(from) == 0){
        returnVal.schedule[i].title = to;
      }
      if(replaceAltName && returnVal.schedule[i].alternativeTitle.compareTo(from) == 0){
        returnVal.schedule[i].alternativeTitle = to;
      }
      //print(returnVal.schedule[i].title);
    }
    return returnVal;
  }

  @override
  Object clone() {
    var returnVal = SchoolDaySchedule(schedule: List<ScheduleEntry>(),alternativeCondition: alternativeCondition);
    for(var i in schedule){
      returnVal.schedule.add(i.clone());
    }
    return returnVal;
  }
  @override
  String toString() {
    return "Schedule:$schedule, alternative condition: ${alternativeCondition??defaultAlternativeCondition}";
  }
  Widget getScheduleTable(DateTime now){
    var tableRows = <TableRow>[];
    for(var i in schedule){
      var tempStartTime = DateTime(0,0,0,i.startTime.hour,i.startTime.minute);
      var tempEndTime = DateTime(0,0,0,i.endTime.hour,i.endTime.minute);
      tableRows.add(
        TableRow(
          children: [
            Container(
              child: Text(
                i.alternativeTitle != null && (alternativeCondition ?? defaultAlternativeCondition)(now) ?
                i.alternativeTitle :
                i.title,
              ),
              padding: EdgeInsets.all(10.0),
            ),
            Container(
              child: Text(
                DateFormat.Hm().format(tempStartTime) + " - "+ DateFormat.Hm().format(tempEndTime),
              ),
              padding: EdgeInsets.all(10.0),
            ),
          ]
        )
      );
    }
    return Container(
      child: Table(
        children: tableRows,
        border: TableBorder.all(),
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      ),
      //padding: EdgeInsets.all(10.0),
      margin: EdgeInsets.all(10.0),
    );
  }
}
/// A static class for a list of preset schedules.
class SchoolDaySchedules{
  /// The default schedule of the school from Monday to Thursday.
  static SchoolDaySchedule defaultSchedule = SchoolDaySchedule(
    schedule: <ScheduleEntry>[
      ScheduleEntry(
        TimeOfDay(hour: 8, minute: 30),
        TimeOfDay(hour: 9, minute: 45),
        getString('calendar/schoolday/period') + " 1",
        getString('calendar/schoolday/period') + " 2",
      ),
      ScheduleEntry(
        TimeOfDay(hour: 9, minute: 45),
        TimeOfDay(hour: 10, minute: 35),
        getString('calendar/schoolday/focus'),
      ),
      ScheduleEntry(
        TimeOfDay(hour: 10, minute: 35),
        TimeOfDay(hour: 11, minute: 50),
        getString('calendar/schoolday/period') + " 2",
        getString('calendar/schoolday/period') + " 1",
      ),
      ScheduleEntry(
        TimeOfDay(hour: 11, minute: 50),
        TimeOfDay(hour: 12, minute: 30),
        getString('calendar/schoolday/lunch'),
      ),
      ScheduleEntry(
        TimeOfDay(hour: 12, minute: 30),
        TimeOfDay(hour: 13, minute: 45),
        getString('calendar/schoolday/period') + " 3",
        getString('calendar/schoolday/period') + " 4",
      ),
      ScheduleEntry(
        TimeOfDay(hour: 13, minute: 45),
        TimeOfDay(hour: 15, minute: 0),
        getString('calendar/schoolday/period') + " 4",
        getString('calendar/schoolday/period') + " 3",
      ),
    ],
  );
  /// The default schedules for school on Friday. Shorter classes with connect.
  static SchoolDaySchedule fridaySchedule = SchoolDaySchedule(
    schedule: <ScheduleEntry>[
      ScheduleEntry(
        TimeOfDay(hour: 8, minute: 30),
        TimeOfDay(hour: 9, minute: 30),
        getString('calendar/schoolday/period') + " 1",
        getString('calendar/schoolday/period') + " 2",
      ),
      ScheduleEntry(
        TimeOfDay(hour: 9, minute: 30),
        TimeOfDay(hour: 10, minute: 15),
        getString('calendar/schoolday/focus'),
      ),
      ScheduleEntry(
        TimeOfDay(hour: 10, minute: 15),
        TimeOfDay(hour: 11, minute: 15),
        getString('calendar/schoolday/period') + " 2",
        getString('calendar/schoolday/period') + " 1",
      ),
      ScheduleEntry(
        TimeOfDay(hour: 11, minute: 15),
        TimeOfDay(hour: 11, minute: 35),
        getString('calendar/schoolday/nutrition_break'),
      ),
      ScheduleEntry(
        TimeOfDay(hour: 11, minute: 35),
        TimeOfDay(hour: 12, minute: 35),
        getString('calendar/schoolday/period') + " 3",
        getString('calendar/schoolday/period') + " 4",
      ),
      ScheduleEntry(
        TimeOfDay(hour: 12, minute: 35),
        TimeOfDay(hour: 13, minute: 35),
        getString('calendar/schoolday/period') + " 4",
        getString('calendar/schoolday/period') + " 3",
      ),
    ],
  );
  static SchoolDaySchedule pepRallySchedule = SchoolDaySchedule(
    schedule: <ScheduleEntry>[
      ScheduleEntry(
        TimeOfDay(hour: 8, minute: 30),
        TimeOfDay(hour: 9, minute: 30),
        getString('calendar/schoolday/period') + " 1",
        getString('calendar/schoolday/period') + " 2",
      ),
      ScheduleEntry(
        TimeOfDay(hour: 9, minute: 30),
        TimeOfDay(hour: 10, minute: 15),
        getString('calendar/schoolday/connect'),
      ),
      ScheduleEntry(
        TimeOfDay(hour: 10, minute: 15),
        TimeOfDay(hour: 11, minute: 15),
        getString('calendar/schoolday/period') + " 2",
        getString('calendar/schoolday/period') + " 1",
      ),
      ScheduleEntry(
        TimeOfDay(hour: 11, minute: 15),
        TimeOfDay(hour: 11, minute: 45),
        getString('calendar/schoolday/nutrition_break'),
      ),
      ScheduleEntry(
        TimeOfDay(hour: 11, minute: 45),
        TimeOfDay(hour: 12, minute: 45),
        getString('calendar/schoolday/period') + " 3",
        getString('calendar/schoolday/period') + " 4",
      ),
      ScheduleEntry(
        TimeOfDay(hour: 12, minute: 45),
        TimeOfDay(hour: 13, minute: 45),
        getString('calendar/schoolday/period') + " 4",
        getString('calendar/schoolday/period') + " 3",
      ),
      ScheduleEntry(
        TimeOfDay(hour: 13, minute: 45),
        TimeOfDay(hour: 15, minute: 0),
        getString('calendar/special/pep_rally'),
      )
    ],
  );
}

/// The information for school day for a period of time, such as whether it is a regular day, non-instructional, or a national holiday
///
/// Used in [SchoolCalendar] as a list of events in the school.
class SchoolDayInformation{
  SchoolDayType schoolDayType;
  /// Name of this class such as "Victoria Day" or "Christmas Break"
  String title;
  /// The greeting that should be displayed for this event
  String greeting;
  /// The duration for this event.
  EventDuration duration;
  /// Is the this event ignored when displaying in a calendar
  bool ignoreInCalendar;
  /// If specified, override the default schedule.
  SchoolDaySchedule overrideSchedule;
  /// An optional tag for this object.
  /// 
  /// Currently the tags that are used are:
  /// * [replaceFocusWithConnect] 
  Set<String> tags;
  /// A tag allowed in [tags]. Change the name of all focus periods with "Connect" in today's schedule.
  static const String replaceFocusWithConnect = "replaceFocusWithConnect";

  SchoolDayInformation({
    @required this.schoolDayType,
    @required this.title,
    this.greeting,
    @required this.duration,
    this.ignoreInCalendar = false,
    this.overrideSchedule,
    this.tags,
  });

  /// Check if [currentDate] is under this duration.
  bool isUnderDuration(DateTime currentDate){
    return duration.isUnderDuration(currentDate);
  }
  @override
  String toString() {
    return title + " (" + duration.toString() + ")";
  }
}

///A calendar for a typical school year
class SchoolCalendar{
  /// The list of events for a school year
  List<SchoolDayInformation> eventLists;
//  /// A map that maps the event ID found on [TableCalendar] and the referenced [SchoolDayInformation]
//  Map<String,SchoolDayInformation> _identifierEventMap;
//  /// A private variable that tracks what id should be assigned to [_identifierEventMap]
//  int _identifierCount = 0;
//
//  /// Get the private variable [_identifierEventMap]
//  Map get getIdentifierMap => _identifierEventMap;

  SchoolCalendar({this.eventLists}){
    //_identifierEventMap = new Map<String,SchoolDayInformation>();
  }
  /// Get what [SchoolDayInformation] does [currentDate] have.
  /// Select from the first-most event that falls under the duration.
  SchoolDayInformation getInfo(DateTime currentDate){
    for(var oneEvent in eventLists){
      if(oneEvent.isUnderDuration(currentDate))
        return oneEvent;
    }
    return null;
  }
  /// Get [currentDate]'s [SchoolDaySchedule].
  ///
  /// The first object of [eventLists] that [currentDate] falls under and [SchoolDayInformation.overrideSchedule] is non-null
  /// is selected and returns [SchoolDayInformation.overrideSchedule] that is associated with that object.
  ///
  /// If no object falls under the above category, [SchoolDaySchedules.defaultSchedule] is selected instead.
  SchoolDaySchedule getSchedule(DateTime currentDate){
    var tags = getInfo(currentDate).tags;
    // This part of the code process the tags and see if the schedule should be modified accordingly.
    SchoolDaySchedule processSchedule(SchoolDaySchedule initial){
      var returnVal = initial;
      if(tags != null){
        if(tags.contains(SchoolDayInformation.replaceFocusWithConnect)){
          returnVal = initial.replaceScheduleName(
            getString('calendar/schoolday/focus'),
            getString('calendar/schoolday/connect')
          );
        }
      }
      //print(returnVal);
      return returnVal;
    }
    for(var oneEvent in eventLists){
      if(oneEvent.isUnderDuration(currentDate) && oneEvent.overrideSchedule != null)
      {
        return processSchedule(oneEvent.overrideSchedule);
      }
      
    }
    return processSchedule(SchoolDaySchedules.defaultSchedule);
  }
  ///Get the holiday calendar used in [TableCalendar]. Note that the event id, rather than the actual event reference is passed. Might change later
  Map<DateTime,List> getHolidayCalendar([DateTime startDay, DateTime endDay]){
    Map<DateTime,List> returnVal = new Map<DateTime,List>();
    for(var oneEvent in eventLists){
      if(!oneEvent.ignoreInCalendar){
        for(var i in oneEvent.duration.getListOfDates(startDay, endDay)){
          if(!returnVal.containsKey(i)){
            returnVal[i] = [oneEvent];
          }
        }
      }
    }
    return returnVal;
  }

}
///The default calendar for the school. Is currently hard-coded but in the future we might do it server based.
SchoolCalendar schoolCalendar = new SchoolCalendar(
    eventLists: [
      /*
      * Hard-coded events. Too lazy to add events already passed.
      * */
      SchoolDayInformation(
          schoolDayType: SchoolDayType.noSchool,
          title: getString('calendar/holiday/labour_day'),
          greeting: getString('calendar/holiday/labour_day/greeting'),
          duration: SingleDayDuration(DateTime(2019,9,2)),
      ),
      SchoolDayInformation(
          schoolDayType: SchoolDayType.schoolDay,
          title: getString('calendar/resume_class'),
          greeting: getString('calendar/resume_class/greeting'),
          duration: SingleDayDuration(DateTime(2020,9,3)),
      ),
      SchoolDayInformation(
          schoolDayType: SchoolDayType.nonInstructional,
          title: getString('calendar/noninstructional'),
          greeting: getString('calendar/noninstructional/greeting'),
          duration: SingleDayDuration(DateTime(2019,9,20)),
      ),
      SchoolDayInformation(
          schoolDayType: SchoolDayType.nonInstructional,
          title: getString('calendar/noninstructional'),
          greeting: getString('calendar/noninstructional/greeting'),
          duration: SingleDayDuration(DateTime(2019,10,11)),
      ),
      SchoolDayInformation(
          schoolDayType: SchoolDayType.noSchool,
          title: getString('calendar/holiday/thanksgiving'),
          greeting: getString('calendar/holiday/thanksgiving/greeting'),
          duration: FromToDuration(DateTime(2019,10,12),DateTime(2019,10,14)),
      ),
      SchoolDayInformation(
          schoolDayType: SchoolDayType.nonInstructional,
          title: getString('calendar/noninstructional'),
          greeting: getString('calendar/noninstructional/greeting'),
          duration: SingleDayDuration(DateTime(2019,11,1)),
      ),
      SchoolDayInformation(
          schoolDayType: SchoolDayType.noSchool,
          title: getString('calendar/holiday/rememberance'),
          greeting: getString('calendar/holiday/rememberance/greeting'),
          duration: FromToDuration(DateTime(2019,11,9),DateTime(2019,11,11)),
      ),
      SchoolDayInformation(
          schoolDayType: SchoolDayType.nonInstructional,
          title: getString('calendar/noninstructional'),
          greeting: getString('calendar/noninstructional/greeting'),
          duration: SingleDayDuration(DateTime(2019,11,22)),
      ),
      SchoolDayInformation(
          schoolDayType: SchoolDayType.schoolDay,
          title: getString('calendar/last_day'),
          greeting: getString('calendar/last_day/christmas_greeting'),
          duration: SingleDayDuration(DateTime(2019,12,19)),
          // The last day of school has a pep rally in the end. the schedule overrides the normal schedule
          overrideSchedule: SchoolDaySchedules.pepRallySchedule,
          // There is also connect instead of focus
          tags: Set.from([SchoolDayInformation.replaceFocusWithConnect]),
      ),
      SchoolDayInformation(
          schoolDayType: SchoolDayType.nonInstructional,
          title: getString('calendar/noninstructional'),
          greeting: getString('calendar/noninstructional/greeting'),
          duration: SingleDayDuration(DateTime(2019,12,20)),
      ),
      SchoolDayInformation(
          schoolDayType: SchoolDayType.noSchool,
          title: getString('calendar/break/christmas'),
          greeting: getString('calendar/break/christmas/greeting'),
          duration: FromToDuration(DateTime(2019,12,21),DateTime(2020,1,5)),
      ),
      SchoolDayInformation(
          schoolDayType: SchoolDayType.schoolDay,
          title: getString('calendar/resume_class'),
          greeting: getString('calendar/resume_class/greeting'),
          duration: SingleDayDuration(DateTime(2020,1,6)),
      ),
      SchoolDayInformation(
        schoolDayType: SchoolDayType.nonInstructional,
        title: getString('calendar/break/exam_break'),
        greeting: getString('calendar/break/exam_break/greeting'),
        duration: FromToDuration(DateTime(2020,1,13),DateTime(2020,1,30)),
      ),
      SchoolDayInformation(
          schoolDayType: SchoolDayType.nonInstructional,
          title: getString('calendar/noninstructional'),
          greeting: getString('calendar/noninstructional/greeting'),
          duration: SingleDayDuration(DateTime(2020,1,31)),
      ),
      SchoolDayInformation(
          schoolDayType: SchoolDayType.schoolDay,
          title: getString('calendar/resume_class'),
          greeting: getString('calendar/resume_class/greeting'),
          duration: SingleDayDuration(DateTime(2020,2,3)),
      ),
      SchoolDayInformation(
          schoolDayType: SchoolDayType.noSchool,
          title: getString('calendar/holiday/teachers_convention'),
          greeting: getString('calendar/holiday/teachers_convention/greeting'),
          duration: FromToDuration(DateTime(2020,2,13),DateTime(2020,2,14)),
      ),
      SchoolDayInformation(
          schoolDayType: SchoolDayType.noSchool,
          title: getString('calendar/holiday/family_day'),
          greeting: getString('calendar/holiday/family_day/greeting'),
          duration: FromToDuration(DateTime(2020,2,15),DateTime(2020,2,17)),
      ),
      SchoolDayInformation(
          schoolDayType: SchoolDayType.schoolDay,
          title: getString('calendar/last_day'),
          greeting: getString('calendar/last_day/spring_greeting'),
          duration: SingleDayDuration(DateTime(2020,3,19)),
      ),
      SchoolDayInformation(
          schoolDayType: SchoolDayType.nonInstructional,
          title: getString('calendar/noninstructional'),
          greeting: getString('calendar/noninstructional/greeting'),
          duration: SingleDayDuration(DateTime(2020,3,20)),
      ),
      SchoolDayInformation(
          schoolDayType: SchoolDayType.noSchool,
          title: getString('calendar/break/spring_break'),
          greeting: getString('calendar/break/spring_break/greeting'),
          duration: FromToDuration(DateTime(2020,3,21),DateTime(2020,3,29)),
      ),
      SchoolDayInformation(
          schoolDayType: SchoolDayType.schoolDay,
          title: getString('calendar/resume_class'),
          greeting: getString('calendar/resume_class/greeting'),
          duration: SingleDayDuration(DateTime(2020,3,30)),
      ),
//      SchoolDayInformation(
//          schoolDayType: SchoolDayType.schoolDay,
//          title: getString('calendar/wtf_weekend'),
//          greeting: getString('calendar/wtf_weekend/greeting'),
//          duration: SingleDayDuration(DateTime(2020,4,4))
//      ),
      SchoolDayInformation(
          schoolDayType: SchoolDayType.noSchool,
          title: getString('calendar/holiday/good_friday'),
          greeting: getString('calendar/holiday/good_friday/greeting'),
          duration: FromToDuration(DateTime(2020,4,10),DateTime(2020,4,12)),
      ),
      SchoolDayInformation(
          schoolDayType: SchoolDayType.nonInstructional,
          title: getString('calendar/noninstructional'),
          greeting: getString('calendar/noninstructional/greeting'),
          duration: SingleDayDuration(DateTime(2020,4,13)),
      ),
      SchoolDayInformation(
          schoolDayType: SchoolDayType.nonInstructional,
          title: getString('calendar/noninstructional'),
          greeting: getString('calendar/noninstructional/greeting'),
          duration: SingleDayDuration(DateTime(2020,5,15)),
      ),
      SchoolDayInformation(
          schoolDayType: SchoolDayType.noSchool,
          title: getString('calendar/holiday/victoria_day'),
          greeting: getString('calendar/holiday/victoria_day/greeting'),
          duration: FromToDuration(DateTime(2020,5,16),DateTime(2020,5,18)),
      ),
      SchoolDayInformation(
          schoolDayType: SchoolDayType.schoolDay,
          title: getString('calendar/last_day'),
          greeting: getString('calendar/last_day/summer_greeting'),
          duration: SingleDayDuration(DateTime(2020,6,29)),
      ),
      SchoolDayInformation(
          schoolDayType: SchoolDayType.nonInstructional,
          title: getString('calendar/noninstructional'),
          greeting: getString('calendar/noninstructional/greeting'),
          duration: SingleDayDuration(DateTime(2020,6,30)),
      ),
      SchoolDayInformation(
          schoolDayType: SchoolDayType.noSchool,
          title: getString('calendar/break/summer_break'),
          greeting: getString('calendar/break/summer_break/greeting'),
          //TODO:Update the end date for summer break as soon as next year's calendar is released.
          duration: FromToDuration(DateTime(2020,7,1),DateTime(2020,8,31)),
      ),

      /*
      * Happens regularly. Just the weekdays and the weekends.
      * */
      SchoolDayInformation(
        schoolDayType: SchoolDayType.noSchool,
        title: "Weekend",
        greeting: "Enjoy the weekend!",
        duration: WeeklyDuration([false,false,false,false,false,true,true]),
        ignoreInCalendar: true,
      ),
      // Friday schedules
      SchoolDayInformation(
        schoolDayType: SchoolDayType.schoolDay,
        title: "Friday!",
        duration: WeeklyDuration([false,false,false,false,true,false,false]),
        ignoreInCalendar: true,
        overrideSchedule: SchoolDaySchedules.fridaySchedule,
        tags: Set.from([SchoolDayInformation.replaceFocusWithConnect]),
      ),
      // Non-Friday schedules
      SchoolDayInformation(
        schoolDayType: SchoolDayType.schoolDay,
        title: "Regular Class",
        duration: WeeklyDuration([true,true,true,true,false,false,false]),
        ignoreInCalendar: true,
        overrideSchedule: SchoolDaySchedules.defaultSchedule,
      ),
    ]
);
///A widget that displays information such as the date of today or which period it is now
class DateDisplay extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _DateDisplayState();
}
class _DateDisplayState extends State<DateDisplay>{

  @override
  Widget build(BuildContext context) {
    var currentDate = DateTime.now();//parse("2019-12-19 09:45:00");//.now();
    var todaysInfo = schoolCalendar.getInfo(currentDate);
    var currentPeriod = "No Class";
//    int timeOfDayToInt(int hour,int minute) => hour * 60 + minute;
//    int datetimeToInt(DateTime time) => timeOfDayToInt(time.hour, time.minute);
    if(todaysInfo.schoolDayType == SchoolDayType.schoolDay){
      var todaysSchedule = schoolCalendar.getSchedule(currentDate);
      currentPeriod = todaysSchedule.getCurrentPeriodText(currentDate);
    }
    var schoolText = todaysInfo.greeting != null ? Text(todaysInfo.greeting) : null;
    return Column(
      children: <Widget>[
        Text(
          new DateFormat("| EEEE | MMM d | yyyy |").format(currentDate,),
          style: appTextTheme(context).subtitle2,
          textAlign: TextAlign.center,
        ),
        //TODO: Make the button cooler
        RawMaterialButton(
          child: Icon(Icons.assignment,color: Colors.white,),
          shape: CircleBorder(),
          highlightColor: Color(0x0083ff),
          padding: EdgeInsets.all(5),
          fillColor: Colors.black12,
          splashColor: Colors.white,

          onPressed: () {
            goToPage(context, DetailedCalendar());
          },
        ),
        Text(todaysInfo.title),
        schoolText,
        Text(currentPeriod),
      ]
      //Remove the null values from the list in this column for safety
        ..removeWhere((widget) => widget == null),
    );
  }
}
/// Displays a detailed calendar which contains more information on the upcoming holidays, events, etc.
class DetailedCalendar extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _DetailedCalendar();
}

class _DetailedCalendar extends State<DetailedCalendar>{

  //DateTime _currentDate;
  CalendarController _calendarController;
  Map<DateTime,List> _holidays;
  Widget _holidayWidget;
  Widget _scheduleWidget;
  //Map<String, SchoolDayInformation> _eventIdentifier;

  @override
  void initState() {
    super.initState();
    //_currentDate = DateTime.now();
    _calendarController = new CalendarController();
    _holidays = schoolCalendar.getHolidayCalendar();
    _holidayWidget = Container();
    _scheduleWidget = Container();
    //_eventIdentifier = schoolCalendar.getIdentifierMap;
    //print(_holidays);
  }

  @override
  void dispose() {
    //_animationController.dispose();
    _calendarController.dispose();
    super.dispose();
  }
  void _onDaySelected(DateTime date, List events){
    setState(() {
      //print('Selected ' + date.toString() + ': ');
      //print(events);
      //print(schoolCalendar.getInfo(date));
      if(schoolCalendar.getInfo(date).schoolDayType == SchoolDayType.schoolDay){
        var schedule = schoolCalendar.getSchedule(date);
        _scheduleWidget = schedule.getScheduleTable(date);
      } else {
        _scheduleWidget = Container();
      }
      if(events.length > 0){
        for(var i in events){
          if(i is SchoolDayInformation){
            _holidayWidget = Container(
              width: double.infinity,
              //height: 20.0,
              decoration: BoxDecoration(
                  color: Colors.grey[700],
                  border: Border.all(width: 2.0, color: Colors.grey[850]),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(Radius.circular(10.0))
              ),
              padding: EdgeInsets.all(4.0),
              margin: EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                i.title,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20.0),
              ),
            );
            return;
          }
        }
      }
      _holidayWidget = Container();
    });
  }

  List<Widget> _getEventMarker(BuildContext context, DateTime date, List events, List holidays){
    Widget schoolDayMarker;
    //Widget otherEventMarker;
    for(var i in events){
      if(i is SchoolDayInformation){
        Color dotColor;
        switch(i.schoolDayType){
          case SchoolDayType.nonInstructional:
            dotColor = Colors.lightBlueAccent;
            break;
          case SchoolDayType.noSchool:
            dotColor = Colors.red[300];
            break;
          case SchoolDayType.schoolDay:
            dotColor = Colors.grey;
            break;
          default:

        }
        if(dotColor != null) {
          schoolDayMarker = Container(
            width: 8.0,
            height: 8.0,
            margin: const EdgeInsets.symmetric(horizontal: 0.3),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: dotColor,
            ),
          );
        }

      } else {
//        otherEventMarker = Container(
//          width: 8.0,
//          height: 8.0,
//          margin: const EdgeInsets.symmetric(horizontal: 0.3),
//          decoration: BoxDecoration(
//            shape: BoxShape.circle,
//            color: Colors.blueAccent[100],
//          ),
//          child: Icon(
//            Icons.add,
//          ),
//        );
      }
    }
    //print(schoolDayMarker);
    return [schoolDayMarker];
//    return [schoolDayMarker, otherEventMarker]
//      ..removeWhere((obj) => obj = null);
  }

  @override
  Widget build(BuildContext context) {
    return new Material(
      color: Theme.of(context).backgroundColor,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            new Container(
              height: 30.0,

            ),

            PreviousPageButton(),

            new Container(
              height: 20.0,

            ),

            TableCalendar(
              calendarController: _calendarController,
              events: _holidays,
              onDaySelected: _onDaySelected,
              builders: CalendarBuilders(
                  markersBuilder: _getEventMarker
              ),
              startDay: DateTime(2019,9,1),
              endDay: DateTime(2020,8,31),
              headerStyle: HeaderStyle(
                formatButtonVisible: false,
              ),
            ),

            Container(height: 20.0),

            _holidayWidget,

            _scheduleWidget,

          ],
        ),
      )
    );
  }
}