
import 'package:flutter/material.dart';

import '../utils/bmi_util.dart';

class CustomGender extends StatefulWidget {
  const CustomGender({super.key});

  @override
  State<CustomGender> createState() => _CustomGenderState();
}

class _CustomGenderState extends State<CustomGender> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Align(
          alignment: Alignment.centerRight,
          child: Container(
            height: 35,
            width: 220,
            decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(25)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text(
                  " Female",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                Switch(
                    activeTrackColor: Colors.white,
                    inactiveTrackColor: Colors.white,
                    activeColor: const Color.fromARGB(255, 104, 72, 250),
                    inactiveThumbColor: const Color.fromARGB(255, 104, 72, 250),
                    value: BmiUtil.isCmUnit,
                    onChanged: ((bool newValue) {
                      setState(() {
                        BmiUtil.isCmUnit = newValue;
                      });
                    })),
                const Text(
                  "Male ",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          )),
    );
  }
}
