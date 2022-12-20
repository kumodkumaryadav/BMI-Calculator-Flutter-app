
import 'package:flutter/material.dart';

import '../utils/bmi_util.dart';

class CustomValueCard extends StatefulWidget {
  const CustomValueCard({
    Key? key,
    required this.titleValue,
  }) : super(key: key);
  final int titleValue;

  @override
  State<CustomValueCard> createState() => _CustomValueCardState();
}

class _CustomValueCardState extends State<CustomValueCard> {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.black,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            widget.titleValue ==1 ? BmiUtil.feet.toString() : '${BmiUtil.inch<10 ?" " :""}${BmiUtil.inch}${BmiUtil.inch<10 ?" " :""}"',
            style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
          ),
          Column(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_upward),
                onPressed: () {
                  setState(() {
                    if(widget.titleValue==1 && BmiUtil.feet<8) BmiUtil.feet++ ;
                    if(widget.titleValue==2 && BmiUtil.inch<12) BmiUtil.inch++ ;
                    BmiUtil.height=BmiUtil.feetInchToCM(BmiUtil.feet,BmiUtil.inch);

                  });
               
                },
              ),
              IconButton(
                icon: const Icon(Icons.arrow_downward),
                onPressed: () {

                  setState(() {

                   if (widget.titleValue==1 && BmiUtil.feet>1) BmiUtil.feet--;
                   if (widget.titleValue==2 && BmiUtil.inch>0) BmiUtil.inch--;
                    BmiUtil.height=BmiUtil.feetInchToCM(BmiUtil.feet,BmiUtil.inch);

                   
                  });
                }
              ),
            ],
          )
        ],
      ),
    );
  }
}
