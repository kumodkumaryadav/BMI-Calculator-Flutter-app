import 'package:bmi_scrach/widget/gender_widget.dart';
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
    return SingleChildScrollView(
      child: LayoutBuilder(
        builder: (context, constraints) {
          // Determine if the screen is wide (e.g., tablet or desktop)
          bool isWideScreen = constraints.maxWidth > 600;

          return Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: isWideScreen
                        ? MainAxisAlignment.spaceEvenly
                        : MainAxisAlignment.spaceBetween,
                    children: [
                      // Age widget
                      _buildCard(
                        context,
                        title: "Age (in years)",
                        width: isWideScreen ? constraints.maxWidth * 0.3 : 170,
                      ),
                      const SizedBox(width: 8),
                      // Weight widget
                      _buildCard(
                        context,
                        title: "Weight (KG)",
                        width: isWideScreen ? constraints.maxWidth * 0.3 : 170,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CustomHeightWidget(
                    isWideScreen: isWideScreen,
                  ),
                ),
                const SizedBox(height: 10),
                GenderWidget(isWideScreen: isWideScreen),
                const SizedBox(height: 20),
                Container(
                  height: 60,
                  width: isWideScreen ? 350 : 250,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 68, 88, 201),
                    borderRadius: BorderRadius.circular(20),
                  ),
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
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildCard(BuildContext context,
      {required String title, required double width}) {
    return Container(
      height: 170,
      width: width,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 90, 87, 87),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CustomCardWidget(title: title),
      ),
    );
  }
}
