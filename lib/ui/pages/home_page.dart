import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:launch_review/launch_review.dart';
import 'package:rosse/data/data.dart';
import 'package:rosse/icon_pack_icons.dart';
import 'package:rosse/main.dart';
import 'package:rosse/objects/action.dart';
import 'package:rosse/objects/sorted_actions.dart';
import 'package:rosse/ui/pages/iap_page.dart';
import 'package:rosse/ui/pages/interests_page.dart';
import 'package:rosse/ui/pages/settings_page.dart';
import 'package:rosse/ui/pages/welcome_page.dart';
import 'package:rosse/ui/widgets/animated_percent_indicator.dart';
import 'package:rosse/ui/widgets/rosse_action.dart';
import 'package:rosse/ui/widgets/rosse_scaffold.dart';
import 'package:rosse/utils/get_popup_and_sheets_utils.dart';
import 'package:rosse/utils/get_widget_utils.dart';
import 'package:rosse/utils/typedef_and_enums_utils.dart';
import 'package:rosse/utils/utils.dart';
import 'package:soundpool/soundpool.dart';

class HomePage extends StatefulWidget {
  final bool uncheckEverything;
  final bool showBeginingPopup;
  HomePage({Key key,this.uncheckEverything,this.showBeginingPopup}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> with SingleTickerProviderStateMixin,AfterLayoutMixin {

  static SortedActions actions;
  Data data;
  List<Interest> interests;
  bool isFinished = false;

  init(BuildContext context)async{

    if(data==null){
      data= await Data.initData(context);
      data.incrementTimesOpened();
    }

    if(actions==null){
      actions = SortedActions(
        allActions: getHardCodedActions(data),
        effort: data.getEffort().toDouble(),
        progressiveActionDifficulty: data.getProgressiveActionDifficulty(),
        hideCheckedTodos: data.getHideCheckedActions(),
        interests: data.getInterests(),
        progressiveActionShoving: data.getProgressiveDifficultyShoving(),
        insomnia: data.getInsomnia(),
        hidedActions: data.getHidedActions(),
      );
    }

    if(interests==null){
      interests = data.getInterests();
    }
    return true;
  }

  void checkSubscription()async {
//    if(!(await data.getIapHelper().isSubscriptionActive())){
//      launchPage(context, IAPScreen(iapHelper: data.getIapHelper(),));
//    }
  }

  @override
  void afterFirstLayout(BuildContext context)async {
    await init(context);
    checkSubscription();
//    if(data.getLoginHelper().currentUser==null){
//      launchPage(context, WelcomePage());
//    }
    if(data.getInterests().length==0){
      launchPage(context, InterestsPage(firstTime: true,));
    }
    if(widget.uncheckEverything??false){
      uncheckEverything();
    }
    if(widget.showBeginingPopup??false){
      showDistivityDialog(
        context, 
        actions: [getButton(MyApp.isEnglish?'Let\'s go':"Sa incepem", onPressed: ()=>Navigator.pop(context))],
        title: MyApp.isEnglish?'One more thing':"Inca ceva",
        stateGetter: (ctx,ss){
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              getText(
                  MyApp.isEnglish?'For now on, you have the following ${actions.toShowActions.length} '+
                      'actions to complete. If you feel something doesn\'t work for you you can hide it'+
                          ' anytime. \n\nWhy you have only ${actions.toShowActions.length} actions? '
                              'Because it\'s better to start small, and Rosse already build a custom '
                              'journey for you. As you complete more actions and you increase your willpower,'
                              ' you will unlock new actions. If you don\'t like it this way you can always'
                              ' turn it off from the settings':
              "De acum, ai urmatoarele ${actions.toShowActions.length} actiuni sa completezi. Daca simti ca"
                  "ceva nu functioneaza pentru tine, poti sa il ascunzi oricand. \n\nDe ce ai doar"
                  " ${actions.toShowActions.length} actiuni? Deoarece este mai bine sa incepi usor, iar"
                  "Rosse deja a construit deja o calatorie speciala tie. Cu cat reusesti sa faci mai multe"
                  "actiuni si cu cat iti inbunatatesti vointa, o sa deblochezi actiuni noi. Daca nu iti place"
                  "aceasta metoda, poti mereu sa o dezactivezi din setari"),
            ],
          );
        }
      );
    }

  }


  @override
  void dispose() { 
    controller.dispose();
    super.dispose();
  }
  

