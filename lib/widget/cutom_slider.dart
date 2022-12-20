
import 'package:flutter/material.dart';

import '../utils/bmi_util.dart';

class CustomSlider extends StatefulWidget {
  const CustomSlider({
    Key? key,
  }) : super(key: key);

  @override
  State<CustomSlider> createState() => _CustomSliderState();
  // double sliderValue = 170;
}

class _CustomSliderState extends State<CustomSlider> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              BmiUtil.height.toString(),
              style: const TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
            ),
            const Text("   cm")
          ],
        ),
        Slider(
            thumbColor: Colors.blue,
            activeColor: Colors.green,
            inactiveColor: Colors.white,
            min: 30,
            max: 275,
            divisions: 275,
            value: BmiUtil.height.toDouble(),
            onChanged: (slideNewValue) {
              setState(() {
                BmiUtil.height = slideNewValue.toInt();
                // BmiUtil.height = slideNewValue.toInt();
              });
            }),
      ],
    );
  }
}
