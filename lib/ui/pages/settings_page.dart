import 'package:flutter/material.dart';
import 'package:rosse/data/data.dart';
import 'package:rosse/icon_pack_icons.dart';
import 'package:rosse/main.dart';
import 'package:rosse/ui/pages/hided_actions_page.dart';
import 'package:rosse/ui/pages/home_page.dart';
import 'package:rosse/ui/pages/interests_page.dart';
import 'package:rosse/ui/widgets/rosse_scaffold.dart';
import 'package:rosse/ui/widgets/rosse_setting_tile.dart';
import 'package:rosse/utils/get_widget_utils.dart';
import 'package:rosse/utils/typedef_and_enums_utils.dart';
import 'package:rosse/utils/utils.dart';

class SettingsPage extends StatefulWidget {

  SettingsPage({Key key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Data.initData(context),
      builder: (context,AsyncSnapshot<Data> snapshot) {

        return RosseScaffold(
          'Settings', 
          primaryItems: [
            getPadding(getText('General',textType: TextType.textTypeSubtitle,underline: true)),
            getSwitchable(text: MyApp.isEnglish?'Dark Mode':'Tema intunecata',
              checked: MyApp.isDarkMode, 
              onCheckedChanged: (val)async{
                if(snapshot.hasData){
                  await snapshot.data.setDarkMode();
                  MyApp.restartApp(context);
                  setState(() {
                    
                  });
                }
              }, 
              isCheckboxOrSwitch: false,
            ),
            getPadding(getText(MyApp.isEnglish?'Actions':'Actiuni',textType: TextType.textTypeSubtitle,underline: true)),
            RosseSettingTile(
              checked: (data){
                return data.getHideCheckedActions();
              }, 
              onChange: (data,val)async{
                await data.setHideCheckedActions(val);
                HomePageState.actions=null;
              }, 
              snapshot: snapshot, 
              text: MyApp.isEnglish?'Hide checked todos':'Ascunde actiunile verificate',
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                leading: getIcon(IconPack.close),
                title: getText(MyApp.isEnglish?'Manage hided actions':'Administreaza actiunile ascunse'),
                onTap: (){
                  if(snapshot.hasData){
                    launchPage(context, HidedActionsPage(data: snapshot.data));
                  }
                },
              ),
            ),
            getPadding(getText(MyApp.isEnglish?'Progressive action shoving && Interests':'Prezentarea actiunilor'
                'progresiv & Interesele tale',textType: TextType.textTypeSubtitle,maxLines: 3,underline: true)),
            RosseSettingTile(
              checked: (data){
                return data.getProgressiveDifficultyShoving();
              },
              onChange: (data,val)async{
                await data.setProgressiveDifficultyShoving(val);
                HomePageState.actions=null;
              }, 
              snapshot: snapshot, 
              text: MyApp.isEnglish?'Progressive Action Shoving':'Prezentarea actiunilor progresiv',
              info: MyApp.isEnglish?'If this setting is on, Rosse will generate a set number of actions'
                  ' based on your interests, difficulty and your willpower, and you will unlock more actions'
                  ' as you complete the ones you already have.\n\nIf this setting is off, you will get ALL'
                  ' the actions from Rosse sorted by your interests and how efficient they are. This is not'
                  ' recomended':'Daca aceasta setare este activata, Rosse v-a genera un numar limitat de actiuni'
                  'la inceput, bazate pe interesele tale, dificultate si vointa ta. Pe parcurs, o sa deblochezi'
                  'mai multe actiuni in concordanta cu actiunile pe care le completezi. Daca aceasta setare este'
                  'dezactivata, o sa primesti TOATE actiunile din Rosse, sortate cu ajutorul intereselor tale si'
                  'cat de eficiente sunt actiunile. Nu este recomandat totusi.',
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                leading: getIcon(IconPack.carret_up),
                title: getText('Set Interests and Difficulty'),
                onTap: (){launchPage(context, InterestsPage(firstTime: false,));},
              ),
            ),
          ], 
          secondaryItems: [],
          backEnabled: true,
          isTitleCentered: true,
        );
      }
    );
  }
}