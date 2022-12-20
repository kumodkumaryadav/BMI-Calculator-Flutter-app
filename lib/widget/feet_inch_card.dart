
import 'package:flutter/material.dart';

import 'feet_inch_widget.dart';

class CustomRowInput extends StatelessWidget {
  const CustomRowInput({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: const [
        CustomValueCard(
          titleValue: 1,
        ),
        CustomValueCard(
          titleValue: 2,
        ),
      ],
    );
  }
}
