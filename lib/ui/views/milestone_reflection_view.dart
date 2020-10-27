import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:habitbuddyvvmm/constants/texts.dart';
import 'package:habitbuddyvvmm/constants/app_colors.dart';
import 'package:habitbuddyvvmm/models/habit.dart';
import 'package:habitbuddyvvmm/ui/components/reusable_card.dart';
import 'package:stacked/stacked.dart';
import 'package:habitbuddyvvmm/viewmodels/milestone_reflection_view_model.dart';

class MilestoneReflectionView extends StatefulWidget {
  final Habit habit;
  MilestoneReflectionView({Key key, this.habit}) : super(key: key);
  @override
  _MilestoneReflectionViewState createState() =>
      _MilestoneReflectionViewState();
}

class _MilestoneReflectionViewState extends State<MilestoneReflectionView> {
  int _value = 5;
  int _value2 = 5;
  int _value3 = 3;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MilestoneReflectionViewModel>.reactive(
      viewModelBuilder: () => MilestoneReflectionViewModel(),
      onModelReady: (model) => model.getRandomSrhiItem(),
      builder: (context, model, child) => Container(
        color: primaryBlue,
        child: SafeArea(
          child: Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(80),
              child: AppBar(
                backgroundColor: primaryBlue,
                flexibleSpace: Container(
                  padding: EdgeInsets.all(10),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(24.0, 0, 10, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          width: 10.0,
                        ),
                        CircleAvatar(
                          child: Icon(
                            widget.habit.habitIcon,
                            size: 25.0,
                            color: accentColor,
                          ),
                          backgroundColor: Colors.white,
                          radius: 25.0,
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Expanded(
                          child: AutoSizeText(
                            widget.habit.customName,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            backgroundColor: backgroundColor,
            body: ListView(
              children: <Widget>[
                SizedBox(
                  height: 30,
                ),
                ReusableCard(
                  boxShadow: false,
                  center: true,
                  height: 80,
                  color1: primaryBlue,
                  color2: secondaryBlue,
                  cardChild: AutoSizeText(
                    model.questionOne,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 17),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  _value.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 60, color: Colors.white),
                ),
                Column(
                  children: <Widget>[
                    Container(
                      width: 340,
                      child: SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          activeTrackColor: primaryBlue,
                          inactiveTrackColor: secondaryBlue,
                          trackShape: RoundedRectSliderTrackShape(),
                          trackHeight: 2.0,
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
                          Text(
                            'Stimme nicht zu',
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            'Stimme zu',
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                ReusableCard(
                  boxShadow: false,
                  center: true,
                  height: 80,
                  color1: primaryBlue,
                  color2: secondaryBlue,
                  cardChild: AutoSizeText(
                    model.questionTwo,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 17),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  _value2.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 60, color: Colors.white),
                ),
                Column(
                  children: <Widget>[
                    Container(
                      width: 340,
                      child: SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          activeTrackColor: primaryBlue,
                          inactiveTrackColor: secondaryBlue,
                          trackShape: RoundedRectSliderTrackShape(),
                          trackHeight: 2.0,
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
                          value: _value2.toDouble(),
                          min: 0,
                          max: 10,
                          divisions: 10,
//                        label: '${_value.toInt()}',
                          onChanged: (double value2) {
                            setState(
                              () {
                                _value2 = value2.toInt();
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
                          Text(
                            'Stimme nicht zu',
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            'Stimme zu',
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                ReusableCard(
                  boxShadow: false,
                  center: true,
                  height: 80,
                  color1: primaryBlue,
                  color2: secondaryBlue,
                  cardChild: AutoSizeText(
                    milestoneFrage,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 17),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  _value3.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 60, color: Colors.white),
                ),
                Column(
                  children: <Widget>[
                    Container(
                      width: 340,
                      child: SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          activeTrackColor: primaryBlue,
                          inactiveTrackColor: secondaryBlue,
                          trackShape: RoundedRectSliderTrackShape(),
                          trackHeight: 2.0,
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
                          value: _value3.toDouble(),
                          min: 1,
                          max: 5,
                          divisions: 5,
//                        label: '${_value.toInt()}',
                          onChanged: (double value3) {
                            setState(
                              () {
                                _value3 = value3.toInt();
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
                          Text(
                            'Gar nicht',
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            'sehr',
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                ReusableCard(
                  center: true,
                  height: 50,
                  color1: accentColor,
                  color2: accentColorGradient,
                  cardChild: Text(
                    'Meilenstein abschließen',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  onPress: () async {
                    await model.completeMilestone(
                        widget.habit, _value, _value2, _value3);
                    await model.saveMilestoneToStore(widget.habit, _value,
                        _value2, model.questionOne, model.questionTwo, _value3);
                    Navigator.pop(context, model.completedMilestone);
                  },
                ),
                SizedBox(
                  height: 40,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
