import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:rosse/utils/get_widget_utils.dart';
import 'package:rosse/utils/typedef_and_enums_utils.dart';
import 'package:rosse/utils/values_utils.dart';

class AnimatedPercentIndicator extends AnimatedWidget {

  final double value ;
  static double oldValue = 100;

  AnimatedPercentIndicator({Key key,@required this.value, @required Animation<double> animation})
      : super(key: key, listenable: animation);

  Widget build(BuildContext context) {

    Tween tween = Tween<double>(begin: oldValue, end: value);

    final animation = listenable as Animation<double>;

    animation.addStatusListener((status) {
      if(status == AnimationStatus.completed){
        oldValue = value;
      }
    });
    
    double val = tween.evaluate(animation);
    return Container(
      padding: EdgeInsets.all(20),
      child: CircularPercentIndicator(
        radius: 250,
        lineWidth: 27,
        percent: val>100?1.0:val/100,
        center: getText(
          '${val.toStringAsFixed(2)}%',
          textType: TextType.textTypeGigant,
          color: Colors.white
        ),
        circularStrokeCap: CircularStrokeCap.round,
        backgroundColor: Colors.white,
        progressColor: MyColors.color_primary,
      ),
    );
  }
}