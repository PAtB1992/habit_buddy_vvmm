import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:habitbuddyvvmm/ui/components/reusable_card.dart';
import 'package:habitbuddyvvmm/viewmodels/add_habit_reflection_view_model.dart';
import 'package:stacked/_viewmodel_builder.dart';
import 'package:habitbuddyvvmm/constants/app_colors.dart';
import 'package:habitbuddyvvmm/ui/components/dynamic_components.dart';
import 'package:habitbuddyvvmm/ui/components/input_field.dart';

class AddHabitReflectionView extends StatelessWidget {
  final String habitName;
  final descriptionController = TextEditingController();
  final nameController = TextEditingController();
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
                center: true,
                height: 130,
                color1: primaryBlue,
                color2: primaryBlue,
                cardChild: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
                  child: dynamicDescription(habitName),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: InputField(
                  formatter: LengthLimitingTextInputFormatter(18),
                  smallVersion: true,
                  placeholder: 'Schreibe hier den Namen Deiner Habit.',
                  controller: nameController,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: InputField(
                  formatter: LengthLimitingTextInputFormatter(50),
                  smallVersion: false,
                  placeholder:
                      'Beschreibe hier, wann Dein Meilenstein erfüllt ist.',
                  controller: descriptionController,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 0, 8, 0),
                child: SizedBox(
                  width: 370,
                  height: 40,
                  child: RaisedButton(
                    elevation: 5,
                    color: accentColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    onPressed: () async {
                      await model.addHabit(
                          habitName: habitName,
                          customDescription: descriptionController.text,
                          customName: nameController.text);
                      Navigator.pop(context, model.addedHabit);
                    },
                    child: Text('Loslegen!',
                        style: TextStyle(color: Colors.white, fontSize: 20)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
