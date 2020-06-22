import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rosse/data/data.dart';
import 'package:rosse/ui/pages/home_page.dart';
import 'package:rosse/ui/widgets/rosse_radio_group.dart';
import 'package:rosse/ui/widgets/rosse_scaffold.dart';
import 'package:rosse/utils/get_popup_and_sheets_utils.dart';
import 'package:rosse/utils/get_widget_utils.dart';
import 'package:rosse/utils/typedef_and_enums_utils.dart';
import 'package:rosse/utils/utils.dart';

import '../../main.dart';

class InterestsPage extends StatefulWidget {
  final bool firstTime;
  InterestsPage({Key key,@required this.firstTime}) : super(key: key);

  @override
  _InterestsPageState createState() => _InterestsPageState();
}

class _InterestsPageState extends State<InterestsPage> {

  

  Map<String,bool> items ={
    MyApp.isEnglish?'Cognitive Performance':"Performanta Cognitiva" : true,
    MyApp.isEnglish?'Energy':"Energie": false,
    MyApp.isEnglish?'Health/Longevity':"Sanatate/Longevitate" : false,
  };
  bool hasInit = false;

  bool insomnia = false;

  ProgressiveActionDifficulty progressiveActionDifficulty = ProgressiveActionDifficulty.Easy;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){return Future.value(false);},
      child: FutureBuilder(
        future: Data.initData(context),
        builder: (context,AsyncSnapshot<Data> snapshot) {
          if(snapshot.hasData&&!hasInit){
            hasInit=true;
            List<Interest> interests = snapshot.data.getInterests();
            items = {
              MyApp.isEnglish?'Cognitive Performance':"Performanta Cognitiva" :
                interests.contains(Interest.Brain),
              MyApp.isEnglish?'Energy':"Energie": interests.contains(Interest.Energy),
              MyApp.isEnglish?'Health/Longevity':"Sanatate/Longevitate" : interests.contains(Interest.Health),
            };
            progressiveActionDifficulty = snapshot.data.getProgressiveActionDifficulty();
            insomnia =  snapshot.data.getInsomnia();
          }
          return RosseScaffold(
            MyApp.isEnglish?'Your interests &\nDifficulty':"Interesele si dificultatea ta",
             isTitleCentered: true,
             primaryItems: <Widget>[
               getPadding(getText(
                   MyApp.isEnglish?'What do you want to improve on?':
                    "La ce vrei sa devii mai bun?",textType: TextType.textTypeSubtitle),),
               RosseRadioGroup(
                 items: items,
                 isBig: true,
                 onSelected: (ind,str){
                   setState(() {
                     items[str] = !items[str];
                   });
                }),
                getPadding(getText('Difficulty',textType: TextType.textTypeSubtitle),),
                RosseRadioGroup(
                  items: {
                    MyApp.isEnglish?'Easy':"Usor" : progressiveActionDifficulty==ProgressiveActionDifficulty.Easy,
                    MyApp.isEnglish?'Medium':"Mediu" : progressiveActionDifficulty == ProgressiveActionDifficulty.Medium,
                    MyApp.isEnglish?'Hard':'Greu' : progressiveActionDifficulty == ProgressiveActionDifficulty.Hard,
                  },
                  isBig: false, 
                  onSelected: (ind,key){
                    setState(() {
                      switch(ind){
                        case 0 : progressiveActionDifficulty = ProgressiveActionDifficulty.Easy;break;
                        case 1 : progressiveActionDifficulty = ProgressiveActionDifficulty.Medium;break;
                        case 2 : progressiveActionDifficulty = ProgressiveActionDifficulty.Hard;break;
                      }
                    });
                  }
                ),
                Divider(),
                getPadding(
                  ListTile(
                    leading: getFlareCheckbox(insomnia,onTap: (){
                      setState(() {
                        insomnia=!insomnia;
                      });
                    }),
                    title: getText(MyApp.isEnglish?"I have trouble falling asleep":"Mi-e greu sa adorm"),
                  ),
                )

             ],
            secondaryItems: <Widget>[
              Center(
                child: snapshot.hasData?getButton(
                  widget.firstTime?MyApp.isEnglish?'Start':"Incepe":MyApp.isEnglish?'Save':"Salveaza",
                  onPressed: (){

                    List<Interest> interests = [];
                    items.forEach((k,v){
                      if(v==true){
                        if(k==(MyApp.isEnglish?'Cognitive Performance':"Performanta Cognitiva")){
                          interests.add(Interest.Brain);
                        }if(k==(MyApp.isEnglish?'Energy':"Energie")){
                          interests.add(Interest.Energy);
                        }if(k==(MyApp.isEnglish?'Health/Longevity':"Sanatate/Longevitate")){
                          interests.add(Interest.Health);
                        }
                      }
                    });

                    Function saveInterestsAndLaunchHome = ({bool f})async{
                        if(snapshot.hasData){
                          snapshot.data.setInterests(interests);
                          snapshot.data.setProgressiveActionDifficulty(progressiveActionDifficulty);
                          snapshot.data.setInsomnia(insomnia);
                        }
                        HomePageState.actions=null;
                        launchPage(context, HomePage(uncheckEverything: f,showBeginingPopup: !(f??true),));
                    };
                    if(interests.length==0){
                      showDistivityModalBottomSheet(context, (ctx,ss){
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            getPadding(getText(
                                MyApp.isEnglish?'Come on. You need to be interested in something. Select 1 or more interests'
                                    ' so we can filter some actions just for you':"Selecteaza unul sau mai multe"
                                    "insterese deoarece trebuie sa iti filtram niste actiuni doar pentru tine!",
                                isCentered:true,textType: TextType.textTypeSubtitle)),
                            getPadding(getButton(MyApp.isEnglish?'Set interests':'Seteaza interesele',
                                onPressed: ()=>Navigator.pop(context))),
                          ],
                        );
                      });
                    }else{
                      if(widget.firstTime){
                        saveInterestsAndLaunchHome();
                      }else{
                        showDistivityModalBottomSheet(context, (ctx,ss){
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              getPadding(getText(MyApp.isEnglish?'All your actions will be unchecked and you'
                                  ' will get new ones, but keep in mind that you will not start again from scratch':
                                  "Toate actiunile tale vor fii deverificate si vei primi altele noi, dar tine"
                                      "minte ca nu o vei lua de la capat",
                                  isCentered: true,textType: TextType.textTypeSubtitle),),
                              getPadding(getButton(MyApp.isEnglish?'Close':'Inchide', onPressed: ()async{
                                saveInterestsAndLaunchHome(f:true);
                              })),
                            ],
                          );
                        });
                      }
                    }

                  },
                ):CircularProgressIndicator(),
              )
            ],
            secondaryBodyAsFab: true,
          );
        }
      ),
    );
  }
}