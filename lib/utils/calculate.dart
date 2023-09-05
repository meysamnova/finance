import 'package:hive_flutter/adapters.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import '../models/money.dart';

String year = Jalali.now().year.toString();
String month = Jalali.now().month.toString().length == 1
    ? '0${Jalali.now().month.toString()}'
    : Jalali.now().month.toString();
String day = Jalali.now().day.toString().length == 1
    ? '0${Jalali.now().day.toString()}'
    : Jalali.now().day.toString();
Box<Money> hiveBox = Hive.box<Money>('moneyBox');

class Calculate {
  static String toDay() {
    return '$year/$month/$day';
  }

//! DAY PAYMENT
  static double pToday() {
    double result = 0;
    for (var element in hiveBox.values) {
      if (element.date == toDay() && element.isRecived == false) {
        result += double.parse(element.price);
      }
    }
    return result;
  }

  //! DAY RESIVED
  static double dToday() {
    double result = 0;
    for (var element in hiveBox.values) {
      if (element.date == toDay() && element.isRecived == true) {
        result += double.parse(element.price);
      }
    }
    return result;
  }

  //! MONTH PAYMENT
  static double pMonth() {
    double result = 0;
    for (var element in hiveBox.values) {
      if (element.date.substring(5, 7) == month && element.isRecived == false) {
        result += double.parse(element.price);
      }
    }
    return result;
  }

  //! MONTH RESIVED
  static double dMonth() {
    double result = 0;
    for (var element in hiveBox.values) {
      if (element.date.substring(5, 7) == month && element.isRecived == true) {
        result += double.parse(element.price);
      }
    }
    return result;
  }

  //! YEAR PAYMENT
  static double pYear() {
    double result = 0;
    for (var element in hiveBox.values) {
      if (element.date.substring(0, 4) == year && element.isRecived == false) {
        result += double.parse(element.price);
      }
    }
    return result;
  }

  //! YEAR RESIVED
  static double dYear() {
    double result = 0;
    for (var element in hiveBox.values) {
      if (element.date.substring(0, 4) == year && element.isRecived == true) {
        result += double.parse(element.price);
      }
    }
    return result;
  }
}
