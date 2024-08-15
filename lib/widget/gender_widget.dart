import 'package:bmi_scrach/widget/custom_gender.dart';
import 'package:flutter/material.dart';

class GenderWidget extends StatelessWidget {
  const GenderWidget({
    super.key,
    required this.isWideScreen,
  });

  final bool isWideScreen;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: isWideScreen
          ? MediaQuery.of(context).size.height * 0.3
          : MediaQuery.of(context).size.height * 0.2,
      width: isWideScreen
          ? MediaQuery.of(context).size.width * 0.8
          : MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 90, 87, 87),
        borderRadius: BorderRadius.circular(15),
      ),
      child: const Column(
        children: [
          SizedBox(height: 30),
          Text(
            "Gender",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "I'm ",
                style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
              ),
              CustomGender(),
            ],
          )
        ],
      ),
    );
  }
}
