import 'package:flutter/material.dart';
import 'package:habitbuddyvvmm/ui/components/habit_selection_card.dart';
import 'package:habitbuddyvvmm/ui/components/reusable_card.dart';
import 'package:habitbuddyvvmm/viewmodels/add_habit_reflection_view_model.dart';
import 'package:stacked/_viewmodel_builder.dart';
import 'package:habitbuddyvvmm/constants/app_colors.dart';
import 'package:habitbuddyvvmm/ui/components/dynamic_components.dart';
import 'package:habitbuddyvvmm/ui/components/input_field.dart';

class AddHabitReflectionView extends StatelessWidget {
  final String habitName;
  final descriptionController = TextEditingController();
  final IconData habitIcon;

  AddHabitReflectionView({Key key, this.habitName, this.habitIcon})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddHabitReflectionViewModel>.reactive(
      viewModelBuilder: () => AddHabitReflectionViewModel(),
      builder: (context, model, child) => Scaffold(
        appBar: appBarStyle(habitName),
        body: SafeArea(
          child: ListView(
            children: <Widget>[
              SizedBox(
                height: 15,
              ),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: dynamicImage(habitName)),
              ReusableCard(
                height: 200,
                color1: primaryBlue,
                color2: primaryBlue,
                cardChild: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: dynamicDescription(habitName),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: InputField(
                  smallVersion: false,
                  placeholder: 'Beschreibung deines Meilensteins',
                  controller: descriptionController,
                ),
              ),
              ReusableCard(
                height: 40,
                color1: accentColor,
                color2: accentColor,
                cardChild: Center(
                  child: Text(
                    'Loslegen!',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                onPress: () {
                  model.addHabitWithTemplate(
                    habitName,
                    descriptionController.text,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
