import 'package:flutter/material.dart';

import '../utils/bmi_util.dart';
import 'cutom_slider.dart';
import 'feet_inch_card.dart';

class CustomHeightWidget extends StatefulWidget {
  final bool isWideScreen;
  const CustomHeightWidget({Key? key, required this.isWideScreen})
      : super(key: key);

  @override
  State<CustomHeightWidget> createState() => _CustomHeightWidgetState();
}

class _CustomHeightWidgetState extends State<CustomHeightWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.isWideScreen
          ? MediaQuery.of(context).size.height * 0.4
          : MediaQuery.of(context).size.height * 0.3,
      width: widget.isWideScreen
          ? MediaQuery.of(context).size.width * 0.8
          : MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: const Color.fromARGB(255, 90, 87, 87),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
                alignment: Alignment.centerRight,
                child: Container(
                  height: 35,
                  width: 120,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text(
                        " cm",
                        style: TextStyle(color: Colors.black87),
                      ),
                      Switch(
                          activeTrackColor: Colors.grey,
                          inactiveTrackColor: Colors.grey,
                          activeColor: const Color.fromARGB(255, 104, 72, 250),
                          inactiveThumbColor:
                              const Color.fromARGB(255, 104, 72, 250),
                          value: BmiUtil.isCmUnit,
                          onChanged: ((bool newValue) {
                            setState(() {
                              BmiUtil.isCmUnit = newValue;
                            });
                          })),
                      const Text(
                        "ft ",
                        style: TextStyle(color: Colors.black87),
                      ),
                    ],
                  ),
                )),
          ),
          const Text(
            "Height",
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const SizedBox(
            height: 16,
          ),
          SizedBox(
            height: 110,
            // color: Colors.white,

            child: BmiUtil.isCmUnit
                ? const CustomRowInput()
                : const CustomSlider(),
          ),
        ],
      ),
    );
  }
}
