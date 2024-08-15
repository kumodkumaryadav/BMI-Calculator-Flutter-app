import 'package:bmi_scrach/screens/diet_plan.dart';
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
          style: const TextStyle(fontSize: 90, fontWeight: FontWeight.bold),
        ),
        const Text("Your Body Mass Index"),
        const SizedBox(
          height: 16,
        ),
        Text(
          BmiUtil.getResult(),
          style: BmiUtil.resultTextStyle(BmiUtil.calculateBMI()),
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 16,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Text(
            BmiUtil.getInterpretation(),
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
        ),
        TextButton(
          onPressed: () {
            // Action when the button is pressed
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                      title: const Text("Create Diet Plan"),
                      content: const Text(
                          "This feature will help you create a personalized diet plan to manage your BMI to a normal range."),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text("CLOSE"),
                        ),
                        TextButton(
                          onPressed: () {
                            // Navigate to the diet plan creation screen
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => UserInfoScreen(),
                              ),
                            );
                            // Add navigation code to the diet plan screen here
                          },
                          child: const Text("CREATE PLAN"),
                        ),
                      ]);
                });
          },
          child: const Text("CREATE Diet PLAN with AI"),
        )
      ],
    );
  }
}
