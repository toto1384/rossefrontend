import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rosse/data/data.dart';
import 'package:rosse/ui/widgets/rosse_scaffold.dart';
import 'package:rosse/utils/get_popup_and_sheets_utils.dart';
import 'package:rosse/utils/get_widget_utils.dart';
import 'package:rosse/utils/values_utils.dart';

import '../../main.dart';

class WelcomePage extends StatefulWidget {
  WelcomePage({Key key}) : super(key: key);

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {

  int currentPage = 0;

  @override
  Widget build(BuildContext buildContext) {
    return WillPopScope(
      onWillPop: (){return Future.value(false);},
      child: FutureBuilder(
          future: Data.initData(buildContext),
          builder: (buildContext,AsyncSnapshot<Data> snapshot) {
            return RosseScaffold(
              MyApp.isEnglish?'Welcome To\nRosse':'Bun venit la rosse',
               primaryItems: <Widget>[
                 getWelcomePresentation(
                  buildContext,
                  currentPage,
                  assetPaths: [AssetsPath.welcome1,AssetsPath.welcome2,AssetsPath.welcome3], 
                  texts: [
                    MyApp.isEnglish?'Get Actionable Steps To Improve Yourself In Biohacking':
                      'Primeste pasi practici pentru a devenii mai bun in biohacking',
                    MyApp.isEnglish?'See How Much You\'ve Improved Yourself In Biohacking':
                      'Vizualizeaza cat de bun esti in biohacking',
                    MyApp.isEnglish?'Simple Documentation With All The Why\'s And How\'s':
                        'Documentatie simpla si completa'
                  ],
                  onPageChanged: (page){
                    setState(() {
                      currentPage=page;
                    });
                  },
                )],
              secondaryItems: <Widget>[
                snapshot.hasData?getSignInWithGoogleButton(buildContext,snapshot.data): CircularProgressIndicator(),
                getInfoButton(MyApp.isEnglish?'What is biohacking?':'Ce este biohacking-ul?', (){
                  showDistivityDialog(
                    context,
                    actions: [getButton(MyApp.isEnglish?'Close':'Inchide', onPressed: ()=>Navigator.pop(context))],
                    title: MyApp.isEnglish?'What is biohacking?':'Ce este biohacking-ul?',
                    stateGetter: (ss,ctx){
                      return getText(MyApp.isEnglish?'Biohacking is the act of optimizing your body for more '
                          'energy, focus, health, cognitive performance and longevity trough habits and diets':
                      'Biohacking-ul este actul de optimizare a corpului pentru mai multa energie, concentrare'
                          ', sanatate, performanta cognitiva si longevitate prin obiceiuri si diete ');
                    }
                  );
                }),
                getInfoButton(MyApp.isEnglish?'Why Rosse?':'De ce Rosse', (){
                  showDistivityDialog(
                    context, 
                    actions: [getButton(MyApp.isEnglish?'Close':'Inchide', onPressed: ()=>Navigator.pop(context))],
                    title: MyApp.isEnglish?'Why Rosse?':'De ce Rosse?',
                    stateGetter: (ctx,ss){
                      return getText(MyApp.isEnglish?'Rosse gives you all the habits(actions) you need to do '
                          'based on your interests and your level to improve yourself in biohacking. These '
                          'actions are well documented and most of the time free to do. \n\nRosse filters '
                          '1000+ hours of documentation in a couple of actionable steps for you to do, so you '
                          'can focus on doing the habit itself, not learning about it':
                      'Rosse iti da toate obiceiurile(actiuni in contextul aplicatiei) care iti trebuie bazate'
                          'pe interesele si vointa ta pentru a devenii mai bun in biohacking. Aceste actiuni'
                          'sunt bine documentate, multe fiind gratis in timp si bani. Rosse filtreaza 1000+ ore'
                          'de documentatie in cativa pasi practici pentru tine, asa ca poti sa iti pui atentia pe'
                          'a face obiceiul, nu pentru a-l invata');
                    }
                  );
                }),
              ],
              isTitleCentered: true,
              secondaryBodyAsFab: true,);
          }
        ),
    );
  }
}