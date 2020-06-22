

import 'package:flutter/material.dart';
import 'package:rosse/data/login.dart';

import '../backend.dart';
import '../iap.dart';
import 'mobile_database.dart';

class MobileData {

  LoginHelper loginHelper;
  Backend backend;
  IAPHelper iapHelper;
  DataHelper dataHelper;

  MobileData({ this.loginHelper, this.backend, this.iapHelper, this.dataHelper});

  static Future<MobileData> getData(BuildContext buildContext)async{
    
    MobileData data =MobileData();

    data.dataHelper=await DataHelper.getInstance(buildContext);
    data.loginHelper = LoginHelper.initObject(buildContext);
    data.backend = await Backend.initBackend(data.loginHelper,data.dataHelper.getToken(),buildContext,(token){data.dataHelper.setToken(token);});
    data.iapHelper= IAPHelper();
    data.iapHelper.initPlatformState('12345',buildContext);
      
    return data;
  }
}