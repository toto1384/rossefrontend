

import 'package:flutter/cupertino.dart';
import 'package:rosse/icon_pack_icons.dart';
import 'package:rosse/utils/date_utils.dart';
import 'package:rosse/utils/typedef_and_enums_utils.dart';
import 'package:rosse/utils/values_utils.dart';

class RosseAction{

  int id;
  String name;
  bool remindUser;

  String lastChecked;
  int reset;

  int brainImprovement;
  int healthImprovement;
  int energyImprovement;
  int effort;

  int type;

  String howToDoIt;
  String why;
  String tldr;

  bool checked;

  List<Interest> interests;

  

  static Duration getResetDuration(int resetTime){
    if(resetTime==resetEvening){

      return Duration(days: 1);

    }else if(resetTime==resetMorning){

      return Duration(days: 1);

    }else if(resetTime==resetEveryDay){

      return Duration(days: 1);

    }else if(resetTime==resetEveryThreeHours){

      return Duration(hours: 3);

    }else{

      return Duration(seconds: 1);

    }
  }

  RosseAction({@required this.id,@required this.name,this.remindUser,this.lastChecked,@required this.reset, @required this.brainImprovement, @required this.healthImprovement,
   @required this.energyImprovement,@required this.effort, @required this.type, @required this.howToDoIt, @required this.why, @required this.tldr,this.interests}){
    if(remindUser==null){
      remindUser=false;
    }

    isChecked();
  }

  isChecked(){
    if(lastChecked==null){
      checked= false;
      return;
    }
    if(getDateFromString(lastChecked).year==DateTime.now().year&&getDateFromString(lastChecked).month==DateTime.now().month&&getDateFromString(lastChecked).day==DateTime.now().day){
      checked=true;
    }else checked=false;
  }



  toMap(){
    return {
      action_id : id,
      action_name: name,
      action_last_checked : lastChecked,
      action_remind_user : remindUser,
      action_reset : reset,
      action_brain_improvement : brainImprovement,
      action_health_improvement : healthImprovement,
      action_energy_improvement: energyImprovement,
      action_effort: effort,
      action_type : type,
      action_why : why,
      action_tldr: tldr,
      action_how_to_do_it: howToDoIt,
    };
  }

  static fromMap(Map map){
    return RosseAction(
      id : map[action_id],
      name: map[action_name],
      lastChecked: map[action_last_checked],
      type: map[action_type],
      why: map[action_why],
      brainImprovement: map[action_brain_improvement],
      effort: map[action_effort],
      energyImprovement: map[action_energy_improvement],
      healthImprovement: map[action_health_improvement],
      howToDoIt: map[action_how_to_do_it],
      reset: map[action_reset],
      tldr: map[action_tldr],
      remindUser: map[action_remind_user],
    );
  }

  double getImprovement({String improvement, List<Interest> interests}){
    if(improvement==null){

      int improvement = 0;

      interests.forEach((item){
        switch(item){
          case Interest.Brain:
            improvement+=brainImprovement;
            break;
          case Interest.Energy:
            improvement+=energyImprovement;
            break;
          case Interest.Health:
            improvement+=healthImprovement;
            break;
        }
      });

      return (improvement.toDouble()/100.00*3);
    }else{
      switch(improvement){
        case action_brain_improvement: return brainImprovement/100*3;break;
        case action_energy_improvement: return energyImprovement/100*3;break;
        case action_health_improvement: return healthImprovement/100*3;break;
        default: return 1;
      }
    }
  }

  getIcon(){
    switch(type){
      case type_habits: return IconPack.habit;break;
      case type_nutrition: return IconPack.nutrition;break;
      case type_sleep: return IconPack.sleep;break;
      case type_insomnia: return IconPack.sleep; break;
    }
  }

  getTypeIllustration(){
    switch(type){
      case type_habits: return AssetsPath.habits;break;
      case type_nutrition: return AssetsPath.nutrition;break;
      case type_sleep: return AssetsPath.sleep;break;
      case type_insomnia: return AssetsPath.sleep;break;
    }
  }

  getTypeText(){
    switch(type){
      case type_habits: return 'Habits';break;
      case type_nutrition: return 'Nutrition';break;
      case type_sleep: return 'Sleep';break;
      case type_insomnia: return 'Insomnia'; break;
    }
  }

}

const String action_id = 'i';
const String action_name = 'n';
const String action_remind_user = 'r';
const String action_last_checked = 'l';
const String action_reset = 're';
const String action_brain_improvement = 'b';
const String action_health_improvement = 'h';
const String action_energy_improvement = 'e';
const String action_effort = 'ef';
const String action_type = 't';
const String action_why = 'w';
const String action_tldr = 'tr';
const String action_how_to_do_it = 'ho';



const int resetMorning = 0;
const int resetEvening = 1;
const int resetEveryDay = 2;
const int resetEveryThreeHours = 3;
const int resetNever = 4;


const int type_nutrition = 0;
const int type_sleep = 1;
const int type_habits = 2;
const int type_insomnia = 3;