  Animation<double> animation;
  AnimationController controller;
  bool check = false;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 1), vsync: this);
    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);
    controller.forward();
  }
  
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: init(context),
      builder: (ctx,snap){
        return RosseScaffold(
          MyApp.isEnglish?'Actions':"Actiuni",
          primaryItems:[
            snap.hasData?getActionListView():Center(child: CircularProgressIndicator(),)
          ],
          secondaryItems:[
            snap.hasData?AnimatedPercentIndicator(value: getOptimizedPercent().toDouble(), animation: animation):Center(child: CircularProgressIndicator(),)
          ],
          secondaryBodyAlwaysRed: true,
          onMorePressed: (){
            showMoreBottomSheet();
          },
        );
      },
    );
  }

  Widget getActionListView(){

    Soundpool pool = Soundpool(streamType: StreamType.notification);
    
    Widget toReturn;
    if(actions==null||actions.toShowActions.length==0){

      toReturn = getEmptyView(MediaQuery.of(context).size.width-60,isFinished,(){
        setState(() {
          isFinished=true;
        });
      });
    }else{
      toReturn = Column(
        mainAxisSize: MainAxisSize.min,
        children: List<Widget>.generate(actions.toShowActions.length, (ind){
          return RosseActionWidget(
            index: ind, 
            interests: interests,
            action: actions.toShowActions[ind], 
            onActionUpdated: (newaction)async{

              check = true;
              setState(() {
                actions.toShowActions[ind] = newaction;
              });

              controller.reset();
              controller.forward();

              if(newaction.checked){
                await data.setLastChecked(actions.toShowActions[ind].id, newaction.lastChecked);
              }else{
                await data.removeLastChecked(actions.toShowActions[ind].id);
              }

            }, 
            onAnimationCompleted: (i,v){
              print('$check');
              if(check){
                setState(() {
                  check=false;
                  if(actions.hideCheckedTodos){
                    if(v){
                      actions.toShowActions.removeAt(i);
                    }
                  }
                });
                actions.checkIfEmptyPopup(context);

                actions.showSheetIfOneMoreActionAndAddEffort( ind: ind, context: context,data: data,ifCanAddNewAction: (neweffort){
                  setState(() {
                    actions = null;
                    init(context);
                  });
                });
                
              }
            },
            soundpool: pool,
            onActionHided: ()async{
              Navigator.pop(context);
              RosseAction removed;
              setState(() {
                removed =  actions.toShowActions.removeAt(ind);
                actions.allActionsSorted.remove(removed);
              });
              await data.addHidedAction(removed.id);
              actions=null;
              init(context);
              setState(() {
                
              });

            },
          );

        })+<Widget>[
          actions.progressiveActionShoving?Center(
            child: getPadding(getText(
                MyApp.isEnglish?"You need to complete more actions to unlock new ones."
                    " You can deactivate this in the settings":
                "Trebuie sa completezi mai multe actiuni pentru a debloca altele. Poti dezactiva asta in setari",
                isCentered: true,maxLines: 7)),
          ):Center(),
        ],
      );
    }
      
    return toReturn;
  }

  uncheckEverything(){
    setState(() {
      for(int i = 0 ; i<actions.allActionsSorted.length ; i++){
        actions.allActionsSorted[i].checked=false;
        data.removeLastChecked(actions.allActionsSorted[i].id);
      }
    });
  }

  double getOptimizedPercent(){
    double percent = 0;

    if(actions!=null){
      actions.allActionsSorted.forEach((action){
        if(action.checked??false){
          percent = percent+ action.getImprovement(interests: interests).toDouble();
        }
      });
    }

    return percent;
  }

  void showMoreBottomSheet() {
    showDistivityModalBottomSheet(context, (ctx,ss){
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: getIcon(IconPack.settings),
              title: getText(MyApp.isEnglish?'Settings':"Setari"),
              onTap: (){
                Navigator.pop(context);
                launchPage(context, SettingsPage());
                
              }
            ),
            ListTile(
              leading: getIcon(IconPack.feedback),
              title: getText(MyApp.isEnglish?'Send feedback':"Trimite-mi parerea ta"),
              onTap: (){
                showFeedbackBottomSheet(context);
              },
            ),
            ListTile(
              leading: getIcon(IconPack.stars),
              title: getText(MyApp.isEnglish?'Rate app :))':"Da o nota aplicatiei"),
              onTap: ()=>LaunchReview.launch(),
            ),
            ListTile(
              leading: getIcon(IconPack.send),
              title: getText(MyApp.isEnglish?'Share app with a friend':"Impartaseste aplicatia cu un prieten"),
              onTap: (){shareApp();},
            ),
//            ListTile(
//              leading: getIcon(IconPack.logout),
//              title: getText('Log out!'),
//              onTap: (){
//                data.getLoginHelper().signOut();
//                launchPage(context, WelcomePage());
//              },
//            ),
            getPadding(getText('Rosse 0.8.0')),
          ],
        ),
      );
    });
  }
}