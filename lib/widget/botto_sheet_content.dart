
import 'package:flutter/material.dart';

import '../utils/bmi_util.dart';

class BottomSheetContent extends StatelessWidget {
  const BottomSheetContent({
    Key? key,
    required this.bmi,
  }) : super(key: key);

  final String bmi;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          bmi,
          style: const TextStyle(
              fontSize: 90, fontWeight: FontWeight.bold),
        ),
        const Text("Your Body Mass Index"),
        const SizedBox(
          height: 16,
        ),
        Text(
          BmiUtil.getResult(),
          style: BmiUtil.resultTextStyle(
              BmiUtil.calculateBMI()),
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 16,
        ),
        Padding(
          padding:
              const EdgeInsets.only(left: 20, right: 20),
          child: Text(
            BmiUtil.getInterpretation(),
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 18, fontWeight: FontWeight.w500),
          ),
        )
      ],
    );
  }
}