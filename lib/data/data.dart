
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:rosse/data/login.dart';
import 'package:rosse/data/mobile/mobile_data.dart';
import 'package:rosse/data/web/webData.dart';
import 'package:rosse/main.dart';
import 'package:rosse/utils/date_utils.dart';
import 'package:rosse/utils/typedef_and_enums_utils.dart';

import 'backend.dart';
import 'iap.dart';

class Data{


  MobileData mobileData;
  WebData webData;

  Data({this.mobileData,this.webData});

  static Data data;
  static Future<Data> initData(BuildContext buildContext) async{
    if(data==null){

      if(kIsWeb){
        data= Data(webData: await WebData.getWebData(buildContext));
      }else{
        data= Data(mobileData: await MobileData.getData(buildContext));
      }

      if(data.canSignInSilently()){
        await data.getLoginHelper().initAndSignSilently(data.getBackEnd());
      }

    }
    return data;
  }

  setDarkMode(){
    if(kIsWeb){
      //todo
    }else{
      mobileData.dataHelper.setDarkMode(!MyApp.isDarkMode);
    }
  }

  bool canSignInSilently(){
    if(kIsWeb){
      //tood
      return false;
    }else{
      return mobileData.dataHelper.canSignInSilently();
    }
  }

  setCanSignInSilently(bool csis){
    if(kIsWeb){
      //todo
    }else{
      mobileData.dataHelper.setCanSignInSilently(csis);
    }
  }

  incrementTimesOpened(){
    if(kIsWeb){
      //todo
    }else{
      mobileData.dataHelper.incrementTimesOpened();
    }

  }

  resetTimesOpened(){
    if(kIsWeb){
      //todo
    }else{
      mobileData.dataHelper.resetTimesOpened();
    }

  }


  bool getHideCheckedActions(){
    if(kIsWeb){
      return false;
      //todo
    }else{
      return mobileData.dataHelper.getHideCheckedActions();
    }
  }

  setHideCheckedActions(bool hca){
    if(kIsWeb){
      //todo
    }else{
      mobileData.dataHelper.setHideCheckedActions(hca);
    }
  }


  int getEffort(){
    if(getBackEnd().isAvailable){
      return getBackEnd().getEffort();
    }else{
      if(kIsWeb){
        //todo
        return 0;
      }else{
        return mobileData.dataHelper.getEffort().toInt();
      }
    }
  }

  List<int> getHidedActions(){
    if(getBackEnd().isAvailable){
      //todo
      return null;
    }else{
      if(kIsWeb){
        //todo
        return null;
      }else{
        return mobileData.dataHelper.getHidedActions();
      }
    }
  }

  addHidedAction(int hidedAction)async{
    if(getBackEnd().isAvailable){
      //todo
    }else{
      if(kIsWeb){
        //todo
      }else{
        await mobileData.dataHelper.addHidedAction(hidedAction);
      }
    }
  }

  removeHidedAction(int hidedAction)async{
    if(getBackEnd().isAvailable){
      //todo
    }else{
      if(kIsWeb){
        //todo
      }else{
        await mobileData.dataHelper.removeHidedAction(hidedAction);
      }
    }
  }

  setEffort(double effort){
    if(getBackEnd().isAvailable){
      getBackEnd().setEffort(effort.toInt());
    }else{
      if(kIsWeb){
        //todo
      }else{
        mobileData.dataHelper.setEffort(effort);
      }
    }
  }

  getProgressiveActionDifficulty(){
    if(kIsWeb){
      return ProgressiveActionDifficulty.Easy;
      //todo
    }else{
      return mobileData.dataHelper.getProgressiveActionDifficulty();
    }
  }

  setProgressiveActionDifficulty(ProgressiveActionDifficulty progressiveActionDifficulty){
    if(kIsWeb){
      //todo
    }else{
      mobileData.dataHelper.setProgressiveActionDifficulty(progressiveActionDifficulty);
    }

  }

  IAPHelper getIapHelper(){
    if(kIsWeb){
      return null;
    }else{
      return mobileData.iapHelper;
    }
  }

  getProgressiveDifficultyShoving(){
    if(kIsWeb){
      return true;
      //todo
    }else{
      return mobileData.dataHelper.getProgressiveActionShoving();
    }
  }

  setProgressiveDifficultyShoving(bool pas){
    if(kIsWeb){
      //todo
    }else{
      mobileData.dataHelper.setProgressiveActionShoving(pas);
    }
  }


  String getLastChecked(int id){
    if(getBackEnd().isAvailable){
      String date;
      getBackEnd().getActions().forEach((k,v){
        if(id==k){
          date=v;
        }
      });
      return date;
    }else{
      if(kIsWeb){ 
      return WebData.getLastChecked(id);
      }else{
        return mobileData.dataHelper.getLastChecked(id);
      }
    }
  }

  setLastChecked(int id,String dateTime)async{
    if(getBackEnd().isAvailable){
      getBackEnd().setAction(id, getDateFromString(dateTime));
    }else{
      if(kIsWeb){
      WebData.setLastChecked(dateTime, id);
      }else{
        await mobileData.dataHelper.setLastChecked(id, dateTime);
      }
    }
  }

  List<Interest> getInterests(){
    if(getBackEnd().isAvailable){

        List<Interest> interests = List();

        getBackEnd().getInterests().forEach((item){
          switch(item){
            case 0 : interests.add(Interest.Brain);break;
            case 1 : interests.add(Interest.Energy);break;
            case 2 : interests.add(Interest.Health);break;
          }
        });
        return interests;
    }else{
      if(kIsWeb){
        //todo
        return null;
      }else{
        return mobileData.dataHelper.getInterests();
      }
    }
  }

  setInterests(List<Interest> interests){
    if(getBackEnd().isAvailable){

      List<int> intInterests = List();

      interests.forEach((item){
        switch(item){
          
          case Interest.Brain:
            intInterests.add(0);
            break;
          case Interest.Energy:
            intInterests.add(1);
            break;
          case Interest.Health:
            intInterests.add(2);
            break;
        }
      });
      getBackEnd().setInterests(intInterests);
    }else{
      if(kIsWeb){

      }else{
        return mobileData.dataHelper.setInterests(interests);
      }
    }
  }




  Future removeLastChecked(int id) async{
     if(getBackEnd().isAvailable){
       await getBackEnd().deleteAction(id);
     }else{
       if(kIsWeb){
        WebData.removeLastChecked(id);
      }else{
        await mobileData.dataHelper.removeLastChecked(id);
      }
     }
   }

  bool getInsomnia(){
    if(getBackEnd().isAvailable){
      //todo
      return null;
    }else{
      if(kIsWeb){
        //todo
        return null;
      }else{
        return mobileData.dataHelper.getInsomnia();
      }
    }
  }

  Future setInsomnia(bool insomnia)async{
    if(getBackEnd().isAvailable){
      //todo
    }else{
      if(kIsWeb){
        //todo
      }else{
        await mobileData.dataHelper.setInsomnia(insomnia);
      }
    }
  }


  Backend getBackEnd(){
    if(kIsWeb){
      return webData.backend;
    }else{
      return mobileData.backend;
    }
  }

  LoginHelper getLoginHelper(){
    if(kIsWeb){
      return webData.loginHelper;
    }else{
      return mobileData.loginHelper;
    }
  }
  


  
}