import 'package:flutter/material.dart';

class InvalidDateList implements Exception{
  final String message="Invalid date list";
  InvalidDateList();
  @override
  String toString() {
    return "InvalidDateList: $message";
    
  }
}
String listOfDatesToString(List<DateTime> datesList){
  return datesList.map<String>((date)=>'${date.year}:${date.month}:${date.day}').join('#');
}
Iterable<DateTime> stringToListOfDates(String list){
  if (list.isEmpty) return [];
  
  var datesString = list.split('#');
  return datesString.map<DateTime>((dateStr){
    var dateSplit=dateStr.split(':');
    var year=dateSplit[0];
    var month=dateSplit[1];
    var day=dateSplit[2];
    return DateTime(int.parse(year),int.parse(month),int.parse(day)); 

  });
}

String datetimeToString(DateTime? date){
  if (date==null) return "-1";
  var year=date.year;
  var month=date.month.toString().padLeft(2,'0');
  var day=date.day.toString().padLeft(2,'0');
  var hour=date.hour.toString().padLeft(2,'0');
  var min=date.minute.toString().padLeft(2,'0');
  var second=date.second.toString().padLeft(2,'0');
  var milliseconds = date.millisecond.toString().padRight(3,'0');
  var microsecond=date.microsecond.toString().padRight(3,'0');
  return '$year-$month-$day $hour:$min:$second.$milliseconds$microsecond';
}
DateTime? stringToDateTime(String? value){
  if (value==null){
    return null;
  }
  if (value=='-1'){
    return null;
  } 
  return DateTime.parse(value);
}

String timeOfDayToString(TimeOfDay? time){
  if (time==null) return "-1";
  var hour = time.hour.toString().padLeft(2,'0');
  var min = time.minute.toString().padLeft(2,'0');
  return '$hour:$min';

} 
TimeOfDay? stringToTimeOfDay(String? value){
  if (value==null){
    return null;
  }
  if (value=='-1'){
    return null;
  }
  var hourAndMin =value.split(':');
  var hour = int.parse(hourAndMin[0]);
  var min = int.parse(hourAndMin[1]);
  return TimeOfDay(hour: hour, minute: min);
}
List<int> daysOfMonth = [31,28,31,30,31,30,31,31,30,31,30,31];
int dateNum(DateTime x){
  return x.year*366+(x.month)*31+x.day;
}
bool listHasDate(List<DateTime> list, DateTime date){
  var low=0;
  var high=list.length-1;
  if (high==0){
    return (dateNum(list[0])==dateNum(date));
  } 
  int index=0;
  while(low<=high){
    index = (high+low)~/2;
    
    if (dateNum(list[index])==dateNum(date)){
      return true;
    } else if(dateNum(list[index])<dateNum(date)){
      low = index +1; 
    } else {
      high=index-1;
    }

  }
  return false;
}
void removeDateToList(List<DateTime> list, DateTime date){
  var low=0;
  var high=list.length-1;
  int index=0;
  if(high==0){
    if (dateNum(list[0])==dateNum(date)){
      list.remove(list[0]);
      return;
    }else{
      throw InvalidDateList();
    }
    
  }
  while(low<=high){
    index = (high+low)~/2;
    if (dateNum(list[index])==dateNum(date)){
      list.remove(list[index]);
      return;
    } else if(dateNum(list[index])<dateNum(date)){
      low=index+1;
    } else {
      high=index-1;
    }
  }
  throw InvalidDateList();
}
void addDateToList(List<DateTime> list, DateTime date){
  if (list.isEmpty){
    list.add(date);
    return;
  }
  if (dateNum(date)>dateNum(list[list.length-1])){
    list.add(date);
    return;
  }  
  if (dateNum(date)<dateNum(list[0])){
    list.insert(0, date);
    return;    
  } 
  int high= list.length-1;
  int low = 0;
  int index=0;
  var keepGoing=true;
  while (keepGoing){
    
    index=(high+low)~/2;
    if (dateNum(list[index])==dateNum(date)){
      
      
      throw InvalidDateList();
    }
    if (dateNum(list[index])<dateNum(date)){
      if (dateNum(list[index+1])>dateNum(date)){
        keepGoing=false;
        index+=1;
      } else{
        low=index+1;
      }
    } else {
      if (dateNum(list[index-1])<dateNum(date)){
        keepGoing=false;
      } else{
        high=index-1;
      }
    }
  }

  list.insert(index, date);
}

int daysSince1Jan(int month){
  
  int result = 0;
  for(int i=0;i<(month-1);i++){
    result+=daysOfMonth[i];
  }
  return result;

}

int daysBeforeYear(int year){
  var y = year - 1;
  return y*365 + y~/4 - y~/100 + y~/400;

}

int datetimeToInt(DateTime date){
  //Considering 01-Jan-0001 as day 1.
  var p1 = daysBeforeYear(date.year);
  var p2 = daysSince1Jan(date.month);
  var p3 = date.day;
  int result = p1+p2+p3;
  if (date.month>2 && isLeapYear(date.year)){
    
    result+=1;
  }
  
  return result;
}
DateTime intToDateTime(int n){
  //Considering 01-Jan-0001 as day 1.
  int year = 0;
  var _400years = daysBeforeYear(401);
  var part1 = n~/_400years;
  
  year+= 400 * part1;
  n -= daysBeforeYear(401) * part1;
 
  var _100years = daysBeforeYear(101);
  var part2= n ~/_100years;
  year += 100 * part2;
  n -= daysBeforeYear(101) *part2;
  
  var _4years = daysBeforeYear(5);
  var part3 = n~/_4years;
  year+= 4 * part3;
  n -= daysBeforeYear(5) * part3;
  
  var _1year = daysBeforeYear(2);
  var part4 = n~/_1year;
  year += 1 * part4;
  n -= daysBeforeYear(2) * part4;
 
  if (n==0){
    return DateTime(year,12,31);
  }
  
  year+=1;
  int month=0;
  int day = 1;
  
  while(n>0){
    var days = daysOfMonth[month];
    if (month==1 && isLeapYear(year)){
      days+=1;
    }
    if (n>days){
      n-=days; //so the while continue
    } else if(n==days){
      n-=days;
      day= days;
    } else{
      day=n;
      n=0;
      
    }
    month++;
    
  }
  return DateTime(year,month,day);
}

bool isLeapYear(int year) {
  if (year % 4 != 0) {
    return false;
  } else {
    if (year % 100 != 0) {
      return true;
    } else {
      if (year % 400 == 0) {
        return true;
      } else {
        return false;
      }
    }
  }
}
DateTime addDays(DateTime date, int addValue){
  var n = datetimeToInt(date);
  return intToDateTime(n+addValue);
}

