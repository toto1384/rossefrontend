
import 'dart:convert';
import 'dart:io' as io;

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import "package:path_provider/path_provider.dart";
import 'package:rosse/utils/typedef_and_enums_utils.dart';

class DataHelper{

  static const String fileName = 'user.json';


  Map<String,dynamic> user;
  io.Directory localDirectory;
  Function onDataUpdated;
  int timesOpened;



  static DataHelper _dataHelper;

  static Future<DataHelper> getInstance(BuildContext context)async{

    if(_dataHelper==null){
      _dataHelper=DataHelper();
    }

      if(_dataHelper.localDirectory==null){
        _dataHelper.localDirectory =await getApplicationDocumentsDirectory();
      

      io.File file = io.File(join(_dataHelper.localDirectory.path,fileName));

      if(!await file.exists()){
        await file.create();
        await file.writeAsString(json.encode(Map()));
        _dataHelper.user = Map();
      }else{
        _dataHelper.user = jsonDecode((await file.readAsString())??json.encode(Map()));
      }
    }

    return _dataHelper;
  }

  static const String _interests = 'interests';
  static const String _brain_interest = 'brint';
  static const String _energy_interest = 'enint';
  static const String _health_interest = 'heint';
  static const String _effort = 'effort';
  static const String _progressiveActionShoving= 'pas';
  static const String _progressiveActionDifficulty= 'pad';
  static const String _hideCheckedActions = 'hca';
  static const String _darkMode = 'darkMode';
  static const String _timesOpened = 'timesOpened';
  static const String _token = 'token';
  static const String _canSignInSilently = 'casinghinsin';
  static const String _insomnia = 'insomnia';
  static const String _hidedActions = 'hactions';


  bool canSignInSilently(){
    return user[_canSignInSilently]??false;
  }

  setCanSignInSilently(bool csis)async{
    user[_canSignInSilently] = csis;
    await saveJson();
  }



  getToken(){
    return user[_token];
  }

  setToken(String token)async{
    user[_token] = token;
    await saveJson();
  }

  bool getInsomnia(){
    return user[_insomnia]??false;
  }

  setInsomnia(bool insomnia)async{
    user[_insomnia] = insomnia;
    await saveJson();
  }


  //times opened
  int getTimesOpened(){
    return user[_timesOpened]??0;
  }

  incrementTimesOpened()async{
    user[_timesOpened] = getTimesOpened() + 1;
    await saveJson();
  }

  resetTimesOpened()async{
    user[_timesOpened] = 0;
    await saveJson();
  }
  //


  String turnHidedActionsToString(List<int> hidedActions){
    String toreturn = '';
    
    hidedActions.forEach((item){
      toreturn = "$toreturn,$item";
    });
    return toreturn;
  }

  List<int> getHidedActions(){
    String hidedacStr = user[_hidedActions]??'';
    List<String> hidedacString = hidedacStr.split(',');

    List<int> toReturn = List();

    hidedacString.forEach((item){
      if(item!=null&&item!=''){
        toReturn.add(int.parse(item));
      }
    });

    return toReturn;
  }

  addHidedAction(int hidedAction)async{
    List<int> ac = getHidedActions();
    ac.add(hidedAction);

    user[_hidedActions] = turnHidedActionsToString(ac);
    await saveJson();
  }

  removeHidedAction(int hidedAction)async{
    List<int> ac = getHidedActions();
    ac.remove(hidedAction);

    user[_hidedActions] = turnHidedActionsToString(ac);
    await saveJson();

  }






  //hide checked actions
  bool getHideCheckedActions(){
    return user[_hideCheckedActions]??false;
  }

  setHideCheckedActions(bool hca)async{
    user[_hideCheckedActions] = hca;
    await saveJson();
  }
  //



  //progressive action shoving
  bool getProgressiveActionShoving(){
    return user[_progressiveActionShoving]??true;
  }

  setProgressiveActionShoving(bool pas)async{
    user[_progressiveActionShoving] = pas;
    await saveJson();
  }
  //


