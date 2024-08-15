import 'dart:developer';

import 'package:bmi_scrach/utils/bmi_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserInfoScreen extends StatefulWidget {
  @override
  _UserInfoScreenState createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  final apiKey = "AIzaSyApVMkHDgYv6p8cwaaR1Xc7VJ3OkWk76ZA";
  late final GenerativeModel _generativeModel;
  late final ChatSession _chatSession;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _targetWeightController = TextEditingController();
  final TextEditingController _ageController = TextEditingController(); // Added
  final TextEditingController _allergiesDescriptionController =
      TextEditingController();
  final TextEditingController _healthConditionsDescriptionController =
      TextEditingController();

  String _gender = 'Male';
  String _activityLevel =
      'Moderately Active (moderate exercise/sports 3-5 days/week)';
  String _dietType = 'Vegetarian';
  String _cuisinePreference = 'Indian';
  bool _hasAllergies = false;
  bool _hasHealthCondition = false;
  String _intermittentFasting = 'NA';
  double _mealPreparationTime = 30.0;
  double _waterIntake = 3.0;
  TimeOfDay _bedtime = const TimeOfDay(hour: 22, minute: 0);
  TimeOfDay _wakeUpTime = const TimeOfDay(hour: 6, minute: 0);

  bool _loading = false;
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    _generativeModel =
        GenerativeModel(model: "gemini-1.5-flash", apiKey: apiKey);
    _chatSession = _generativeModel.startChat();
  }

  @override
  Widget build(BuildContext context) {
    final model = GenerativeModel(model: 'gemini-1.5-flash', apiKey: apiKey);
    _heightController.text = BmiUtil.height.toString();
    _weightController.text = BmiUtil.weight.toString();
    _ageController.text = BmiUtil.age.toString();
    _gender = BmiUtil.gender;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Fill info to Create a Diet Plan',
          style: TextStyle(fontSize: 20),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildNumberedCard(1, 'What is your height? (in cm)',
                  _buildTextField(_heightController)),
              _buildNumberedCard(2, 'What is your current weight? (in kg)',
                  _buildTextField(_weightController)),
              _buildNumberedCard(3, 'What is your target weight? (in kg)',
                  _buildTextField(_targetWeightController)),
              _buildNumberedCard(4, 'How old are you? (in years)',
                  _buildTextField(_ageController)), // Added
              _buildNumberedCard(
                  5, 'What is your gender?', _buildGenderSelector()),
              _buildNumberedCard(6, 'What is your activity level?',
                  _buildActivityLevelSelector()),
              _buildNumberedCard(
                  7, 'What is your diet type?', _buildDietTypeSelector()),
              _buildNumberedCard(8, 'Do you have any food allergies?',
                  _buildFoodAllergiesCheckbox()),
              if (_hasAllergies)
                _buildNumberedCard(9, 'Please describe your food allergies:',
                    _buildTextField(_allergiesDescriptionController)),
              _buildNumberedCard(
                  10,
                  'Do you have any existing health conditions?',
                  _buildHealthConditionsCheckbox()),
              if (_hasHealthCondition)
                _buildNumberedCard(
                    11,
                    'Please describe your health conditions:',
                    _buildTextField(_healthConditionsDescriptionController)),
              _buildNumberedCard(12, 'What is your cuisine preference?',
                  _buildCuisinePreferenceSelector()),
              _buildNumberedCard(13, 'Are you following intermittent fasting?',
                  _buildIntermittentFastingSelector()),
              _buildNumberedCard(
                  14, 'Meal Preparation Time (minutes)', _buildSlider()),
              _buildNumberedCard(
                  15,
                  'What time do you usually go to bed?',
                  _buildTimePicker(_bedtime, (time) {
                    setState(() {
                      _bedtime = time!;
                    });
                  })),
              _buildNumberedCard(
                  16,
                  'What time do you usually wake up?',
                  _buildTimePicker(_wakeUpTime, (time) {
                    setState(() {
                      _wakeUpTime = time!;
                    });
                  })),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    // ScaffoldMessenger.of(context).showSnackBar(
                    //   const SnackBar(content: Text('Processing Data')),
                    // );
                    SharedPreferences spref =
                        await SharedPreferences.getInstance();
                    var lastData = spref.getString("lastData") ?? "";
                    if (lastData.isEmpty) {
                      sendChatMessage(generateDietPlanPrompt());
                    } else {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                                title: const Text(
                                    "Already have existing diet plan"),
                                content: const Text(
                                    "You already have existing diet plan. follow one plan for atleast 1 months to see changes in weight!"),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      sendChatMessage(generateDietPlanPrompt());
                                    },
                                    child: const Text("Create New Diet Plan"),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      _showLargeResponseModalSheet(
                                          context, lastData);
                                    },
                                    child: const Text("See Existing Diet Plan"),
                                  ),
                                ]);
                          });
                    }
                  } else {}
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void sendChatMessage(String generateDietPlanPrompt) async {
    SharedPreferences spref = await SharedPreferences.getInstance();

    try {
      SmartDialog.showLoading(
          msg: "Creating diet plan please wait few minutes");
      final response =
          await _chatSession.sendMessage(Content.text(generateDietPlanPrompt));
      final text = response.text;
      print(text);
      if (text == null) {
        // _showError("No reponse from AI right now. Try later!");
        return;
      } else {
        spref.setString("lastData", text);
        _showLargeResponseModalSheet(context, text);

        log(text);
      }
    } catch (e) {
      // _showError(e.toString());
    } finally {
      SmartDialog.dismiss();
    }
  }

  Widget _buildNumberedCard(int number, String title, Widget child) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                '$number. ',
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: child,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(TextEditingController? controller,
      {String? initialValue}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        initialValue: initialValue,
        decoration: const InputDecoration(
          labelStyle: TextStyle(fontSize: 16, color: Colors.blueGrey),
        ),
        keyboardType: TextInputType.number,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter a value.';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildGenderSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildRadioOption('Male', _gender, (value) {
          setState(() {
            _gender = value!;
          });
        }),
        _buildRadioOption('Female', _gender, (value) {
          setState(() {
            _gender = value!;
          });
        }),
      ],
    );
  }

  Widget _buildActivityLevelSelector() {
    List<String> activityLevels = [
      'Sedentary (little or no exercise)',
      'Lightly Active (light exercise/sports 1-3 days/week)',
      'Moderately Active (moderate exercise/sports 3-5 days/week)',
      'Very Active (hard exercise/sports 6-7 days a week)',
      'Super Active (very hard exercise/physical job & exercise 2x/day)',
    ];

    return SingleChildScrollView(
      // Wrap in SingleChildScrollView
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: activityLevels.map((activity) {
          return _buildRadioOption(activity, _activityLevel, (value) {
            setState(() {
              _activityLevel = value!;
            });
          });
        }).toList(),
      ),
    );
  }

  Widget _buildDietTypeSelector() {
    List<String> dietTypes = [
      'Vegetarian',
      'Vegan',
      'Non-Vegetarian',
      'Pescatarian (includes fish)',
      'Other (please specify)',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: dietTypes.map((diet) {
        return _buildRadioOption(diet, _dietType, (value) {
          setState(() {
            _dietType = value!;
          });
        });
      }).toList(),
    );
  }

  Widget _buildCuisinePreferenceSelector() {
    List<String> cuisines = [
      'Indian',
      'Chinese',
      'Continental',
      'Mediterranean',
      'Other (please specify)',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: cuisines.map((cuisine) {
        return _buildRadioOption(cuisine, _cuisinePreference, (value) {
          setState(() {
            _cuisinePreference = value!;
          });
        });
      }).toList(),
    );
  }

  Widget _buildFoodAllergiesCheckbox() {
    return CheckboxListTile(
      title: const Text('I have food allergies'),
      value: _hasAllergies,
      onChanged: (value) {
        setState(() {
          _hasAllergies = value!;
        });
      },
      activeColor: Theme.of(context).primaryColor,
    );
  }

  Widget _buildHealthConditionsCheckbox() {
    return CheckboxListTile(
      title: const Text('I have health conditions'),
      value: _hasHealthCondition,
      onChanged: (value) {
        setState(() {
          _hasHealthCondition = value!;
        });
      },
      activeColor: Theme.of(context).primaryColor,
    );
  }

  Widget _buildIntermittentFastingSelector() {
    List<String> fastingOptions = [
      'NA',
      '16/8 (16 hours fasting, 8 hours eating)',
      '18/6 (18 hours fasting, 6 hours eating)',
      '20/4 (20 hours fasting, 4 hours eating)',
      'Other',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: fastingOptions.map((option) {
        return _buildRadioOption(option, _intermittentFasting, (value) {
          setState(() {
            _intermittentFasting = value!;
          });
        });
      }).toList(),
    );
  }

  Widget _buildRadioOption(
      String title, String groupValue, Function(String?) onChanged) {
    return Row(
      children: [
        Radio<String>(
          value: title,
          groupValue: groupValue,
          onChanged: onChanged,
        ),
        Text(title),
      ],
    );
  }

  Widget _buildSlider() {
    return Slider(
      value: _mealPreparationTime,
      min: 10,
      max: 120,
      divisions: 11,
      label: '${_mealPreparationTime.round()} minutes',
      onChanged: (value) {
        setState(() {
          _mealPreparationTime = value;
        });
      },
    );
  }

  Widget _buildTimePicker(
      TimeOfDay initialTime, Function(TimeOfDay?) onTimeChanged) {
    return ListTile(
      title: const Text('Select time'),
      subtitle: Text('${initialTime.format(context)}'),
      onTap: () async {
        final TimeOfDay? picked = await showTimePicker(
          context: context,
          initialTime: initialTime,
        );
        if (picked != null && picked != initialTime) {
          onTimeChanged(picked);
        }
      },
    );
  }

  String generateDietPlanPrompt() {
    String prompt = '''
    Create a personalized diet plan for 3 months weekwise with each day based on the following information:
    - Height: ${_heightController.text} cm
    - Weight: ${_weightController.text} kg
    - Target Weight: ${_targetWeightController.text} kg
    - Age: ${_ageController.text} years
    - Gender: $_gender
    - Activity Level: $_activityLevel
    - Diet Type: $_dietType
    - Cuisine Preference: $_cuisinePreference
    - Allergies: ${_hasAllergies ? 'Yes, ${_allergiesDescriptionController.text}' : 'No'}
    - Health Conditions: ${_hasHealthCondition ? 'Yes, ${_healthConditionsDescriptionController.text}' : 'No'}
    - Intermittent Fasting: $_intermittentFasting
    - Meal Preparation Time: ${_mealPreparationTime.round()} minutes
    - Bedtime: ${_bedtime.format(context)}
    - Wake-Up Time: ${_wakeUpTime.format(context)}
    ''';

    // Process the prompt or send it to an API
    log(prompt);
    return prompt;
  }

  void _showLargeResponseModalSheet(BuildContext context, String responseText) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          ),
          child: DraggableScrollableSheet(
            expand: true,
            maxChildSize: 1,
            initialChildSize: 1,
            builder: (context, scrollController) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Your Diet Plan',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    // Wrapping Markdown with Expanded
                    child: Markdown(
                      data: responseText,
                      controller:
                          scrollController, // Pass the scroll controller here
                      styleSheet: MarkdownStyleSheet(
                        h1: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent,
                        ),
                        h2: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueGrey,
                        ),
                        h3: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                        p: const TextStyle(
                          fontSize: 16,
                          height: 1.5,
                          color: Colors.white70,
                        ),
                        strong: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        em: const TextStyle(
                          fontStyle: FontStyle.italic,
                        ),
                        blockquote: TextStyle(
                          fontSize: 16,
                          fontStyle: FontStyle.italic,
                          color: Colors.grey,
                          backgroundColor: Colors.grey[200],
                        ),
                        listBullet: const TextStyle(
                          fontSize: 16,
                          color: Colors.blueAccent,
                        ),
                        a: const TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                        code: TextStyle(
                          fontFamily: 'Courier',
                          fontSize: 14,
                          color: Colors.purple,
                          backgroundColor: Colors.grey[100],
                        ),
                        horizontalRuleDecoration: const BoxDecoration(
                          border: Border(
                            top: BorderSide(
                              color: Colors.grey,
                              width: 2,
                            ),
                          ),
                        ),
                        img: const TextStyle(
                          fontSize: 16,
                        ),
                        tableHead: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          backgroundColor: Colors.black,
                        ),
                        tableBody: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 50, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Close',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
