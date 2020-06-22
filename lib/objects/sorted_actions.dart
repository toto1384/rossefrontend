
import 'package:flutter/cupertino.dart';
import 'package:rosse/data/data.dart';
import 'package:rosse/objects/action.dart';
import 'package:rosse/ui/widgets/rosse_action.dart';
import 'package:rosse/utils/get_popup_and_sheets_utils.dart';
import 'package:rosse/utils/get_widget_utils.dart';
import 'package:rosse/utils/typedef_and_enums_utils.dart';
import 'package:rosse/utils/utils.dart';

class SortedActions{

  double effort;

  List<RosseAction> allActionsSorted;
  List<RosseAction> toShowActions;
  List<Interest> interests;
  bool hideCheckedTodos;
  bool progressiveActionShoving;
  RosseAction nextAction;

  double progressiveDifficultyFactor;

  SortedActions({@required List<RosseAction> allActions ,@required double effort,@required ProgressiveActionDifficulty progressiveActionDifficulty,
    @required this.hideCheckedTodos,@required this.interests,@required this.progressiveActionShoving,@required bool insomnia,@required List<int> hidedActions}){

    switch(progressiveActionDifficulty){
      
      case ProgressiveActionDifficulty.Easy:
        progressiveDifficultyFactor = 1;
        break;
      case ProgressiveActionDifficulty.Medium:
        progressiveDifficultyFactor = 1.5;
        break;
      case ProgressiveActionDifficulty.Hard:
        progressiveDifficultyFactor = 2;
        break;
    }
    this.effort = effort * progressiveDifficultyFactor;

    allActions.sort((a,b){
      double aImprovement = a.getImprovement(interests: interests);
      double bImprovement = b.getImprovement(interests: interests);
      return a.effort.compareTo(b.effort)-aImprovement.compareTo(bImprovement);
    });

    this.allActionsSorted= allActions;

    removeHidedActions(hidedActions);

    if(!insomnia)removeInsomniaActions();

    this.toShowActions= getToDisplayActions();
  }

  removeHidedActions(List<int> hidedActions){
    List toRemove = List();
    allActionsSorted.forEach((item){
      if(hidedActions.contains(item.id)){
        toRemove.add(item);
      }
    });
    toRemove.forEach((item){
      allActionsSorted.remove(item);
    });
  }

  removeInsomniaActions(){
    List toRemove = List();
    allActionsSorted.forEach((item){
      if(item.type==type_insomnia){
        toRemove.add(item);
      }
    });
    toRemove.forEach((item){
      allActionsSorted.remove(item);
    });
  }

  resetDisplayedActions(double neweffort){
    effort = neweffort*progressiveDifficultyFactor;
    toShowActions= getToDisplayActions();
  }

  checkIfEmptyPopup(BuildContext context){
    if(!hideCheckedTodos){
      bool show = true;
      toShowActions.forEach((item){
        if(!item.checked){
          show=false;
        }
      });
      if(show){
        bool finished = false;
        showDistivityModalBottomSheet(context, (ctx,ss){
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              getEmptyView(
                MediaQuery.of(context).size.width-60,
                finished,
                (){
                  ss((){
                    finished=true;
                  });
                }
              ),
              getPadding( getButton('Close', onPressed: ()=>Navigator.pop(context)),vertical: 20)
            ],
          );
        });
      }
    }
  }

  List<RosseAction> getToDisplayActions({double thisEffort}){
    if(thisEffort==null){
      thisEffort=effort;
    }

    if(!progressiveActionShoving){
      List<RosseAction> toreturn = List();
      toreturn.addAll(allActionsSorted);
      if(hideCheckedTodos)toreturn=removeListCheckedActions(toreturn);
      return toreturn;
    }else{
      List<RosseAction> toreturn = List();

      for(int i = 0; i<allActionsSorted.length;i++){
        RosseAction item = allActionsSorted[i];

        if(item.effort<effort){
          effort = effort - item.effort;
          toreturn.add(item);
        }else{
          nextAction=item;
          break;
        }
      }
      if(hideCheckedTodos)toreturn = removeListCheckedActions(toreturn);

      return toreturn;
    }
    
  }


  showSheetIfOneMoreActionAndAddEffort({@required  int ind,@required BuildContext context,@required Data data,Function(double) ifCanAddNewAction})async{
    double actionEffortIncrease = (toShowActions[ind].effort)/15;
    double initialUserEffort= data.getEffort().toDouble();

    if(toShowActions[ind].checked){
      //update to db and the object
      await data.setEffort(initialUserEffort+actionEffortIncrease);
      effort = effort + actionEffortIncrease;
      //
      print(actionEffortIncrease);
      print(effort);
      if(progressiveActionShoving){
        double nextActionEffort = nextAction.effort.toDouble();
        
        //if can add new action
        print(nextActionEffort);
        if(nextActionEffort<effort){
          showDistivityModalBottomSheet(
            context, 
            (ctx,ss){
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    getPadding(getText('You\'ve unlocked a new action',textType: TextType.textTypeTitle,maxLines: 3,)),
                    RosseActionWidget(
                      action: nextAction, 
                      onActionUpdated: (act){}, 
                      interests: interests,
                      onActionHided: (){},
                    )
                  ],
                ),
              );
            }
          );
          ifCanAddNewAction(initialUserEffort+actionEffortIncrease);
        }
      }
    }else{
      //update to db and the object
      await data.setEffort(initialUserEffort-actionEffortIncrease);
      effort = effort - actionEffortIncrease;
      //
    }
  }




}