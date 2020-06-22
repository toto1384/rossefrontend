import 'dart:convert';

import 'package:flutter/cupertino.dart';

class User{

  String id;
  List<int> hide;
  List<int> remind;
  Map<int,String> actions;
  List<int> interests;
  int difficulty;
  int effort;

  User({@required this.id,@required this.hide,@required this.remind,@required this.actions, @required this.interests,@required this.difficulty, @required this.effort});

  static User fromString(String string){
    Map map = jsonDecode(string);

    List unProcessedRemind = map['remind'];
    List<int> processedRemind = List.generate(unProcessedRemind.length, (ind){
      return unProcessedRemind[ind];
    });

    List unProcessedHide = map['hide'];
    List<int> processedHide = List.generate(unProcessedHide.length, (ind){
      return unProcessedHide[ind];
    });

    List unProcessedInterests = map['interests'];
    List<int> processedInterests = List.generate(unProcessedInterests.length, (ind){
      return unProcessedInterests[ind];
    });

    List unProcessedActions = map['actions'];

    Map<int,String> processedActions = Map();

    unProcessedActions.forEach((item){
      processedActions[item["id"]]= item["lc"];
    });


    print(map);

    return User(
      actions: processedActions,
      hide: processedHide,
      id: map['id'],
      interests: processedInterests,
      remind: processedRemind,
      difficulty: map['difficulty'],
      effort: map['effort'],
    );

  }

}