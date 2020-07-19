import 'package:flutter/material.dart';
import 'package:habitbuddyvvmm/constants/app_colors.dart';
import 'package:habitbuddyvvmm/constants/route_names.dart';
import 'package:habitbuddyvvmm/services/navigation_service.dart';
import 'package:habitbuddyvvmm/ui/components/rounded_button.dart';
import 'package:habitbuddyvvmm/viewmodels/start_view_model.dart';
import 'package:stacked/stacked.dart';
import 'package:habitbuddyvvmm/locator.dart';
import 'package:habitbuddyvvmm/viewmodels/milestone_reflection_view_model.dart';

class MilestoneReflectionView extends StatefulWidget {
  @override
  _MilestoneReflectionViewState createState() =>
      _MilestoneReflectionViewState();
}

class _MilestoneReflectionViewState extends State<MilestoneReflectionView> {
  final NavigationService _navigationService = locator<NavigationService>();
  double _value = 50;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MilestoneReflectionViewModel>.reactive(
      viewModelBuilder: () => MilestoneReflectionViewModel(),
      builder: (context, model, child) => Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                child: SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    activeTrackColor: primaryBlue,
                    inactiveTrackColor: secondaryBlue,
                    trackShape: RoundedRectSliderTrackShape(),
                    trackHeight: 4.0,
                    thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12.0),
                    thumbColor: accentColor,
                    tickMarkShape: RoundSliderTickMarkShape(),
                    activeTickMarkColor: primaryBlue,
                    inactiveTickMarkColor: secondaryBlue,
                    overlayColor: accentColor.withAlpha(32),
                    overlayShape: RoundSliderOverlayShape(overlayRadius: 28.0),
                    valueIndicatorTextStyle: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  child: Slider(
                    value: _value,
                    min: 0,
                    max: 100,
                    divisions: 10,
                    label: '${_value.toInt()}',
                    onChanged: (value) {
                      setState(
                        () {
                          _value = value;
                        },
                      );
                    },
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
