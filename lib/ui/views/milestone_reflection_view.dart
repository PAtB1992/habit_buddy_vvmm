import 'package:flutter/material.dart';
import 'package:habitbuddyvvmm/constants/texts.dart';
import 'package:habitbuddyvvmm/constants/app_colors.dart';
import 'package:habitbuddyvvmm/constants/route_names.dart';
import 'package:habitbuddyvvmm/models/habit.dart';
import 'package:habitbuddyvvmm/services/navigation_service.dart';
import 'package:habitbuddyvvmm/ui/components/reusable_card.dart';
import 'package:habitbuddyvvmm/ui/components/rounded_button.dart';
import 'package:habitbuddyvvmm/viewmodels/start_view_model.dart';
import 'package:stacked/stacked.dart';
import 'package:habitbuddyvvmm/locator.dart';
import 'package:habitbuddyvvmm/viewmodels/milestone_reflection_view_model.dart';

class MilestoneReflectionView extends StatefulWidget {
  final Habit habit;
  MilestoneReflectionView({Key key, this.habit}) : super(key: key);
  @override
  _MilestoneReflectionViewState createState() =>
      _MilestoneReflectionViewState();
}

class _MilestoneReflectionViewState extends State<MilestoneReflectionView> {
  final NavigationService _navigationService = locator<NavigationService>();
  int _value = 5;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MilestoneReflectionViewModel>.reactive(
      viewModelBuilder: () => MilestoneReflectionViewModel(),
      builder: (context, model, child) => Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              color: primaryBlue,
              padding: EdgeInsets.only(top: 60.0, bottom: 30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircleAvatar(
                    child: Icon(
                      widget.habit.habitIcon,
                      size: 30.0,
                      color: accentColor,
                    ),
                    backgroundColor: Colors.white,
                    radius: 30.0,
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Wrap(
                    children: <Widget>[
                      Text(
                        widget.habit.name,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            ReusableCard(
              height: 80,
              color1: primaryBlue,
              color2: primaryBlue,
              cardChild: Center(
                child: Text(
                  milestoneFrage,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Text(
              _value.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 70, color: primaryBlue),
            ),
            Column(
              children: <Widget>[
                Container(
                  child: SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      activeTrackColor: primaryBlue,
                      inactiveTrackColor: secondaryBlue,
                      trackShape: RoundedRectSliderTrackShape(),
                      trackHeight: 4.0,
                      thumbShape:
                          RoundSliderThumbShape(enabledThumbRadius: 12.0),
                      thumbColor: accentColor,
                      tickMarkShape: RoundSliderTickMarkShape(),
                      activeTickMarkColor: primaryBlue,
                      inactiveTickMarkColor: secondaryBlue,
                      overlayColor: accentColor.withAlpha(32),
                      overlayShape:
                          RoundSliderOverlayShape(overlayRadius: 28.0),
                      valueIndicatorTextStyle: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    child: Slider(
                      value: _value.toDouble(),
                      min: 0,
                      max: 10,
                      divisions: 10,
//                        label: '${_value.toInt()}',
                      onChanged: (double value) {
                        setState(
                          () {
                            _value = value.toInt();
                          },
                        );
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('Sehr schwierig'),
                      Text('Sehr einfach')
                    ],
                  ),
                ),
              ],
            ),
            ReusableCard(
              height: 50,
              color1: accentColor,
              color2: accentColor,
              cardChild: Center(
                child: Text(
                  'Meilenstein abschließen',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              onPress: () async {
                await model.completeMilestone(widget.habit.listIndex);
                await model.saveMilestoneToStore(widget.habit, _value);
                _navigationService.pop();
              },
            ),
            SizedBox(
              height: 40,
            )
          ],
        ),
      ),
    );
  }
}
