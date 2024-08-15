import 'package:flutter/material.dart';

import '../utils/bmi_util.dart';

class CustomCardWidget extends StatefulWidget {
  const CustomCardWidget({
    Key? key,
    required this.title,
  }) : super(key: key);
  final String title;

  @override
  State<CustomCardWidget> createState() => _CustomCardWidgetState();
}

class _CustomCardWidgetState extends State<CustomCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(
            widget.title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Text(
            widget.title.contains('Age')
                ? BmiUtil.age.toString()
                : BmiUtil.weight.toInt().toString(),
            style: const TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              //decrement button
              InkWell(
                onTap: () {
                  // print("object${BmiUtil.age}");
                  setState(() {
                    if (widget.title.contains('Age') && BmiUtil.age > 12)
                      BmiUtil.age--;
                    if (widget.title.contains('Weight') && BmiUtil.weight > 20)
                      BmiUtil.weight--;
                  });
                },
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      color: Colors.white24,
                      borderRadius: BorderRadius.circular(50)),
                  child: const Center(child: Icon(Icons.remove)),
                ),
              ),

              //increment  button
              InkWell(
                onTap: () {
                  setState(() {
                    (widget.title.contains('Age') && BmiUtil.age < 100)
                        ? BmiUtil.age++
                        : BmiUtil.age;
                    (widget.title.contains('Weight') && BmiUtil.weight < 200)
                        ? BmiUtil.weight++
                        : BmiUtil.weight;
                  });
                },
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      color: Colors.white24,
                      borderRadius: BorderRadius.circular(50)),
                  child: const Center(child: Icon(Icons.add)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
