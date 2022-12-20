
import 'package:flutter/material.dart';

import '../utils/bmi_util.dart';
import '../widget/age_weight_card.dart';
import '../widget/botto_sheet_content.dart';
import '../widget/custom_gender.dart';
import '../widget/height_card.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromRadius(20),
        child: AppBar(
          centerTitle: true,
          // leading: IconButton(onPressed: () {}, icon: Icon(Icons.dashboard)),
          title: const Text("BMI CALCULATOR"),
          backgroundColor: Colors.black,
          // actions: [
          //   IconButton(onPressed: () {}, icon: Icon(Icons.settings_display))
          // ],
        ),
      ),
      body: const BodyContent(),
    );
  }
}


class BodyContent extends StatelessWidget {
  const BodyContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //Age widget
                Container(
                  height: 170,
                  width: 170,
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 90, 87, 87),
                      borderRadius: BorderRadius.circular(15)),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CustomCardWidget(title: "Age(in years)"),
                  ),
                ),

                //Weight widget
                Container(
                  height: 170,
                  width: 170,
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 90, 87, 87),
                      borderRadius: BorderRadius.circular(15)),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CustomCardWidget(
                      title: "Weight(KG)",
                    ),
                  ),
                )
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: CustomHeightWidget(),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            height: 150,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 90, 87, 87),
                borderRadius: BorderRadius.circular(15)),
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  "Gender",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    Text(
                      "I'm ",
                      style:
                          TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                    ),
                    CustomGender(),
                  ],
                )
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
              height: 60,
              width: 250,
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 68, 88, 201),
                  borderRadius: BorderRadius.circular(20)),
              child: TextButton(
                  onPressed: () {
                    var bmi = BmiUtil.calculateBMI();

                    showModalBottomSheet(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      backgroundColor: Colors.black,
                      context: context,
                      builder: (context) {
                        return BottomSheetContent(bmi: bmi);
                      },
                    );
                  },
                  child: const Text(
                    "CALCULATE",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  )))
        ],
      ),
    );
  }
}