  //progressive action difficulty
  ProgressiveActionDifficulty getProgressiveActionDifficulty(){
    int pad = user[_progressiveActionDifficulty]??1;
    switch(pad){
      case 0: return ProgressiveActionDifficulty.Easy;
      case 1: return ProgressiveActionDifficulty.Medium;
      case 2: return ProgressiveActionDifficulty.Hard;
      default: return ProgressiveActionDifficulty.Easy;
    }
  }

  setProgressiveActionDifficulty(ProgressiveActionDifficulty pas)async{
    int val = 0;
    switch(pas){

      case ProgressiveActionDifficulty.Easy:
        val=0;
        break;
      case ProgressiveActionDifficulty.Medium:
        val=1;
        break;
      case ProgressiveActionDifficulty.Hard:
        val=2;
        break;
    }

    user[_progressiveActionDifficulty] = val;
    await saveJson();
  }
  //


  //darkmode
  bool getDarkMode(){
    return user[_darkMode]??false;
  }

  setDarkMode(bool darkMode)async{
    user[_darkMode] = darkMode;
    await saveJson();
  }
  //


  //lastchecked
  String getLastChecked(int id){
    return user[id.toString()];
  }

  setLastChecked(int id , String dateTime)async{
    user[id.toString()] = dateTime;
    await saveJson();
  }

  removeLastChecked(int id) async{
    user[id.toString()] ='';
    await saveJson();
  }
  //


  //effort
  double getEffort(){
    return double.parse(user[_effort]??'100');
  }

  setEffort(double effort)async{
    user[_effort] = effort.toStringAsFixed(2);
    await saveJson();
  }
  //


  //interests
  List<Interest> getInterests(){
    String interests = user[_interests]??',';
    List<Interest> toreturn = List();
    interests.split(',').forEach((item){
      switch(item){
        case _brain_interest: toreturn.add(Interest.Brain);break;
        case _energy_interest: toreturn.add(Interest.Energy);break;
        case _health_interest: toreturn.add(Interest.Health);break;
      }
    });
    return toreturn;
  }

  setInterests(List<Interest> interests)async{
    String tosave = '';
    interests.forEach((item){
      switch(item){
        case Interest.Brain:
          tosave = tosave + ',' + _brain_interest;
          break;
        case Interest.Energy:
          tosave = tosave + ',' +  _energy_interest;
          break;
        case Interest.Health:
          tosave = tosave + ',' +  _health_interest;
          break;
      }
    });
    user[_interests] = tosave;
    await saveJson();
  }
  //interests



  // List<DateValueObject> getRevenueHistory(){

  //   List mapRH = business[_ConstantsHelpers.revenueHistory];

  //   List<DateValueObject> rh = List();

  //   if(mapRH == null){
  //     return rh;
  //   }

  //   mapRH.forEach((i){
  //     rh.add(DateValueObject.fromMap(i));
  //   });

  //   return rh;
  // }

  // setTotalRevenue(int tr,{bool update}) async {

  //   if(update==null){
  //     update=true;
  //   }

  //   business[_ConstantsHelpers.totalRevenue]=tr;

  //   List<Map<String,dynamic>> revenueHistory = List();
  //   List maprh =business[_ConstantsHelpers.revenueHistory];
  //   if(maprh!=null){
  //     maprh.forEach((item){
  //       revenueHistory.add(item);
  //     });
  //   }

  //   revenueHistory.add(DateValueObject(DateTime.now(),tr).toMap());

  //   business[_ConstantsHelpers.revenueHistory]=revenueHistory;


  //   if(update){
  //     await saveJson();
  //   }
  // }
  // int getTotalRevenue(){
  //   return business[_ConstantsHelpers.totalRevenue]??0;
  // }
  /////revenuerelated
  


  saveJson()async{
    await io.File(join(localDirectory.path,fileName)).writeAsString(jsonEncode(user));
    if(onDataUpdated!=null){
      onDataUpdated();
    }
  }

  deleteJson()async{
    await io.File(join(localDirectory.path,fileName)).delete();
    if(onDataUpdated!=null){
      onDataUpdated();
    }
  }

  Future loadJson()async {
   io.File file =  await FilePicker.getFile(allowedExtensions: ['.json']);
   user = jsonDecode(await file.readAsString());
   if(onDataUpdated!=null){
      onDataUpdated();
    }
  }


}




