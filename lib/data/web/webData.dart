import 'package:flutter/cupertino.dart';
import 'package:rosse/data/backend.dart';
import 'package:rosse/data/login.dart';

class WebData{
  static getLastChecked(int id){}
  static getDarkMode(){}
  static getTimesOpened(){}
  static getWebData(BuildContext buildContext){}
  static setLastChecked(id,time){}
  static removeLastChecked(id){}
  LoginHelper loginHelper;
  Backend backend;
}



// import 'dart:html' as web;

// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:rosse/data/backend.dart';
// import 'package:rosse/data/login.dart';
// import 'package:rosse/data/mobile/mobile_database.dart';
// import 'package:rosse/data/mobile/prefs.dart';

// class WebData{


//   Backend backend;
//   LoginHelper loginHelper;
  

//   static Future<WebData> getWebData(BuildContext buildContext)async{
    
//     WebData webData= WebData();


//     webData.loginHelper = LoginHelper.initObject(buildContext);
//     webData.backend =await Backend.initBackend(webData.loginHelper, getToken(), buildContext, setToken);
//     return webData;
//   }


//   static getDarkMode(){
//     if(kIsWeb){
//       String darkmode = web.window.localStorage[PrefsValues.isDarkMode]??'0';
//       return darkmode=='1';
//     }
//   }

//   static String getLastChecked(String id){
//     if(kIsWeb){
//       return web.window.localStorage[id];
//     }else{
//       return '';
//     }
//   }

//   static setLastChecked(String date, String id){

//     if(kIsWeb){
//       web.window.localStorage[id] = date;
//     }
//   }

//   static void removeLastChecked(String id) {
//     if(kIsWeb){
//       web.window.localStorage.remove(id);
//     }
//   }


//   static setDarkMode(){
//     if(kIsWeb){
//       if(getDarkMode()){
//         web.window.localStorage[PrefsValues.isDarkMode] ='0';
//       }else{
//         web.window.localStorage[PrefsValues.isDarkMode] ='1';
//       }
//     }
//   }


//   static getTimesOpened(){
//     if(kIsWeb){
//       return int.parse(web.window.localStorage[PrefsValues.timesOpened]??'0');
//     }
//   }

//   static incrementTimesOpened(){
//     if(kIsWeb){
//       web.window.localStorage[PrefsValues.timesOpened] = (getTimesOpened()+1).toString();
//     }
//   }

//   static resetTimesOpened(){
//     if(kIsWeb){
//       web.window.localStorage[PrefsValues.timesOpened] = '0';
//     }
//   }

//   static getToken(){
//     if(kIsWeb){
//       return web.window.localStorage[PrefsValues.token]??'';
//     }
//   }

//   static setToken(String token){
//     if(kIsWeb){
//       web.window.localStorage[PrefsValues.token]= token;
//     }
//   }

// }