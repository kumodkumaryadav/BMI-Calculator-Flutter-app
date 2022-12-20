
import 'dart:math';

import 'package:flutter/material.dart';

class BmiUtil {
  static int age = 20;
  static bool isCmUnit = false;
  static int  height=170;
  static double weight = 50;
  static bool isKg = true;
  static int feet = 4;
  static int inch = 10;

  static double _bmi = 0;


  static int feetInchToCM(int feet, int inch) {
    int totalInch = ((feet * 12) + inch);
    return (totalInch * 2.54).round();
  }

  static String calculateBMI() {
    if (isKg) {
      _bmi = weight / pow(height / 100, 2);
    } else {
      _bmi = (weight * 0.45359237) / pow(height / 100, 2);
    }
    return _bmi.toStringAsFixed(1);
  }

  static String getResult() {
    if (_bmi <= 16) {
      return 'VERY SEVERELY UNDERWEIGHT';
    } else if (_bmi > 16.0 && _bmi <= 16.9) {
      return 'SEVERELY UNDERWEIGHT';
    } else if (_bmi > 17.0 && _bmi <= 18.4) {
      return 'UNDERWEIGHT';
    } else if (_bmi > 18.5 && _bmi <= 24.9) {
      return 'NORMAL';
    } else if (_bmi > 25.0 && _bmi <= 29.9) {
      return 'OVERWEIGHT';
    } else if (_bmi > 30.0 && _bmi <= 34.9) {
      return 'OBESE Class 1 \n(Moderately obese)';
    } else if (_bmi > 35.0 && _bmi <= 39.9) {
      return 'OBESE Class 2 \n(Severely obese)';
    } else if (_bmi >= 40.0) {
      return 'OBESE Class 3 \n(Very Severely obese)';
    } else {
      return 'NORMAL';
    }
  }

  static TextStyle resultTextStyle(String result) {
    switch (result) {
      case "VERY SEVERELY UNDERWEIGHT":
        return const TextStyle(
          color: Color.fromRGBO(241, 198, 231, 1),
          fontWeight: FontWeight.w700,
          letterSpacing: 2.0,
          fontSize: 22.0,
        );
      case "SEVERELY UNDERWEIGHT":
        return const TextStyle(
          color: Color.fromRGBO(229, 176, 234, 1),
          fontWeight: FontWeight.w700,
          letterSpacing: 2.0,
          fontSize: 22.0,
        );
      case "UNDERWEIGHT":
        return const TextStyle(
          color: Color.fromRGBO(189, 131, 206, 1),
          fontWeight: FontWeight.w700,
          letterSpacing: 2.0,
          fontSize: 22.0,
        );
      case "NORMAL":
        return const TextStyle(
          color: Color.fromRGBO(82, 222, 151, 1),
          fontWeight: FontWeight.w700,
          letterSpacing: 2.0,
          fontSize: 22.0,
        );
      case "OVERWEIGHT":
        return const TextStyle(
          color: Color.fromRGBO(241, 188, 49, 1),
          fontWeight: FontWeight.w700,
          letterSpacing: 2.0,
          fontSize: 22.0,
        );
      case "OBESE Class 1 \n(Moderately obese)":
        return const TextStyle(
          color: Color.fromRGBO(226, 88, 34, 1),
          fontWeight: FontWeight.w700,

          // letterSpacing: 2.0,
          fontSize: 22.0,
        );
      case "OBESE Class 2 \n(Severely obese)":
        return const TextStyle(
          color: Color.fromRGBO(178, 34, 34, 1),
          fontWeight: FontWeight.w700,
          // letterSpacing: 2.0,
          fontSize: 22.0,
        );
      case "OBESE Class 3 \n(Very Severely obese)":
        return const TextStyle(
          color: Color.fromRGBO(124, 10, 2, 1),
          fontWeight: FontWeight.w700,
          // letterSpacing: 2.0,
          fontSize: 22.0,
        );
      default:
        return const TextStyle(
          color: Color.fromRGBO(0, 251, 182, 1),
          fontWeight: FontWeight.w700,
          letterSpacing: 2.0,
          fontSize: 22.0,
        );
    }
  }

  static String getInterpretation() {
    if (_bmi >= 25) {
      return 'You have a higher than normal body weight. Try to exercise more!';
    } else if (_bmi > 18.5) {
      return 'You have a normal body weight. Good job!';
    } else {
      return 'You have a lower than normal body weight. You should eat more!';
    }
  }
}
