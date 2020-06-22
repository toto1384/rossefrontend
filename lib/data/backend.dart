


import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:rosse/objects/user.dart';
import 'package:rosse/utils/date_utils.dart';
import 'login.dart';

class Backend{

  String _url = 'http://34.89.39.88/';

  String token;
  BuildContext buildContext;
  bool isAvailable = false;
  Function(String) setToken;
  User user;

  Backend(this.buildContext,this.token);
  
  static Future<Backend> initBackend(LoginHelper loginHelper,String token,BuildContext buildContext,Function(String) setToken)async{

    Backend backend = Backend(buildContext,token);

    backend.setToken = setToken;

    return backend;
  }


  login(LoginHelper loginHelper)async{

    //  if(loginHelper.currentUser!=null){

    //     try{

    //       Map body = 
    //         {
    //           "id":loginHelper.currentUser.id,
    //           "email":loginHelper.currentUser.email,
    //         };
    //       print(body);
    //       HttpClientResponse response = await performApiRequest(
    //         body: body,
    //         includeToken: false,
    //         prefix: 'api/login/',
    //         requestType: RequestType.Post
    //       );

    //       if(response.statusCode==200){

    //         token = response.headers.value('token');

    //         isAvailable=token!=null&&token!='';
    //         print('is available $isAvailable with token $token');

    //         setToken(token);

    //         HttpClientResponse getUserResponse = await performApiRequest(
    //           includeToken: true,
    //           prefix: 'api/user/',
    //           requestType: RequestType.Querry
    //         );

    //         if(getUserResponse.statusCode==200){
    //           user = User.fromString(await getUserResponse.transform(utf8.decoder).join());
    //         }else{
    //           print('statur code for getUser is ${getUserResponse.statusCode}');
    //         }

    //       }else{
    //         print('Status code ${response.statusCode}');
    //       }

    //     }catch(err){
    //       print(err);
    //     }

    //     return true;
    //  }else print('users null');
    //  return false;
  }



  Map<int,String> getActions(){
    if(user!=null){
      return user.actions??{};
    }else return {};
  }

  List<int> getInterests(){
    if(user!=null){
      return user.interests??[];
    }else return [];
  }

  List<int> getReminders(){
    if(user!=null){
      return user.remind??[];
    }else return [];
  }

  List<int> getHidedActions(){
    if(user!=null){
      return user.hide??[];
    }else return [];
  }


  int getDifficulty(){
    if(user!=null){
      return user.difficulty??2;
    }else return 2;
  }

  int getEffort(){
    if(user!=null){
      return user.effort??200;
    }else return 200;
  }




  Future<int> setAction(int id, DateTime dateTime)async{
    if(isAvailable){

      HttpClientResponse setActionResponse =await performApiRequest(
        body: {
          "lc": getStringFromDate(dateTime),
        },
        includeToken: true,
        prefix: 'api/user/$id/lc',
        requestType: RequestType.Post
      );
        print(setActionResponse.statusCode);
        print(getStringFromDate(dateTime));
        return setActionResponse.statusCode;

    }else return Future.value(0);
  }

  Future<int> setInterests(List<int> interests)async{
    if(isAvailable){

      HttpClientResponse setActionResponse =await performApiRequest(
        body: {
            "interests": interests,
          },
        includeToken: true,
        prefix: 'api/user/interests',
        requestType: RequestType.Post
      );
      print(setActionResponse.statusCode);
      return setActionResponse.statusCode;

    }else return Future.value(0);
  }

  Future<int> addReminder(int reminderId)async{
    if(isAvailable){

      HttpClientResponse setActionResponse =await performApiRequest(
        body: {
            "id": reminderId,
          },
        includeToken: true,
        prefix: 'api/user/remind',
        requestType: RequestType.Post
      );
        print(setActionResponse.statusCode);
        return setActionResponse.statusCode;

    }else return Future.value(0);
  }

  Future<int> addHidedAction(int hidedAction)async{
    if(isAvailable){

      HttpClientResponse setActionResponse =await performApiRequest(
        body: {
            "id": hidedAction,
          },
        includeToken: true,
        prefix: 'api/user/hide',
        requestType: RequestType.Post
      );
      print(setActionResponse.statusCode);
      return setActionResponse.statusCode;

    }else return Future.value(0);
  }

  Future<int> setDifficulty(int difficulty)async{
    if(isAvailable){

      HttpClientResponse setActionResponse =await performApiRequest(
        body: {
            "difficulty": difficulty,
          },
        includeToken: true,
        prefix: 'api/user/difficulty',
        requestType: RequestType.Post
      );
      print(setActionResponse.statusCode);
      return setActionResponse.statusCode;

    }else return Future.value(0);
  }

  Future<int> setEffort(int effort)async{
    if(isAvailable){

      HttpClientResponse setActionResponse =await performApiRequest(
        body: {
            "effort": effort,
          },
        includeToken: true,
        prefix: 'api/user/effort',
        requestType: RequestType.Post
      );
      print(setActionResponse.statusCode);
      return setActionResponse.statusCode;

    }else return Future.value(0);
  }


  Future<int> deleteAction(int id)async{
    if(isAvailable){

      HttpClientResponse setActionResponse =await performApiRequest(
        includeToken: true,
        prefix: 'api/user/$id/lc',
        requestType: RequestType.Delete
      );
      print(setActionResponse.statusCode);
      return setActionResponse.statusCode;
      
    }else return Future.value(0);
  }

  Future<int> deleteReminder(int reminderId)async{
    if(isAvailable){
      HttpClientResponse setActionResponse =await performApiRequest(
        body: {
          'id':reminderId,
        },
        includeToken: true,
        prefix: 'api/user/remind',
        requestType: RequestType.Delete
      );
      print(setActionResponse.statusCode);
      return setActionResponse.statusCode;

    }else return Future.value(0);
  }

  Future<int> deleteHidedAction(int hidedId)async{
    if(isAvailable){

      HttpClientResponse setActionResponse =await performApiRequest(
        body: {
          'id':hidedId,
        },
        includeToken: true,
        prefix: 'api/user/hide',
        requestType: RequestType.Delete
      );
      print(setActionResponse.statusCode);
      return setActionResponse.statusCode;

    }else return Future.value(0);
  }


  Future<HttpClientResponse> performApiRequest({Map body,@required bool includeToken,@required String prefix,@required RequestType requestType})async{
    HttpClient httpClient = new HttpClient();

    HttpClientRequest request ;

    switch(requestType){
      
      case RequestType.Post:
        request = await httpClient.postUrl(Uri.parse(_url+prefix));
        break;
      case RequestType.Update:
        request = await httpClient.patchUrl(Uri.parse(_url+prefix));
        break;
      case RequestType.Delete:
        request = await httpClient.deleteUrl(Uri.parse(_url+prefix));
        break;
      case RequestType.Querry:
        request = await httpClient.getUrl(Uri.parse(_url+prefix));
        break;
    }

    request.headers.set('content-type', 'application/json');
    if(includeToken){
      request.headers.set('token', token);
    }

    if(body!=null){
      request.add(utf8.encode(json.encode(body)));
    }
    HttpClientResponse response = await request.close();

    return response;
  }


}

enum RequestType{
  Post,
  Update,
  Delete,
  Querry,
}